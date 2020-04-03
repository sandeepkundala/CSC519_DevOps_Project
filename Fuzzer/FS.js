const fs = require("fs");
const fsExtra = require("fs-extra");
const xml2js = require("xml2js");
const child  = require("child_process");
const fuzzer = require("./fuzzer");
const Bluebird = require("bluebird");
const path = require("path");

const USER = process.env.GH_USER;
const KEY = process.env.GH_PASS;

const ITRUST2_V6 = "iTrust2-v6";
const ITRUST2 = "iTrust2";

const ITRUST_RELATIVE_PATH = 'iTrust2-v6/iTrust2/src/main/java/edu/ncsu/csc/itrust2';
const LOCALPATH = "/home/vagrant";
const REPO = "github.ncsu.edu/engr-csc326-staff/iTrust2-v6.git";
const TEST_REPORT =  "/home/vagrant/iTrust2-v6/iTrust2/target/surefire-reports";

const REMOTE = `https://${USER}:${KEY}@${REPO}`;
const GITPATH = `${LOCALPATH}/${ITRUST2_V6}/${ITRUST2}`;

var parser = new xml2js.Parser();
var validFileExtensions = ["xml"];
var map={};
var numberOfIterations = process.argv.slice(2)[0];

// child.execSync("sudo rm -rf /home/vagrant/iTrust2-v6");
// clone(REMOTE, LOCALPATH);
// setCredentials(GITPATH, USER, KEY);
// // copy the db.properties and email.prperties
// copy("/home/vagrant/db.properties.j2", "/home/vagrant/iTrust2-v6/iTrust2/src/main/java/db.properties")
// copy("/home/vagrant/email.properties.j2", "/home/vagrant/iTrust2-v6/iTrust2/src/main/java/email.properties")

const read = (dir) =>
    fs.readdirSync(dir)
    .reduce(function(files, file) {
        if (fs.statSync(path.join(dir, file)).isDirectory()) {
            var readFilesList = read(path.join(dir, file));
            if (readFilesList != undefined) {
                return files.concat(readFilesList);
            } else {
                return files;
            }
        } else {
            if (validFileExtensions.indexOf(file.substring(file.lastIndexOf(".") + 1)) > -1) {
                return files.concat(path.join(dir, file));
            } else {
                return files;
            }
        }
    }, []);

if( process.env.NODE_ENV != "test")
{
        console.log(calculatePriority(numberOfIterations));
        console.log(map);
}

function clone(remote, local) {
    console.log("CLONING REPO");
    fsExtra.ensureDirSync(local);

    if (fs.existsSync(local + "/" + ITRUST2_V6)) {
       fsExtra.removeSync(local + "/" + ITRUST2_V6);
    }
    child.execSync(`git clone ${remote}`, {
        cwd: local
    });
}

function setCredentials(local, user, pass){
    console.log("Setting credentials");
    child.execSync(`git config user.name ${user} && git config user.email ${user}.ncsu.edu && git config user.password ${pass}`, {
        cwd: local
    });

}

function copy(source, dest){
    console.log("Copying properties file");
    child.execSync(`cp ${source} ${dest}`);
}

function readResults(result)
{
    var tests = [];
    for (var i = 0; i < result.testsuite["$"].tests; i++ )
    {
        var testcase = result.testsuite.testcase[i];
        tests.push({
        name:   testcase["$"].classname+testcase["$"].name,
        time:   testcase["$"].time,
        status: testcase.hasOwnProperty("failure") ? "failed": "passed"
        });
    }
    return tests;
}


async function calculatePriority(numberOfIterations)
{

    for( var i = 0; i < numberOfIterations; i++ ){
        
        var maxRetries = 50;
        
        while (maxRetries>0){
            var flag = 0;
            try{
                fuzzer.main(LOCALPATH +'/'+ ITRUST_RELATIVE_PATH);
                child.execSync('cd /home/vagrant/iTrust2-v6/iTrust2 && sudo mvn -f pom-data.xml process-test-classes && sudo mvn clean test verify');
                
            }
            catch(e){
                var error1=new Buffer(e.stdout).toString("ascii");
                if (error1.includes("Compilation")==true){
                    console.log("failed");
                    maxRetries -= 1;
                    flag = 1;
                }
            }
            console.log(`successfull build: ${i}`);
            // reset the repo
            child.execSync(`cd ${GITPATH} && git reset --hard HEAD`);
            if (flag == 0){
                break;
            }
        }

        var listOfFiles = read(TEST_REPORT);
        //console.log(listOfFiles);
        for (const index  in listOfFiles){
        var contents=fs.readFileSync(listOfFiles[index])
        let xml2json = await Bluebird.fromCallback(cb => parser.parseString(contents, cb));
        var tests = readResults(xml2json);
        //tests.forEach( e=> console.log(e));
        //return tests;
        for ( var test of tests)
        {
	    console.log(test);
            if (!map.hasOwnProperty(test.name))
            {
                map[test.name]={pass:0 ,fail:0}
            }
            if (test.status == "passed")
            {
                map[test.name].pass++;
            }
            if (test.status == "failed")
            {
                map[test.name].fail++
            }
        }
        
    }
    console.log(map);
    
    // delete the surefire-reports for previous iteration
    child.execSync(`cd ${TEST_REPORT} && sudo rm -rf *.xml && mysql -u root -e 'DROP DATABASE IF EXISTS iTrust2'`)

    }

    result = [];

    for (key in map){
        console.log(key);
        result.push({
            name:   key,
            pass:   map[key].pass,
            fail:   map[key].fail,
            total: map[key].pass + map[key].fail
            })
    }
    
    result.sort((a, b)=>{
        if (a.fail > b.fail)
            return -1000;
        else if (a.pass < b.pass && a.fail == b.fail)
            return -1000;
    })

    var str = '';

    for (i in result){
        str += `${result[i].pass}/${result[i].total} ${result[i].name}` + '\n';
    }
    
    let data = JSON.stringify(map);
    fs.writeFileSync('map.json', data);
    fs.writeFile('result.txt', str, (err) => {
        
        if (err) throw err;
    
        // success case, the file was saved
        console.log('result saved!');
    });

    // console.log(map);
	//  var tupleArray = [];
    //     for (var key in map) tupleArray.push([key, map[key].fail]);
    //     tupleArray.sort(function (a, b) {
    //         return (b[1] - a[1])
    //     });
    //     var sortedMap = {};
    //     tupleArray.forEach(function (el) {
    //         sortedMap[el[0]] = el[1]
    //     });
    //     console.log (sortedMap);
	
	// var myJSON = JSON.stringify(sortedMap);
    //     fs.writeFile('output.txt', myJSON, (err) => {
    //         // throws an error, you could also catch it here
    //         if (err) throw err;
        
    //         // success case, the file was saved
    //         //console.log('Lyric saved!');
    //     });
        
	return;

}

module.exports.calculatePriority = calculatePriority;
