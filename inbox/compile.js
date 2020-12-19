const path = require('path');
const fs = require('fs');
const solc = require('solc');

const inboxPath = path.resolve(__dirname, 'contracts', 'inbox.sol');
const source = fs.readFileSync(inboxPath, 'utf8');

// 1 is the number of contracts we are about to compile
module.exports = solc.compile(source, 1).contracts[':Inbox'];