// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract PureView{
    uint param = 3;
    
    function add(uint x, uint y) public pure returns(uint){
        uint result = x + y;
        return result;
    }

    function addHoge(uint x, uint y) public view returns (uint result) {
        result = x + y + param;
    }
}