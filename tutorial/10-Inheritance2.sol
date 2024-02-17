// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract A {
    string public msgA = "hello world";

    constructor(string memory _msg){
        msgA = _msg;
    }

    function print() public virtual view returns(string memory){
        return msgA;
    }

    function helloA() public pure returns(string memory){
        return "Hello A";
    }
}

contract B {
    string public msgB = "HELLO WORLD";

    constructor(string memory _msg){
        msgB = _msg;
    }

    function print() public virtual view returns(string memory){
        return msgB;
    }
    
    function helloB() public pure returns(string memory){
        return "Hello B";
    }
}

contract C is A, B{
    constructor(string memory _msg) A(_msg) B("Message B"){

    }

    function print() public override(A, B) view returns(string memory) {
        return A.print();
    }
}

contract D is A, B {
    constructor(string memory _msg) A(_msg) B("Message B"){

    }

    function print() public override(A,B) view returns(string memory){
        return super.print();
    }

    function changeMsgB(string memory _msg) public {
        msgB = _msg;
    }
}


