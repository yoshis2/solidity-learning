// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract SimpleBank {
    function deposit() public payable{}

    function withdraw() public {
        payable(msg.sender).transfer(address(this).balance);
    }
}

contract Bank {
    mapping(address => uint) balance;

    function getBalance() public view returns(uint) {
        return balance[msg.sender];
    }

    function deposit() public payable {
        balance[msg.sender] += msg.value;
    }

    function withdraw(uint _amount) public {
        require(balance[msg.sender] >= _amount, "Insufficient balance");
        uint beforeWithdraw = balance[msg.sender];
        balance[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
        uint afterWithdraw = balance[msg.sender];
        assert(afterWithdraw == beforeWithdraw - _amount);
    }

    function transfer(address _to, uint _amount) public {
        require(balance[msg.sender] >= _amount, "Insufficient balance");
        require(msg.sender != _to, "Invalid recipient");

        balance[msg.sender] -= _amount;
        balance[_to] += _amount;
    }
}