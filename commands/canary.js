const fs = require('fs');
const path = require('path');
const chalk = require('chalk');
const sshSync = require('../lib/ssh');

exports.command = 'canary <blueBranch> <greenBranch>';
exports.desc = 'Deploy the application in cloud servers';
exports.builder = yargs => {
    yargs.options({
    });
};

exports.handler = async argv => {
    const { blueBranch, greenBranch } = argv;
    (async () => {
        if (blueBranch != null  && greenBranch != null){
            await run(blueBranch, greenBranch);
            // console.log(g);
        }
        else{
            console.error("Arguments missing");
        }
    })();
};

async function run(blueBranch, greenBranch){
    console.log(blueBranch);
    console.log(greenBranch);
    
}