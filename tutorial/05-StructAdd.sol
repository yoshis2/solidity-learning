// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract StructContract {
    struct Dog{
        string name;
        address owner;
        uint id;
    }

    Dog[] dogs;
    mapping(address=>uint[]) ownerToDog;

    function addDog(string memory _name, address _owner) public {
        uint id = dogs.length;
        Dog memory newDog = Dog(_name,_owner,id);
        dogs.push(newDog);

        ownerToDog[_owner];
    }

    function getDog(address _owner) public view returns (string[] memory){
        uint numOfDogs = ownerToDog[_owner].length;
        string[] memory names = new string[](numOfDogs);

        for(uint i=0; i<numOfDogs; i++){
            uint id = ownerToDog[_owner][i];
            names[i] = (dogs[id].name);
        }

        return names;
    }
}