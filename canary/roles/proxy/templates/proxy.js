var http = require("http");
var httpProxy = require("http-proxy");
var request = require("request");
var fs = require("fs");
const child = require("child_process");
const redis = require("redis");

let count = 0;
let time = 0;
let now = Date.now();
var proxy = httpProxy.createProxyServer({});

let blue_ip = "192.168.33.30";
let green_ip = "192.168.33.40";

console.log(blue_ip);
console.log(green_ip);

var servers = [
  { name: "blue", url: `http://${blue_ip}:3000`, status: 0, scoreTrend: [] },
  { name: "green", url: `http://${green_ip}:3000`, status: 0, scoreTrend: [] },
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

  score += server.memoryLoad < 25.0 ? 1 : 0;
  score += server.cpu < 25.0 ? 1 : 0;
  score += server.latency < 100 ? 1 : 0;
  score += server.status === 200 ? 1 : 0;

  server.scoreTrend.push(score);
  console.log(server.memoryLoad);
  console.log(server.cpu);
  console.log(server.latency);
  console.log(server.status);
}

function main() {
  var data = fileread("/home/vagrant/resources/survey.json");
  var post_req = http.request(options, function (res) {
    res.setEncoding("utf8");
    console.log("Response from backend is " + res.statusCode);
    if (time < 5000) {
      servers[0].status = res.statusCode;
    } else {
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
    console.log(`Received message from agent: ${channel}`);
    for (var server of servers) {
      // Update our current snapshot for a server's metrics.
      if (server.name == channel) {
        let payload = JSON.parse(message);
        server.memoryLoad = payload.memoryLoad;
        server.cpu = payload.cpu;
        updateHealth(server);
      }
    }
  });
}

http
  .createServer(function (req, res) {
    console.log("time is" + time);
    if (time < 5000) {
      proxy.web(req, res, { target: `http://${blue_ip}:3000/` });
      //console.log("hello master");
    } else if (time >= 5000 && time < 10000) {
      proxy.web(req, res, { target: `http://${green_ip}:3000/` });
      //console.log("hello canary");
    } else {
      process.exit(0);
      console.log("Finish");
    }
    //console.log(res.statusCode);
  })
  .listen(3000);

var heartbeatTimer = setInterval(function () {
  main();
  time = Date.now() - now;
}, 500);
