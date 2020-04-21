var http = require("http");
var httpProxy = require("http-proxy");
var request = require("request");
var fs = require("fs");
const child = require("child_process");

let count = 0;
let time = 0;
let now = Date.now();
var proxy = httpProxy.createProxyServer({});

prod_url = fs.readFileSync("stableServer").toString();
canary_url = fs.readFileSync("canaryServer").toString();

console.log(prod_url);
console.log(canary_url);

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
    //console.log(req.url);
    //console.log(typeof time);
    console.log("time is" + time);
    if (time < 5000) {
      proxy.web(req, res, { target: "http://192.168.33.30:3000/" });
      //console.log("hello master");
    } else if (time >= 5000 && time <= 10000) {
      proxy.web(req, res, { target: "http://192.168.33.40:3000/" });
      //console.log("hello canary");
    } else {
      process.exit(1);
      console.log("Finish");
    }
    //console.log(res.statusCode);
  })
  .listen(3000);

var heartbeatTimer = setInterval(function () {
  main();
  time = Date.now() - now;
}, 500);
