const fs = require('fs');
const path = require('path');
const chalk = require('chalk');
const sshSync = require('../lib/ssh');
const filePath = '/bakerx/cm/jenkins.yml';
const inventoryPath = '/bakerx/cm/inventory.ini';

exports.command = 'setup';
exports.desc = 'Run jenkins config playbook';

exports.handler = async argv =>{
	(async() => {
            await run();
	})();
};

async function run() {

    console.log(filePath);
    console.log(inventoryPath);
    console.log(chalk.blueBright('Running ansible script...'));
    let result = sshSync(`sudo /bakerx/cm/run-ansible.sh ${filePath} ${inventoryPath}`, 'vagrant@192.168.33.10');
    if( result.error ) { process.exit( result.status ); }

}
