const fs = require('fs');
const path = require('path');
const chalk = require('chalk');
const sshSync = require('../lib/ssh');
const inventoryPath = '/bakerx/cm/inventory.ini';

exports.command = 'useful-tests';
exports.desc = 'Test the package';
exports.builder = yargs => {
    yargs.options({
        check: {
            alias: 'c',
            describe: 'numbers of times to execute test suite',
            default: 1,
            type: 'number'
        }
    });
};

exports.handler = async argv => {
    const { check } = argv;
    if (check == null){
        check = 1;
    }
    (async () => {
        if (fs.existsSync(path.resolve('cm/iTrust_test.yml'))){
            await run(check);
        }
        else{
            console.error("Sorry, File doesn't exist");
        }
    })();
};

async function run(check){
    let filePath = '/bakerx/cm/iTrust_test.yml';
    console.log(chalk.blueBright(`Running tests ${check} time(s)...`));
    let result = sshSync(`ansible-playbook ${filePath} -i ${inventoryPath} --vault-password-file /bakerx/cm/vars/pass.txt -e "check=${check}"`, 'vagrant@192.168.33.10');
    if( result.error ) { process.exit( result.status ); }
}