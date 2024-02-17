// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Bank {
    mapping(address => uint) balance;
    address owner;

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner {
       require(msg.sender == owner, "You are not the owner");
        _;
    }

    modifier balanceCheck(uint _amount) {
        require(balance[msg.sender] >= _amount, "Insufficient balance");
        _;
    }

    function getBalance() public view returns(uint) {
        return balance[msg.sender];
    }

    function deposit() public payable onlyOwner {
        balance[msg.sender] += msg.value;
    }

    function withdraw(uint _amount) public balanceCheck(_amount) {
        uint beforeWithdraw = balance[msg.sender];
        balance[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
        uint afterWithdraw = balance[msg.sender];
        assert(afterWithdraw == beforeWithdraw - _amount);
    }

    function transfer(address _to, uint _amount) public onlyOwner balanceCheck(_amount){
        require(msg.sender != _to, "Invalid recipient");

        balance[msg.sender] -= _amount;
        balance[_to] += _amount;
    }
}