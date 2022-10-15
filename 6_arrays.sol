pragma solidity >= 0.5.0 <0.9.0;

contract Array{


    // Fixed Size Arrays
    uint[4] public arr = [10,20,30,40];

    // set a particular value in our array
    function setter(uint index, uint value) public{
        arr[index] = value;
    }

    // function to return the length of the array
    function length() public view returns(uint){
        return arr.length;
    }

    // Dynamic Sized Arrays
    uint[] public darr;
    
    function pushElement(uint item) public {
        darr.push(item);
    }

    function lengthDArr() public view returns(uint){
        return darr.length;
    }

    function popElement() public{
        darr.pop();
    }

}