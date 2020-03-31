const fs = require('fs');
const Random = require('random-js');
const path = require('path');
const randomizer = new Random(Random.engines.mt19937().autoSeed());



var validFileExtensions = ["java"];

/*
This method will read all the files in a directory recursively
*/
const read = (dir) =>
    fs.readdirSync(dir)
    .reduce(function(files, file) {
        if (fs.statSync(path.join(dir, file)).isDirectory()) {
            var readFilesList = read(path.join(dir, file));
            if (readFilesList != undefined) {
                //console.log("hello")
                return files.concat(readFilesList);
            } else {
                //console.log("mello")
                return files;
            }
        } else {
            if (validFileExtensions.indexOf(file.substring(file.lastIndexOf(".") + 1)) > -1) {
                return files.concat(path.join(dir, file));
            } else {
                //console.log("cello")
                return files;
            }
        }
    }, []);

/*
This function implements main fuzzer logic
Throws an error if directory is not given*/
function main(directoryPath) {
    //console.log(directoryPath)
    var args = process.argv.slice(2);

    console.log(args)
    console.log(args[0])

    var dirPath = directoryPath || args[0];

    if (!dirPath)
        throw new Error("not valid directory");

    var listOfFiles = read(dirPath);
    //console.log(listOfFiles)
    console.log(listOfFiles.length)
    var sampleList = randomizer.sample(listOfFiles, randomizer.integer(0, 0.10*listOfFiles.length));
    console.log(listOfFiles)
    listOfFiles.forEach(function(ele) {
        createRandomChangesInAFile(ele);
    });
}

function createRandomChangesInAFile(filePath) {
    var data = fs.readFileSync(filePath, 'utf-8').split('\n');
    console.log(data)
    data.forEach(function(ele, index) {
        // var match = ele.match(/\"[\w|\d]*\"/i);
        // //console.log(match)

        // if (match != undefined) {
        //     //console.log(ele)
        //     var original = match[0].substring(1, match[0].length - 1);
        //     var replacement = original;

        //     if (randomizer.bool(0.40)) {
        //         replacement = replacement.split('').reverse().join('');
        //     }

        //     if (randomizer.bool(0.20)) {
        //         replacement = randomizer.string(randomizer.integer(0, 2 * replacement.length));
        //     }

        //     if (randomizer.bool(0.05)) {
        //         replacement = '';
        //     }

        //     data[index] = data[index].replace(match, "\""+replacement+"\"");


        //     if (randomizer.bool(0.01)) {
        //         data[index] = data[index].replace(match, null);
        //     }
        // }

        if  (ele.includes(">")) {
            console.log(ele)
            //if (randomizer.bool(0.20)) {
                data[index] = ele.replace(/>/g, "<");
            //}
        }

        else if (ele.includes("<")) {
            console.log(ele)
            //if (randomizer.bool(0.20)) {
                data[index] = ele.replace(/</g, ">");
            //}
        }

        else if (ele.includes("!=")) {
            console.log(ele)
            //if (randomizer.bool()) {
                data[index] = ele.replace(/!=/g, "==");
            //}
        }

        else if (ele.includes("==")) {
            console.log(ele)
            //if (randomizer.bool()) {
                data[index] = ele.replace(/==/g, "!=");
            //}
        }

        else if (ele.includes("1")) {
            console.log(ele)
            //if (randomizer.bool(0.60)) {
                console.log(ele)
                data[index] = ele.replace(/1/g, "0");
            //}
        }

        else if (ele.includes("0")) {
            console.log(ele)
            //if (randomizer.bool(0.25)) {
                data[index] = ele.replace(/0/g, "1");
            //}
        }

    });

    data = data.join(" ");

    fs.writeFileSync(filePath, data);
}

exports.main = main;
