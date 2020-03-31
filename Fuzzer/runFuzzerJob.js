const fs = require('fs');
const fsExtra = require('fs-extra');
const fuzzer = require('./fuzzer');
var sleep = require('system-sleep');
const child_process = require('child_process');
const REPO = "github.ncsu.edu/engr-csc326-staff/iTrust2-v6.git";
const ITRUST2_V6 = "iTrust2-v6";
const ITRUST2 = "iTrust2";
const ITRUST_RELATIVE_PATH = 'iTrust2-v6/iTrust2/src/main/java/edu/ncsu/csc/itrust2';
const LOCALPATH = "/home/vagrant";


var numberOfIterations = 1;
var args = process.argv.slice(2)[0];
run(args);

function run(check) {
    

    USER = process.env.GH_USER;
    KEY = process.env.GH_PASS;
    
    numberOfIterations = check;
    var REMOTE = `https://${USER}:${KEY}@${REPO}`;

    console.log(REMOTE);

    var GITPATH = `${LOCALPATH}/${ITRUST2_V6}/${ITRUST2}`;
    var loopCount = 0;
    clone(REMOTE, LOCALPATH);
    setCredentials(GITPATH, USER, KEY);
    while (loopCount < numberOfIterations){
        var maxRetries = 50;
        while (maxRetries > 0){
            
            // fuzzer.main(LOCALPATH +'/'+ ITRUST_RELATIVE_PATH);
            var result = maven(GITPATH, "compile");

            if (!result.match(/BUILD FAILURE/)) {
                console.log("COMPILE BUILD PASSED!!!");
                loopCount += 1;
                break;
            }
            
            else {
                console.log("COMPILE BUILD FAILED!!!"); 
                maxRetries -= 1;
                
            }

            // commit(GITPATH, `COMPILE ${loopCount}-${maxRetries-50}`);
            // reset(GITPATH);
        }

        maven(GITPATH, 'clean test verify');

    }
}

function clone(remote, local) {
    console.log("CLONING REPO");
    fsExtra.ensureDirSync(local);
    
    if (fs.existsSync(local + "/" + ITRUST2_V6)) {
       fsExtra.removeSync(local + "/" + ITRUST2_V6);
    }

    var result = child_process.execSync(`git clone ${remote}`, {
        cwd: local
    }).toString('utf8');

    return result;
}

function setCredentials(local, user, pass){
    console.log("Setting credentials");
    child_process.execSync(`git config user.name ${user} && git config user.email ${user}.ncsu.edu && git config user.password ${pass}`, {
        cwd: local
    });

}

function commit(local, message) {
    console.log("COMMITING FILE(S)");
    var result = child_process.execSync(`git add *.java && git commit -m "${message}"`, {
        cwd: local
    }).toString('utf8');
    return result;
}

function reset(local){
    console.log("REVERTING BACK");
    var result = child_process.execSync('git reset HEAD~', {
        cwd: local
    }).toString('utf8');
    return result;
}

function maven(local, args){
    console.log(local);
    console.log("RUNNING MAVEN COMMAND");
    var result = child_process.execSync(`mvn ${args}`, {
        cwd: local, maxBuffer: 100 * 2000 * 2000
    }).toString('utf-8');
    if (result.error) {
        console.log("Cannot execute maven command:\n" + error);
    }
    else {
        return result;
    }
}

