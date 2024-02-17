// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import "./09-Ownable.sol";

contract Bank is Ownable {

    event balanceUpdate(string indexed _txType, address indexed _owner, uint _amount);

    mapping(address => uint) balance;
    modifier balanceCheck(uint _amount) {
        require(balance[msg.sender] >= _amount, "Insufficient balance");
        _;
    }

    function getBalance() public view returns(uint) {
        return balance[msg.sender];
    }

    function deposit() public payable onlyOwner {
        balance[msg.sender] += msg.value;
        emit balanceUpdate("Deposit", msg.sender, balance[msg.sender]);
    }

    function withdraw(uint _amount) public balanceCheck(_amount) {
        uint beforeWithdraw = balance[msg.sender];
        balance[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
        emit balanceUpdate("Withdraw", msg.sender, balance[msg.sender]);
        uint afterWithdraw = balance[msg.sender];
        assert(afterWithdraw == beforeWithdraw - _amount);
    }

    function transfer(address _to, uint _amount) public onlyOwner balanceCheck(_amount){
        require(msg.sender != _to, "Invalid recipient");
        _transfer(msg.sender, _to, _amount);
        emit balanceUpdate("Outgoing Transfer", msg.sender, balance[msg.sender]);
        emit balanceUpdate("Incoming Transfer", _to, balance[_to]);
    }

    function _transfer(address _from, address _to, uint _amount) private {
        balance[_from] -= _amount;
        balance[_to] += _amount;

    }
}