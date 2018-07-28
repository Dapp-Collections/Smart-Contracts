pragma solidity ^0.4.0;

contract SalesContract{
    
    address public owner;
    
    bool public isSold = false;
    
    string public salesDescription = "Iphone 6+";
    
    uint public price = 2 ether;
    
    constructor() public {
        owner = msg.sender;
    }
    
    function buy() public payable {
        if(msg.value >=price){
            owner.transfer(address(this).balance);
            owner = msg.sender;
            isSold = true;
        } else {
            revert();
        }
    }
}