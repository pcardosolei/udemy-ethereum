import Web3 from 'web3';

const web3 = new Web3(window.web3.currentProvider); // this window web3 is the Metamask injected web3 in the browser if it exists

export default web3;