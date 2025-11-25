// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Mycontract {
    //1
    bool public addressExists;

    //2
    uint public totalSupply = 1000;
    uint public maxSupply = 21000000;

    //6
    address public owner;

    // 3
    mapping(address => bool) public devAccounts;
    mapping(address => bool) public adminAccounts;

    constructor() {
        devAccounts[msg.sender] = true;
        owner = msg.sender; // 6
        //adminAccounts[msg.sender] = true;
    }
    
    //function addDev(address _user) public {
    //    devAccounts[_user] = true;
    //}

    //4
    address[] public users;

    function addUser(address _user) public {
        users.push(_user);
    }

    //5
    struct Event {
        uint8 uid;
        string name;
        uint date;
        address donationAddress;
    }

    Event public myEvent;

    function setEvent(uint8 _uid, string memory _name, address _donationAddr) public {
        myEvent = Event(_uid, _name, block.timestamp, _donationAddr);
    }

    function donate() public payable {
        require(myEvent.donationAddress != address(0), "Donation address not set");
        
        payable(myEvent.donationAddress).transfer(msg.value);
    }

    //6

    modifier onlyAdmin() {
        require(adminAccounts[msg.sender] == true, "You are not an admin!");
        _; 
    }

    // Only an existing admin can add a new admin
    function addAdmin(address _newAdmin) public onlyAdmin {
        adminAccounts[_newAdmin] = true;
    }

}