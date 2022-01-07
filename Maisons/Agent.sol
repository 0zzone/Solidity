pragma solidity ^0.8.7;

contract Agent {

    address agent;

    constructor() {
        agent = msg.sender;
    }

    modifier isAgent() {
        require(msg.sender == agent, "Not the agent !");
        _;
    }

}
