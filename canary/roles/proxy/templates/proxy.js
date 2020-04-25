var http = require("http");
var httpProxy = require("http-proxy");
var request = require("request");
var fs = require("fs");
const child = require("child_process");
const redis = require("redis");

let time = 0;
let now = Date.now();
var proxy = httpProxy.createProxyServer({});

let blue_ip = "192.168.33.30";
let green_ip = "192.168.33.40";

var t = 300000;

var servers = [
  { name: "blue", url: `http://${blue_ip}:3000`, status: 0, scoreTrend: [], latency: 5000, pass: 0, fail: 0, cpuPass: 0, cpuFail: 0, memPass: 0, memFail: 0, statusPass: 0, statusFail: 0, latencyPass: 0, latencyFail: 0},
  { name: "green", url: `http://${green_ip}:3000`, status: 0, scoreTrend: [], latency: 5000, pass: 0, fail: 0, cpuPass: 0, cpuFail: 0, memPass: 0, memFail: 0, statusPass: 0, statusFail: 0, latencyPass: 0, latencyFail: 0}
];

function fileread(filename) {
  var contents = fs.readFileSync(filename).toString();
  return contents;
}

const options = {
  hostname: "192.168.33.50",
  port: 3000,
  path: "/preview",
  method: "POST",
  headers: {
    "Content-Type": "application/json",
  },
};

function updateHealth(server) {
  let score = 0;
  if (server.memoryLoad < 25.0){
    score += 1;
    server.memPass += 1;
  }
  else {
    server.memFail += 1;
  }

  if (server.cpu < 25.0){
    score += 1;
    server.cpuPass += 1;
  }
  else {
    server.cpuFail += 1;
  }

  if (server.latency < 100){
    score += 1;
    server.latencyPass += 1;
  }
  else {
    server.latencyFail += 1;
  }

  if (server.status === 200){
    score += 3;
    server.statusPass += 1;
  }
  else {
    server.statusFail += 1;
  }

  if (score>3){
    server.pass += 1;
  }
  else{
    server.fail += 1;
  }
}

function main() {
  let latency_now = Date.now();
  var data = fileread("/home/vagrant/resources/survey.json");
  var post_req = http.request(options, function (res) {
    res.setEncoding("utf8");
    if (time < t) {
      servers[0].latency = Date.now() - latency_now;
      servers[0].status = res.statusCode;
    } else {
      servers[1].latency = Date.now() - latency_now;
      servers[1].status = res.statusCode;
    }
    res.on("data", function (chunk) {});
  });

  post_req.write(data);
  post_req.end();

  let client = redis.createClient(6379, "localhost", {});
  for (var server of servers) {
    // The name of the server is the name of the channel to recent published events on redis.
    client.subscribe(server.name);
  }
  // When an agent has published information to a channel, we will receive notification here.
  client.on("message", function (channel, message) {
    for (var server of servers) {
      // Update our current snapshot for a server's metrics.
      if (server.name == channel) {
        if ((server.name == 'blue' && time < t) ||
            (server.name == 'green' && t <= time  && time < 2*t)){
          let payload = JSON.parse(message);
          server.memoryLoad = payload.memoryLoad;
          server.cpu = payload.cpu;
          updateHealth(server);
        }

      }
    }
  });
}

http
  .createServer(function (req, res) {
    if (time < t) {
      proxy.web(req, res, { target: `http://${blue_ip}:3000/` });
    } else if (time >= t && time < 2*t) {
      proxy.web(req, res, { target: `http://${green_ip}:3000/` });
    } else {
      console.log("Finish");
      let blueServerPP = servers[0].pass/(servers[0].pass + servers[0].fail);
      let greenServerPP = servers[1].pass/(servers[1].pass + servers[1].fail);

      if ( blueServerPP > 0.8 && greenServerPP > 0.8){
        var content = "Canary Passed";
        fs.writeFileSync("/home/vagrant/canaryAnalysis.txt", content);
        console.log(content);
      }
      else {
        let blueServerCPU = servers[0].cpuPass * 100 / (servers[0].cpuFail + servers[0].cpuPass);
        let greenServerCPU = servers[1].cpuPass * 100 / (servers[1].cpuFail + servers[1].cpuPass);
        let blueServerMem = servers[0].memPass * 100 / (servers[0].memFail + servers[0].memPass);
        let greenServerMem = servers[1].memPass * 100 / (servers[1].memFail + servers[1].memPass);
        let blueServerStat = servers[0].statusPass * 100 / (servers[0].statusFail + servers[0].statusPass);
        let greenServerStat = servers[1].statusPass * 100 / (servers[1].statusFail + servers[1].statusPass);
        let blueServerLat = servers[0].latencyPass * 100 / (servers[0].latencyFail + servers[0].latencyPass);
        let greenServerLat = servers[1].latencyPass * 100 / (servers[1].latencyFail + servers[1].latencyPass);
        blueServerPP *= 100;
        greenServerPP *= 100;
        var content = "============= CANARY REPORT ============\n";
        content += "-------- Statistical Difference --------\n";
        content += `\nCPU Utilization < 25% (expressed in percentage)\n\tBLUE SERVER: ${blueServerCPU} \tGREEN SERVER: ${greenServerCPU}`;
        content += `\nMemory Utilization < 25% (expressed in percentage)\n\tBLUE SERVER: ${blueServerMem} \tGREEN SERVER: ${greenServerMem}`;
        content += `\nLatency < 100ms (expressed in percentage)\n\tBLUE SERVER: ${blueServerLat} \tGREEN SERVER: ${greenServerLat}`;
        content += `\nStatus == 200 (expressed in percentage)\n\tBLUE SERVER: ${blueServerStat} \tGREEN SERVER: ${greenServerStat}`;
        content += `\nCanary Pass %\n\tBLUE SERVER: ${blueServerPP} \tGREEN SERVER: ${greenServerPP}`;
        content += "\n\n-------------------------------------\n";
        content += `\n\n!!!!!!!CANARY FAIL!!!!!!!\n`;

        fs.writeFileSync("/home/vagrant/canaryAnalysis.txt", content);
        console.log(content);

      }
      process.exit(0);
    }
  })
  .listen(3000);

var heartbeatTimer = setInterval(function () {
  main();
  time = Date.now() - now;
}, 1000);
