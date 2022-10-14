pragma solidity >= 0.5.0 <0.9.0;

contract State{

    // 1. Static Variables in Solidity
    uint public age;
    
    // To assign a value to age - 

    // We can't use this
    // age = 19 (Will Always give error ) 

    // 1st method - Use Contructor
    constructor () public
    {
        age = 19;
    }

    // 1st method - Create a function
    function setAge() public{
        age = 20;
    }

}

contract local{

    // 2. Local Variables in Solidity
    function store() pure public returns(uint){
        uint age = 19;
        return age;
    }
}