pragma solidity ^0.4.24;

contract ToothFairy{
    
    address mother = 0xca35b7d915458ef540ade6068dfe2f44e8fa733c;
    
    address child = 0x14723a09acff6d2a60dcdf7aa4aff308fddc160c;
    
    address toothfairy;
    
    bool toothPaid = false;
    
    enum ToothState {Mouth, WaitingFallenAproval, Fallen}
    
    ToothState public toothState = ToothState.Mouth;
    
    constructor() public payable{}
    
    function toothFall() public onlyChild{
        if(toothState == ToothState.Mouth){
            toothState = ToothState.WaitingFallenAproval;
        } else {
            revert();
        }
    }
    
    function motherAproves() public onlyMother {
        if(toothState == ToothState.WaitingFallenAproval){
            payToChild();
            toothState = ToothState.Fallen;
        }
    }
    
    function payToChild() public{
        if(toothState == ToothState.WaitingFallenAproval && toothPaid == false){
            child.transfer(address(this).balance);
            toothPaid = true;
        } else {
            revert();
        }
    }
    
    modifier onlyChild {
        require(msg.sender == child);
        _;
    }
    
    modifier onlyFairy {
        require(msg.sender == toothfairy);
        _;
    }
    
    modifier onlyMother {
        require(msg.sender == mother);
        _;
    }
}