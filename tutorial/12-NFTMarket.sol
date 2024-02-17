// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import './09-Ownable.sol';

interface IBank{
    function transferFrom(address _from, address _to, uint _amount) external;
    function getBalance() external view returns(uint);
    function withdraw(uint _amount) external;
}

contract NFTMarket is Ownable {
    struct Dog{
        uint256 id;
        string name;
        address owner;
    }

    Dog[] dogs;
    mapping(address=>uint[]) ownedToDogs;
    uint private price = 1000; //1ETH
    address private bankAddr = 0x7C4e30a43ecC4d3231b5B07ed082329020D141F3;
    IBank bank = IBank(bankAddr);

    function createDog(string memory _name) external onlyOwner {
        Dog memory newDog = Dog(dogs.length, _name, address(0));
        dogs.push(newDog);
    }

    function getOwner() view external returns(address){
        return owner;
    }

    function viewDog() view external returns(Dog[] memory) {
        return dogs;
    }

    function buyDog(uint256 _id) external{
        require(dogs[_id].owner == address(0), "Kitty not for sale");
        ownedToDogs[msg.sender].push(_id);
        dogs[_id].owner = msg.sender;
        bank.transferFrom(msg.sender, address(this), price);
    }

    function withdrawFromBank() external onlyOwner {
        uint balance = bank.getBalance();
        bank.withdraw(balance);
    }

    function transferToOwner() external onlyOwner{
        payable(msg.sender).transfer(address(this).balance);
    }

    function getBalance() view external onlyOwner returns(uint){
        return address(this).balance;
    }

    receive() external payable {

    }
}