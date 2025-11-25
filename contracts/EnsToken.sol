// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract ENSToken {
    
    string public name = "ENS Token";
    string public symbol = "ENS";
    uint256 public totalSupply = 10000;
    uint256 public maxSupply = 21000000;
    address public owner;

    mapping(address => uint256) public balances;

    struct Payment {
        uint256 amount;
        address recipient;
    }
    
    mapping(address => Payment[]) public paymentHistory;

    event TotalSupplyChanged(uint256 newSupply);
    event Transfer(address indexed from, address indexed to, uint256 amount);

    // --- Modifiers (Step 10) ---
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this");
        _;
    }

    // --- Constructor (Steps 12, 16) ---
    constructor() {
        owner = msg.sender;
        balances[owner] = totalSupply;
    }

    // --- Functions ---
    function getTotalSupply() public view returns (uint256) {
        return totalSupply;
    }

    function getMaxSupply() public view returns (uint256) {
        return maxSupply;
    }

    function increaseSupply() public onlyOwner {
        require(totalSupply + 1000 <= maxSupply, "Max supply exceeded");
        
        totalSupply += 1000;
        balances[owner] += 1000;
        
        emit TotalSupplyChanged(totalSupply); // Step 13
    }

    // Step 17: Transfer Function
    // We don't need sender address param because 'msg.sender' is a global variable
    // representing the person calling the function (authenticated by their wallet key).
    function transfer(uint256 _amount, address _recipient) public {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        
        balances[msg.sender] -= _amount;
        
        balances[_recipient] += _amount;

        Payment memory newPayment = Payment(_amount, _recipient);
        paymentHistory[msg.sender].push(newPayment);

        emit Transfer(msg.sender, _recipient, _amount);
    }
    
    function getPaymentHistory(address _user) public view returns (Payment[] memory) {
        return paymentHistory[_user];
    }

    ///optional that burn function to decrease token from the owen after a transaction
    function burn(uint256 _amount) public {
        require(balances[msg.sender] >= _amount, "Not enough tokens to burn");

        balances[msg.sender] -= _amount;
        totalSupply -= _amount;

        emit TotalSupplyChanged(totalSupply);
        emit Transfer(msg.sender, address(0), _amount); 
    }

}