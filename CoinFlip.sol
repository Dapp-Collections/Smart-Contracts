pragma solidity ^0.4.20;

contract CoinFlip{
    
    address owner;
    
    uint payPercentaje = 90;
    
    event Status(string _msg, address user, uint amount);
    
    constructor() public payable {
        owner = msg.sender;
    }
    
    function FlipCoin() public payable {
        if((block.timestamp % 2) == 0){
            if(address(this).balance < ((msg.value * payPercentaje)/100)){
                emit Status("Ganaste: Perdon no hay suficientes fondos", msg.sender, address(this).balance);
                msg.sender.transfer(address(this).balance);
            } else {
                emit Status("Ganaste. Muchas felicidades", msg.sender, msg.value * (100 + payPercentaje) / 100);
                msg.sender.transfer(msg.value * (100 + payPercentaje) / 100);
            }
        } else {
            emit Status("Has perdido", msg.sender, msg.value);
        }
    }
    
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
    function getBalance() public constant returns (uint) {
        return address(this).balance;
    }
    
}