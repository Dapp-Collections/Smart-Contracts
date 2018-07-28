pragma solidity ^0.4.20;

contract Event {
    
    address owner;
    
    uint public tickets;
    
    string public description;
    
    string public website;
    
    uint constant price = 1 ether;
    
    mapping(address => uint) public purchasers;
    
    constructor( uint _tickets, string _description, string _website) public {
        owner = msg.sender;
        tickets = _tickets;
        description = _description;
        website = _website;
    }
    
    function buyTickets( uint amount) public payable {
        if(msg.value != (amount*price) || amount > tickets){
            revert();
        } else {
            purchasers[msg.sender] += amount;
            tickets -= amount;
            if(tickets == 0){
                owner.transfer(address(this).balance);
            }
        }
    }
    
    function refund( uint numTickets) public payable{
        if(purchasers[msg.sender] < numTickets){
            revert();
        } else {
            msg.sender.transfer(numTickets * price);
            purchasers[msg.sender] -= numTickets;
            tickets += numTickets;
        }
    }
}