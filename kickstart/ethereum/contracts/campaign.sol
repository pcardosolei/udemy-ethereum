// SPDX-License-Identifier: MIT
pragma solidity ^0.7.4;

contract CampaignFactory {
    address[] public deployedCampaigns;
    
    function createCampaign(uint minimum) public {
        Campaign newCampaign = new Campaign(minimum, msg.sender);
        deployedCampaigns.push(address(newCampaign));
    }
    
    function getDeployedCampaigns() public view returns(address[] memory){
        return deployedCampaigns;
    }
}

contract Campaign {
    struct Request{ // struct definition - its defining the type
        string description;
        uint value;
        address payable recipient;
        bool complete;
        uint approvalCount;
        mapping(address => bool) approvals;
    }

    uint numRequests;
    Request[] public requests;
    address public manager;
    uint public minimumContribution;
    mapping(address => bool) public approvers;
    uint public approversCount; 
    
    // modifiers
    modifier restricted() {
        require(msg.sender == manager);
        _; // the rest of the function
    }
    
    constructor(uint minimum, address creator) {
        manager = creator;
        minimumContribution = minimum;
        numRequests = 0;
    }
    
    function contribute() public payable {
        require(msg.value > minimumContribution);
        
        approvers[msg.sender] = true;
        approversCount++;
    }
    
    function createRequest(string memory description, uint value, address payable recipient) public restricted{
        numRequests++;
        Request storage newRequest = requests[numRequests];
        newRequest.description = description;
        newRequest.value = value;
        newRequest.recipient = recipient;
        newRequest.complete = false;
        newRequest.approvalCount = 0;
    }
    
    function approveRequest(uint index) public {
        // we want to manipulate and save it that is why it is storage.
        Request storage request = requests[index]; 
        require(approvers[msg.sender]);
        require(!request.approvals[msg.sender]);
        
        request.approvals[msg.sender] = true;
        request.approvalCount++;
    }
    
    function finalizeRequest(uint index) public restricted {
        Request storage request = requests[index];
        require(request.approvalCount > (approversCount / 2));
        require(!request.complete);
        
        request.recipient.transfer(request.value);
        request.complete = true;
    }
}