const path = require('path');
const solc = require('solc');
const fs = require('fs-extra');

// delete entire build folder if it exists
const buildPath = path.resolve(__dirname, 'build');
fs.removeSync(buildPath);

const campaignPath = path.resolve(__dirname, 'contracts', 'Campaign.sol');
const source = fs.readFileSync(campaignPath, 'utf8');

const input = {
    language: 'Solidity',
    sources: {
        'Campaign.sol': {
            content: source
        },
    },
    settings: {
        outputSelection: {
            '*': {
                '*': [ "abi", "evm.bytecode" ]
            }
        }
    }
}

try {
    const output = JSON.parse(solc.compile(JSON.stringify(input))).contracts['Campaign.sol'];
    fs.ensureDirSync(buildPath);

    // loop contracts and create a file with each
    for(let contract in output) {
        fs.outputJSONSync(
            path.resolve(buildPath, contract + '.json'),
            output[contract]
        );
    }
} catch(err) {
    console.log(err);
}


