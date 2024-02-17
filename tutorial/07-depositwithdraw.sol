// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract SimpleBank {
    function deposit() public payable{}

    function withdraw() public {
        payable(msg.sender).transfer(address(this).balance);
    }
}