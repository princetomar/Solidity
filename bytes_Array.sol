pragma solidity >= 0.5.0 <0.9.0;

contract BiteArray{

    // Fixed sized Bytes Array
    bytes3 public b3; // 3 bytes array
    bytes2 public b2; // 2 bytes array

    function setter() public{
        b3 = 'abc';
        b2 = 'ab';

        // we can't update any value in bytes array
    }

    // Dynamic Sized Bytes array

    bytes public b1 = "abc";
    
    // function to push element in b1 
    function pushElement() public{
        b1.push('D');
    }

    function getElement(uint i) public view returns(bytes1){
        return b1[i];
    }

    function getLength() public view returns(uint){
        return b1.length;
    }
}