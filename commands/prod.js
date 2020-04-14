const child = require('child_process');
const chalk = require('chalk');
const path = require('path');
const os = require('os');
const sshSync = require('../lib/ssh');
const inventoryPath = '/bakerx/cm/inventory.ini';
const playbook = '/bakerx/provision/provision.yml';
const cpPlaybook = '/bakerx/provision/change_kp_settings.yml';

exports.command = 'prod <command>';
exports.desc = 'Provision cloud instances and control plane';
exports.builder = yargs => {
    yargs.options({});
};

exports.handler = async argv => {
    const { command } = argv;
    (async () => {
        if (command == 'up'){
            await run();
        }
        else{
            console.log("COMMAND NOT FOUND!!!");
        }
    })();
};

async function run(){

    console.log(chalk.greenBright('Provisioning VMs'));
    result = sshSync(`ansible-playbook ${playbook} -i ${inventoryPath} --vault-password-file /bakerx/cm/vars/pass.txt`, 'vagrant@192.168.33.10');
    // result = sshSync(`ansible-playbook ${playbook} -i ${inventoryPath} --ask-vault-pass`, 'vagrant@192.168.33.10');
    if( result.error ) { process.exit( result.status ); }

    console.log(chalk.greenBright('Changing permissions'));
    result = sshSync(`ansible-playbook ${cpPlaybook} -i ${inventoryPath} --vault-password-file /bakerx/cm/vars/pass.txt`, 'vagrant@192.168.33.10');
    // result = sshSync(`ansible-playbook ${cpPlaybook} -i ${inventoryPath} --ask-vault-pass`, 'vagrant@192.168.33.10');
    if( result.error ) { process.exit( result.status ); }

}
