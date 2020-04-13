const child = require('child_process');
const chalk = require('chalk');
const path = require('path');
const os = require('os');

exports.command = 'prod up'
exports.desc = 'Provision cloud instances and control plane'
exports.builder = yargs => {
};

exports.handler = async argv => {
    (async () => {
        await run();
    })();
};

async function run(){

    console.log(chalk.greenBright('Creating new key pair'));

    // let result = sshSync(`python /home/vagrant/provision/create_aws_kp.py`, 'vagrant@192.168.33.10');
    // if( result.error ) { process.exit( result.status ); }

    console.log(chalk.greenBright('Provisioning VMs'));
    // result = sshSync(`python /home/vagrant/provision/create_aws_kp.py`, 'vagrant@192.168.33.10');
    // if( result.error ) { process.exit( result.status ); }



}
