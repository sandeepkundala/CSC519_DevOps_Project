const fs = require("fs");
const path = require("path");
const chalk = require("chalk");
const sshSync = require("../lib/ssh");
const inventoryPath = "/bakerx/cm/inventory.ini";

exports.command = "build <job>";
exports.desc = "Build job";
exports.builder = (yargs) => {
  yargs.options({});
};

exports.handler = async (argv) => {
  const { job } = argv;
  (async () => {
    if (fs.existsSync(path.resolve("cm/" + job + ".yml"))) {
      await run(job);
    } else {
      console.error("Job file doesn't exist");
    }
  })();
};

async function run(job) {
  let filePath = "/bakerx/cm/" + job + ".yml";
  console.log(chalk.blueBright("Running build environment..."));
  let result = sshSync(
    `/bakerx/cm/run-ansible.sh ${filePath} ${inventoryPath}`,
    "vagrant@192.168.33.10"
  );
  // let result = sshSync(
  //   `ansible-playbook ${filePath} -i ${inventoryPath} --ask-vault-pass`,
  //   "vagrant@192.168.33.10"
  // );
  if (result.error) {
    process.exit(result.status);
  }
}
