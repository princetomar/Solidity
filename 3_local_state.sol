pragma solidity >= 0.5.0 <0.9.0;


contract local{

    // 2. Local Variables in Solidity
    function store() pure public returns(uint){
        uint age = 19;
        return age;
    }
}