const child = require('child_process');
const chalk = require('chalk');
const path = require('path');
const os = require('os');
const scpSync = require('../lib/scp');
const sshSync = require('../lib/ssh');
const filePath = '/bakerx/cm/jenkins.yml';
const inventoryPath = '/bakerx/cm/inventory.ini';


exports.command = 'setup';
exports.desc = 'Provision and configure the configuration server';
exports.builder = yargs => {
    yargs.options({
        privateKey: {
            describe: 'Install the provided private key on the configuration server',
            type: 'string'
        },
        'gh-user':{
            describe: 'Github Username/ token',
            type: 'string'
        },
        'gh-pass':{
            describe: 'Github password',
            type: 'string'
        }
    });
};


exports.handler = async argv => {
    const { privateKey, ghUser, ghPass } = argv;


    (async () => {

        await run( privateKey, ghUser, ghPass );

    })();

};

async function run(privateKey, ghUser, ghPass) {

    let flag = 0;

    if (ghUser){
        if(ghPass){
            flag = 2;
        }
        flag = 1;
    }

    console.log(chalk.greenBright('Installing configuration server!'));

    console.log(chalk.blueBright('Provisioning configuration server...'));
    let result = child.spawnSync(`bakerx`, `run ansible-srv bionic --ip 192.168.33.10 --sync --memory 3072`.split(' '), {shell:true, stdio: 'inherit'} );
    if( result.error ) { console.log(result.error); process.exit( result.status ); }

    console.log(chalk.blueBright('Provisioning jenkins server...'));
    result = child.spawnSync(`bakerx`, `run jenkins-srv bionic --ip 192.168.33.20 --memory 3072`.split(' '), {shell:true, stdio: 'inherit'} );
    if( result.error ) { console.log(result.error); process.exit( result.status ); }

    // wait for 30 sec
    console.log("Wait for 30s");
    await sleep(30000);

    console.log(chalk.blueBright('Installing privateKey on configuration server'));
    let identifyFile = privateKey || path.join(os.homedir(), '.bakerx', 'insecure_private_key');
    result = scpSync (identifyFile, 'vagrant@192.168.33.10:/home/vagrant/.ssh/jenkins_rsa');
    if( result.error ) { console.log(result.error); process.exit( result.status ); }

    // wait for 30 sec
    console.log("Wait for 30s");
    await sleep(30000);
    console.log(chalk.blueBright('Running init script...'));
    result = sshSync('chmod +x /bakerx/cm/server-init.sh', 'vagrant@192.168.33.10')
    if( result.error ) { console.log(result.error); process.exit( result.status ); }
    result = sshSync('/bakerx/cm/server-init.sh', 'vagrant@192.168.33.10');
    if( result.error ) { console.log(result.error); process.exit( result.status ); }
    

    console.log(chalk.blueBright('Running ansible script...'));

    result = sshSync('chmod +x /bakerx/cm/run-ansible.sh', 'vagrant@192.168.33.10');
    if( result.error ) { console.log(result.error); process.exit( result.status ); }

    if (flag == 0)
    {
        result = sshSync(`/bakerx/cm/run-ansible.sh ${filePath} ${inventoryPath}`, 'vagrant@192.168.33.10');
        if( result.error ) { process.exit( result.status ); }
    }
    else if(flag == 1)
    {
        result = sshSync(`ansible-playbook ${filePath} -i ${inventoryPath} --vault-password-file /bakerx/cm/vars/pass.txt --extra-vars "GH_USER=${ghUser}"`,'vagrant@192.168.33.10');
        if( result.error ) { process.exit( result.status ); }
    }
    else{
        result = sshSync(`ansible-playbook ${filePath} -i ${inventoryPath} --vault-password-file /bakerx/cm/vars/pass.txt --extra-vars "GH_USER=${ghUser} GH_PASS=${ghPass}"`,'vagrant@192.168.33.10');
        if( result.error ) { process.exit( result.status ); }
    }

}

async function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}
