pragma solidity ^0.8.7;
import './Owner.sol';

contract Wallet is Owner {
    
    struct Payment {
        uint ammount;
        uint date;
    }

    struct Balance {
        uint totalBalance;
        uint numPayments;
        mapping(uint => Payment) Payments;
    }

    mapping(address => Balance) Balances;

    receive() external payable {
        Payment memory p = Payment(msg.value, block.timestamp);
        Balances[msg.sender].totalBalance += msg.value;
        Balances[msg.sender].Payments[Balances[msg.sender].numPayments] = p;
        Balances[msg.sender].numPayments++;
    }

    function totalBalance() public isOwner view returns(uint) {
        return address(this).balance;
    }

    function transferMoney(address payable to, uint ammount) public {
        require(ammount <= Balances[msg.sender].totalBalance, "Not enought !");
        Balances[msg.sender].totalBalance -= ammount;
        to.transfer(ammount);
    }
}