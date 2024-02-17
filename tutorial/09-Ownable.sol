// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Ownable {
    address internal owner;

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner {
       require(msg.sender == owner, "You are not the owner");
        _;
    }
}