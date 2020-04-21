var http = require("http");
var httpProxy = require("http-proxy");
var request = require("request");
var fs = require("fs");
const child = require("child_process");

let count = 0;
let time = 0;
let now = Date.now();
var proxy = httpProxy.createProxyServer({});

let blue_ip = "192.168.33.30";
let green_ip = "192.168.33.40";

console.log(blue_ip);
console.log(green_ip);

function fileread(filename) {
  var contents = fs.readFileSync(filename).toString();
  return contents;
}

const options = {
  hostname: "localhost",
  port: 3000,
  path: "/preview",
  method: "POST",
  headers: {
    "Content-Type": "application/json",
  },
};

function main() {
  var data = fileread("./resources/survey.json");
  var post_req = http.request(options, function (res) {
    res.setEncoding("utf8");
    console.log("Response from backend is " + res.statusCode);
    res.on("data", function (chunk) {});
  });

  post_req.write(data);
  post_req.end();
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
