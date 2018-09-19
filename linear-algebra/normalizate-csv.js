const fs = require("fs");

let mineObj = {};

let allObj = {};

const parse = obj => element => {
    const pair = element.split(',');
    obj[pair[0]] = pair[1];
};

const parseFile = (file, obj) => fs.readFileSync(file, {encoding: "utf-8"}).split('\n').forEach(parse(obj));

parseFile("./mine.csv", mineObj);

parseFile("./all.csv", allObj);

for(let key in mineObj) {
    const val = mineObj[key];
    if((val !== 0) && (val != allObj[key])) {
        console.log(`${key},${val}`);
    }
}
