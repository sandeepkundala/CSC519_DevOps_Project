const fs = require('fs');
const path = require('path');
const chalk = require('chalk');
const sshSync = require('../lib/ssh');
var inventoryPath = '';

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
    console.log(chalk.blueBright(`Running deployment of ${app}`));
    console.log(inventoryPath);
    let result = sshSync(`ansible-playbook ${filePath} -i ${inventoryPath} --vault-password-file /bakerx/deploy/vars/pass.txt`, 'vagrant@192.168.33.10');
    if( result.error ) { process.exit( result.status ); }
}