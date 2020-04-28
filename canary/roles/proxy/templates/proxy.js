var http = require("http");
var httpProxy = require("http-proxy");
var request = require("request");
var fs = require("fs");
const child = require("child_process");
const redis = require("redis");
var mwu = require("mann-whitney-utest");

let time = 0;
let now = Date.now();
var proxy = httpProxy.createProxyServer({});

let blue_ip = "192.168.33.30";
let green_ip = "192.168.33.40";

var t = 5000;

var servers = [
  {
    name: "blue",
    url: `http://${blue_ip}:3000`,
    status: 0,
    scoreTrend: [],
    cpuTrend: [],
    memoryTrend: [],
    latencyTrend: [],
    statusTrend: [],
    latency: 5000,
  },
  {
    name: "green",
    url: `http://${green_ip}:3000`,
    status: 0,
    scoreTrend: [],
    cpuTrend: [],
    memoryTrend: [],
    latencyTrend: [],
    statusTrend: [],
    latency: 5000,
  },
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
  server.cpuTrend.push(server.cpu);
  server.memoryTrend.push(server.memoryLoad);
  server.latencyTrend.push(server.latency);
  server.statusTrend.push(server.status);
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
        if (
          (server.name == "blue" && time < t) ||
          (server.name == "green" && t <= time && time < 2 * t)
        ) {
          let payload = JSON.parse(message);
          server.memoryLoad = payload.memoryLoad;
          server.cpu = payload.cpu;
          updateHealth(server);
        }
      }
    }
  });
}

function calculateMWU(samples) {
  var u = mwu.test(samples);
  if (mwu.significant(u, samples)) {
    return 0;
  } else {
    return 1;
  }
}

http
  .createServer(function (req, res) {
    if (time < t) {
      proxy.web(req, res, { target: `http://${blue_ip}:3000/` });
    } else if (time >= t && time < 2 * t) {
      proxy.web(req, res, { target: `http://${green_ip}:3000/` });
    } else {
      var score = 0;
      var cpulen = Math.min(
        servers[0].cpuTrend.length,
        servers[1].cpuTrend.length
      );
      var memlen = Math.min(
        servers[0].memoryTrend.length,
        servers[1].memoryTrend.length
      );
      var latencylen = Math.min(
        servers[0].latencyTrend.length,
        servers[0].latencyTrend.length
      );
      var statuslen = Math.min(
        servers[0].statusTrend.length,
        servers[1].statusTrend.length
      );

      var cpuTest = calculateMWU([
        servers[0].cpuTrend.slice(0, cpulen),
        servers[1].cpuTrend.slice(0, cpulen),
      ]);
      var memTest = calculateMWU([
        servers[0].memoryTrend.slice(0, memlen),
        servers[1].memoryTrend.slice(0, memlen),
      ]);
      var latTest = calculateMWU([
        servers[0].latencyTrend.slice(0, latencylen),
        servers[1].latencyTrend.slice(0, latencylen),
      ]);
      var statTest = calculateMWU([
        servers[0].statusTrend.slice(0, statuslen),
        servers[1].statusTrend.slice(0, statuslen),
      ]);

      score += cpuTest;
      score += memTest;
      score += latTest;
      score += 3 * statTest;

      let cpuFlag = cpuTest == 1 ? "Pass" : "Fail";
      let memFlag = memTest == 1 ? "Pass" : "Fail";
      let latFlag = latTest == 1 ? "Pass" : "Fail";
      let statFlag = statTest == 1 ? "Pass" : "Fail";

      if (score > 3) {
        var content = "Canary Passed";
        fs.writeFileSync("/home/vagrant/canaryAnalysis.txt", content);
        console.log(content);
      } else {
        var content = "============= CANARY REPORT ============\n";
        content += "-------- Statistical Difference --------\n";
        content += `\nCPU Utilization:\n\tStatus: ${cpuFlag}`;
        content += `\nMemory Utilization:\n\tStatus: ${memFlag}`;
        content += `\nLatency:\n\tStatus : ${latFlag}`;
        content += `\nApp Status:\n\tStatus: ${statFlag}`;
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
