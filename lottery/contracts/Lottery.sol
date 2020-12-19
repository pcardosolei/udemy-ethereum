pragma solidity ^0.4.17;

contract Lottery {
    address public manager;
    address[] public players;
    
    function Lottery() public {
        manager = msg.sender;
    }
    
    function enter() public payable {
        require(msg.value > .01 ether); // the requirements to use this function
        players.push(msg.sender);
    }
    
    function random() private view returns (uint) {
        // block is a global variable on solidity
        // time is a global variable too - now is this case
        return uint(sha3(block.difficulty, now, players)); // this is not trully random because we can access the block difficult , the time and players
    }
    
    // restricted is the modifier to block in this case who can use this function
    function pickWinner() public restricted {
        uint index = random() % players.length;
        players[index].transfer(this.balance);
        players = new address[](0); // the (0) meanns with 0 elements when it starts
    }
    
    // function modifiers
    modifier restricted() {
        require(msg.sender == manager);
        _; // the code of the function that has this modifier in use. 
    }
    
    function getPlayers() public view returns (address[]) {
        return players;
    }
}