const fs = require("fs");
const child = require("child_process");
const chalk = require("chalk");
const path = require("path");
const os = require("os");
const scpSync = require("../lib/scp");
const sshSync = require("../lib/ssh");

exports.command = "canary <blueBranch> <greenBranch>";
exports.desc = "Spin up 3 local machines";

const inventoryPath = "/bakerx/cm/inventory.ini";
const filePath = "/bakerx/canary/canary.yml";
const filePath2 = "/bakerx/canary/runProxy.yml";

exports.builder = (yargs) => {
  yargs.options({});
};

exports.handler = async (argv) => {
  const { blueBranch, greenBranch } = argv;
  (async () => {
    if (blueBranch != null && greenBranch != null) {
      await run(blueBranch, greenBranch);
      // console.log(g);
    } else {
      console.error("Arguments missing");
    }
  })();
};

async function run(blueBranch, greenBranch) {
  console.log(chalk.blueBright("Provisioning blue server..."));
  let result = child.spawnSync(
    `bakerx`,
    `run blue bionic --ip 192.168.33.30 --sync --memory 1024`.split(" "),
    { shell: true, stdio: "inherit" }
  );
  if (result.error) {
    console.log(result.error);
    process.exit(result.status);
  }

  console.log(chalk.blueBright("Provisioning green server..."));
  result = child.spawnSync(
    `bakerx`,
    `run green bionic --ip 192.168.33.40 --memory 1024`.split(" "),
    { shell: true, stdio: "inherit" }
  );
  if (result.error) {
    console.log(result.error);
    process.exit(result.status);
  }

  console.log(chalk.blueBright("Provisioning monitor vm..."));
  result = child.spawnSync(
    `bakerx`,
    `run monitor-vm bionic --ip 192.168.33.50 --memory 1024`.split(" "),
    { shell: true, stdio: "inherit" }
  );

  if (result.error) {
    console.log(result.error);
    process.exit(result.status);
  }

  console.log("Wait for 30s");
  await sleep(30000);

  console.log(chalk.blueBright("Running ansible script..."));

  result = sshSync(
    "chmod +x /bakerx/cm/run-ansible.sh",
    "vagrant@192.168.33.10"
  );
  if (result.error) {
    console.log(result.error);
    process.exit(result.status);
  }


  result = sshSync(
    `ansible-playbook ${filePath} -i ${inventoryPath} --vault-password-file /bakerx/cm/vars/pass.txt -e "blue=${blueBranch}" -e "green=${greenBranch}"`,
    "vagrant@192.168.33.10"
  );
  // result = sshSync(
  //   `ansible-playbook ${filePath} -i ${inventoryPath} --ask-vault-pass -e "blue=${blueBranch}" -e "green=${greenBranch}"`,
  //   "vagrant@192.168.33.10"
  // );
  if (result.error) {
    process.exit(result.status);
  }

  result = sshSync(
    `ansible-playbook ${filePath2} -i ${inventoryPath} --vault-password-file /bakerx/cm/vars/pass.txt`,
    "vagrant@192.168.33.10"
  );
  // result = sshSync(
  //   `ansible-playbook ${filePath2} -i ${inventoryPath} --ask-vault-pass"`,
  //   "vagrant@192.168.33.10"
  // );
  if (result.error) {
    process.exit(result.status);
  }
  fs.readFile(
    "results/192.168.33.50/home/vagrant/canaryAnalysis.txt",
    "utf8",
    function (err, data) {
      console.log(data);
      if (err) {
        console.log(err);
      }
    }
  );

  // delete VMs

  console.log(chalk.blueBright("Deleting green vm..."));
  result = child.spawnSync(`bakerx`, `delete vm green`.split(" "), {
    shell: true,
    stdio: "inherit",
  });

  console.log(chalk.blueBright("Deleting blue vm..."));
  result = child.spawnSync(`bakerx`, `delete vm blue`.split(" "), {
    shell: true,
    stdio: "inherit",
  });

  console.log(chalk.blueBright("Deleting monitor vm..."));
  result = child.spawnSync(`bakerx`, `delete vm monitor-vm`.split(" "), {
    shell: true,
    stdio: "inherit",
  });
}
async function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}
