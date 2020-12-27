const HDWalletProvider = require('truffle-hdwallet-provider');
const Web3 = require('web3');
const compiledFactory = require('./build/CampaignFactory.json');

const provider = new HDWalletProvider(
    'spider pulse ordinary owner dash ignore lawsuit mind deposit soldier avoid garage',
    'https://rinkeby.infura.io/v3/6289719553ef4b16be5dbb84082f93f3'
);

const web3 = new Web3(provider);

const deploy = async () => {
    const accounts = await web3.eth.getAccounts();

    console.log('Attempting to deploy from account', accounts[0]);

    const result = await new web3.eth.Contract(compiledFactory.abi)
    .deploy({ data: compiledFactory.evm.bytecode.object })
    .send({ gas: '1000000', from: accounts[0] });

    console.log('Contract deployed to', result.options.address); // the address
}

deploy();