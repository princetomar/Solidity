pragma solidity >= 0.5.0 <0.9.0;

contract Identity{
    string name;
    uint age;

    constructor() public
    {
        name = "Prince";
        age = 19;
    }

    function getName() public view returns(string memory){
        return name;
    }

    function getAge() public view returns(uint){
        return age;
    }

    function incrementAge() public{
        age = age + 1;
    }
}