const child = require('child_process');
const chalk = require('chalk');
const path = require('path');
const os = require('os');
const sshSync = require('../lib/ssh');
const inventoryPath = '/bakerx/cm/inventory.ini';
const playbook = '/bakerx/provision/provision.yml';

exports.command = 'prod up';
exports.desc = 'Provision cloud instances and control plane';
exports.builder = yargs => {
};

exports.handler = async argv => {
    (async () => {
        await run();
    })();
};

async function run(){

    console.log(chalk.greenBright('Provisioning VMs'));
    result = sshSync(`ansible-playbook ${playbook} -i ${inventoryPath} `, 'vagrant@192.168.33.10');
    if( result.error ) { process.exit( result.status ); }



}
