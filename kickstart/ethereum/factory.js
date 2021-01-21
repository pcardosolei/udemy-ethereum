import web3 from './web3';
import CampaignFactory from './build/CampaignFactory.json';

const instance = new web3.eth.Contract(
    CampaignFactory.abi,
    '0x833Be4F3BCE5a401D255A49673c625753ba9f016'
);

export default instance;