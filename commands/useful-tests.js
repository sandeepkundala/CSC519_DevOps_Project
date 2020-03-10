const fs = require('fs');
const path = require('path');
const chalk = require('chalk');
const sshSync = require('../lib/ssh');
const inventoryPath = '/bakerx/cm/inventory.ini';

exports.command = 'useful-tests <name>';
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
    const { name, check } = argv;
    if (check == null){
        check = 1;
    }
    (async () => {
        if (fs.existsSync(path.resolve('cm/'+name+'_test.yml'))){
            await run(name, check);
        }
        else{
            console.error("Sorry, File doesn't exist");
        }
    })();
};

async function run(name, check){
    let filePath = '/bakerx/cm/'+name+'_test.yml';
    console.log(chalk.blueBright(`Running tests ${check} time(s)...`));
    let result = sshSync(`/bakerx/cm/run-ansible.sh ${filePath} ${inventoryPath}`, 'vagrant@192.168.33.10');
    if( result.error ) { process.exit( result.status ); }
}