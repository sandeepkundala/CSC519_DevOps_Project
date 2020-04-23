const fs = require('fs');
const os = require("os");
const path = require('path');
const chalk = require('chalk');
const sshSync = require('../lib/ssh');
const scpSync = require("../lib/scp");
var inventoryPath = '';
let filePathUpdate = "/bakerx/deploy/update.yml"

exports.command = 'deploy <app>';
exports.desc = 'Deploy the application in cloud servers';
exports.builder = yargs => {
    yargs.options({
        inventory: {
            alias: 'i',
            describe: 'inventory path',
            default: 1,
            type: 'string'
        }
    });
};

exports.handler = async argv => {
    const { app, inventory } = argv;
    (async () => {
        if (inventory == null){
            inventoryPath = '/bakerx/inventory.ini';
        }
        else{
            inventoryPath = '/bakerx/' + inventory;
        }
        if (fs.existsSync(path.resolve('deploy/'+app+'.yml'))){
            await run(app, inventoryPath);
        }
        else{
            console.error("Job file doesn't exist");
        }
    })();
};

async function run(app, inventoryPath){

    let filePath = '/bakerx/deploy/'+app+'.yml';

    console.log("Make .bakerx folder in ansible srv");
    let result = sshSync("mkdir /home/vagrant/.bakerx", "vagrant@192.168.33.10");

    console.log(chalk.blueBright("Installing privateKey on configuration server"));
    let identifyFile = path.join(os.homedir(), ".bakerx", "insecure_private_key");
    result = scpSync(
        identifyFile,
        "vagrant@192.168.33.10:/home/vagrant/.bakerx/insecure_private_key"
    );

    console.log("Make .bakerx folder in ansible srv");
    result = sshSync("chmod 700 /home/vagrant/.bakerx/insecure_private_key", "vagrant@192.168.33.10");

    console.log(chalk.blueBright(`Running deployment of ${app}`));
    console.log(inventoryPath);

    result = sshSync(`ansible-playbook ${filePathUpdate} -i ${inventoryPath} --vault-password-file /bakerx/deploy/vars/pass.txt`, 'vagrant@192.168.33.10');
    if( result.error ) { process.exit( result.status ); }

    // result = sshSync(`ansible-playbook ${filePathUpdate} -i ${inventoryPath} --ask-vault-pass`, 'vagrant@192.168.33.10');
    // if( result.error ) { process.exit( result.status ); }

    result = sshSync(`ansible-playbook ${filePath} -i ${inventoryPath} --vault-password-file /bakerx/deploy/vars/pass.txt`, 'vagrant@192.168.33.10');
    if( result.error ) { process.exit( result.status ); }
    // result = sshSync(`ansible-playbook ${filePath} -i ${inventoryPath} --ask-vault-pass`, 'vagrant@192.168.33.10');
    // if( result.error ) { process.exit( result.status ); }
}