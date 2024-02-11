// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract ArrayContract {
    uint [] numbers = [1,2,3,4,5];
    uint [10] fixedNumbers = [1,2,3,4,5];

    function getNumber () public view returns(uint) {
        return numbers[3];
    }

    function getNumbers () public view returns(uint[] memory){
        return numbers;
    }

    function getFixedNumbers () public view returns (uint[10] memory ) {
        return fixedNumbers;
    }

    function getNumberLength() public view returns(uint) {
        uint length = numbers.length;
        return length;
    }

    function addNumber(uint _number) public {
        numbers.push(_number);
    }

    function modNumber(uint _index, uint _number) public {
        numbers[_index] = _number;
    }
}

contract MappingContract{
    mapping (address=>uint) balance;

    function addBalance(uint _toAdd) public returns(uint) {
        balance[msg.sender] += _toAdd;
        return balance[msg.sender];
    }

    function getBalance(address _address) public view returns(uint){
        return balance[_address];
    }
}