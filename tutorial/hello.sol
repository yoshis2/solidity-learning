// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Hello{
    uint hoge = 3;

    function hello() public pure returns(string memory) {
        return "Hello World";
    }
    
    function add(uint x, uint y) public pure returns(uint){
        return x + y;
    }

    function addHoge(uint x, uint y) public view returns (uint) {
        return x + y + hoge;
    }
}
