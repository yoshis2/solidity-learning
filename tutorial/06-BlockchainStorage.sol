// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract StorageContract{
    uint public number = 123; // storage
    string public message = "Hello World"; // storage
    
    // memoryを宣言する必要がある場合
    function setString(string memory input) public {
        string memory newMessage = input; // memory
        message = newMessage;
    }

    function setNumber(uint input) public {
        uint newNumber = input; //memory
        number = newNumber;
    }
}

contract MemoryContract{
    struct Dog {
        string name;
        address owner;
    }

    Dog[] public dogs;
    function newDog(string memory _name) public {
        Dog memory dog = Dog(_name, msg.sender);
        dogs.push(dog);
    }

    function sGetDog(uint _id) public view returns(string memory){
        Dog storage dog = dogs[_id];
        return dog.name;
    }

    function mGetDog(uint _id) public view returns(string memory){
        Dog memory dog = dogs[_id];
        return dog.name;
    }

    function sChangeDog(uint _id, string memory _name) public {
        Dog storage dog = dogs[_id];
        dog.name = _name;
    }
}