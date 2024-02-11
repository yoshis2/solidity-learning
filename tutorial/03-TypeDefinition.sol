// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract TypeContract {
    int a = -5;
    uint b = 3;
    bool c = true;
    string d = "hello world";
    bytes e = "ETH";
    address f = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    struct dog {
        string name;
        address owner;
        uint256 id;
    }
}
