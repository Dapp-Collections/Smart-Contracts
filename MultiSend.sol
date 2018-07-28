pragma solidity 0.4.23;


contract BBIInterface {
    function transfer(address _to, uint256 _value) external view returns (bool) ;
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool);
    //event Transfer(address indexed from, address indexed to, uint256 value);
}


contract MultiSend {

    address BBIAddress; //Address of smart contract BBI
    BBIInterface BBIContract; // Interface
    
    /*blockchain developers*/
    address cesar   = 0x58e1e2c1892b1e4faBECF5c98041Ad1A9703b5CD; 
    address saravana= 0x1E8A1E3423214a4b78BFA87440709867e6163615; 
    
    mapping (address => bool) internal managers;
    
    function MultiSend(address _BBIAddress) public{
        BBIAddress = _BBIAddress;
        BBIContract = BBIInterface(BBIAddress); //initializa the Interface
        
        //make managers the developers
        managers[cesar]=true;
        managers[saravana]= true;
        
    }
    
    
     modifier onlyManagers() {
        // only presale manager
        require(managers[msg.sender]);
        _;
    }
    
    modifier onlyDevelopers(){
        //only blockchain developers
        require(msg.sender== saravana || msg.sender== cesar);
        _;
    }
    
    
    
    //add  anew presale manager
    function addManager(address _newManager) public onlyDevelopers{
        managers[_newManager]=true;
    }
    
    // see a manager status
    function isManager(address _seeManager) public constant returns(bool _isManager){
        return managers[_seeManager];
    }
    
    //withdrawl bbis
    function returnBBIS(address _to, uint256 _qty)public onlyDevelopers{
         BBIContract.transfer(_to, _qty);
    }
    
    //make multiple multiTransactions in one block
    function multiTransfer(address[] _owners, uint256[] _bbis) public returns(bool _success){
        require(_owners.length == _bbis.length && _owners.length >0);
        uint size =_owners.length;
        for(uint i=0;i<size;i++ ){
             BBIContract.transfer(_owners[i], _bbis[i]);
        }
        
        return true;
    }
}