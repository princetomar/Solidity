pragma solidity >= 0.5.0 <0.9.0;


contract constructor_contract{

    uint public count;

    // constructor without argument
    // constructor() public{
    //     count = 10;
    // }

    // constructor with arguments
    constructor(uint newCount) {
        count = newCount;
    }
}  