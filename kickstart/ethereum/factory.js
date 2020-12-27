import web3 from './web3';
import CampaignFactory from './build/CampaignFactory.json';

const instance = new web3.eth.Contract(
    CampaignFactory.abi,
    '0xeFB2459947E40eCaA00db8110AAa33F913897c3F'
);

export default instance;