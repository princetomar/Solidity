// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.5.0 <0.9.0;

contract CrowdFunding{

    // Defining all the variables that we need
    
    // link user address to contributor
    mapping(address=>uint) public contributers;
    address public manager;
    uint public minimumContribution;
    uint public deadline;
    uint public target;
    uint public raisedAmount;
    uint public noOfContributors;

    //
    //   For Manager
    struct Request{
        string description; // why we need money
        address payable recipent; // at which address we need money
        uint value; // amount
        bool completed; // transaction status
        uint noOfVoters; // how many voters has voted among all 

        mapping(address => bool) voters; 
    }
    mapping(uint => Request) public requests;
    uint public numRequests;
    //

    constructor(uint _target, uint _deadline){
        target = _target;
        deadline = block.timestamp + _deadline;
        minimumContribution = 100 wei;
        manager = msg.sender;
    }

    function sendEth() public payable
    {
        // if our contract still exists
        require(block.timestamp < deadline, "Deadline has expired.");
        // minimum contribution 
        require(msg.value >= minimumContribution, "Minimum contribution has not met.");

        if(contributers[msg.sender] == 0)
        {
            // increase the count of contributors
            noOfContributors++;
        }

        contributers[msg.sender] += msg.value; // if the same user send ether's again
        raisedAmount += msg.value; // increase the total raised amount
    }

    // Function to check the current balance of the contract
    function getContractBalance() public view returns(uint){
        return address(this).balance;
    }

    // for refund 
    function refund() public
    {
        // if deadline hasn't met yet
        require(block.timestamp < deadline && raisedAmount < target, "You are not eligible for refund. Please check after sometime.");
        require(contributers[msg.sender] > 0);

        address payable user = payable(msg.sender);
        user.transfer(contributers[msg.sender]);
        contributers[msg.sender] = 0;
    }

    // Functions accessed  by MANAGER
    modifier onlyManager()
    {
        require(msg.sender == manager,"Only Manager can access this function."); 
        _;
    }

    // this function is only accessed by Manager so using modifier - onlyManager after public keyword
    function createRequests(string memory _description, address payable _recipient,uint _value) public onlyManager{
        
        // If we want to use a mapping that is written inside a structure(struct), then we'll always have to use storage
        // We can't use memory keyword here 
        Request storage newRequest = requests[numRequests];
        numRequests++;
        newRequest.description = _description;
        newRequest.recipent = _recipient;
        newRequest.value = _value;
        newRequest.completed = false;
        newRequest.noOfVoters = 0;
    }

    function voteRequest(uint _requestNo) public
    {
        require(contributers[msg.sender] > 0, "You must be a Contributor to vote.");
        Request storage thisRequest = requests[_requestNo];
        require(thisRequest.voters[msg.sender]==false,"You have already voted");
        thisRequest.voters[msg.sender] = true; // if you've already voted
        thisRequest.noOfVoters++;
    }

    function makePayment(uint _requestNo) public onlyManager
    {
        require(raisedAmount >= target);
        Request storage thisRequest = requests[_requestNo];

        // if only processed transaction
        require(thisRequest.completed == false, "The request has been completed");
        
        // check if no. of voters are greater than no. of contributors/2 or not, means more than 50% of people have voted for the same
        require(thisRequest.noOfVoters > noOfContributors/2, "Majority does not support");
        thisRequest.recipent.transfer(thisRequest.value);
        thisRequest.completed = true; 
    }
} 
