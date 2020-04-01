var fs = require('fs'),
    xml2js = require('xml2js'),
    child  = require('child_process'); 
var parser = new xml2js.Parser();
var Bluebird = require('bluebird')
const path = require('path');
var testReport =  '/home/vagrant/iTrust/iTrust2-v6/iTrust2/target/surefire-reports';
var validFileExtensions = ["xml"];
let map={};

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
        console.log(calculatePriority());
        console.log(map);
}

function readResults(result)
{
    var tests = [];
    for( var i = 0; i < result.testsuite['$'].tests; i++ )
    {
        var testcase = result.testsuite.testcase[i];
        tests.push({
        name:   testcase['$'].name, 
        time:   testcase['$'].time, 
        status: testcase.hasOwnProperty('failure') ? "failed": "passed"
        });
    }    
    return tests;
}



async function calculatePriority()
{

for( var i = 0; i < 20; i++ )
    {
//run fuzzer

 try{
        child.execSync('cd /home/vagrant/iTrust/iTrust2-v6/iTrust2 && sudo mvn -f pom-data.xml process-test-classes && sudo mvn clean test verify org.apache.maven.plugins:maven-checkstyle-plugin:3.1.0:checkstyle');
    }catch(e){
        var error1=new Buffer(e.stdout).toString('ascii');
        if (error1.includes('Compilation')==true){
        console.log("COMPILATION");
        //hard reset
        //next iteration starts and code goes to fuzzer.js
}
}

    var listOfFiles = read(testReport);
	//console.log(listOfFiles);  
	for (const index  in listOfFiles){
	var contents=fs.readFileSync(listOfFiles[index])
    let xml2json = await Bluebird.fromCallback(cb => parser.parseString(contents, cb));
    var tests = readResults(xml2json);
    //tests.forEach( e=> console.log(e));
    //return tests;
    for ( var test of tests)
    {
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

// delete the surefire reports for previous iiteration

}  
console.log(map);



return;
}

module.exports.calculatePriority = calculatePriority;

