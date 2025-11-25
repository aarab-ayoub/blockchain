// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import  {ERC20} from "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
import  {Ownable} from "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
contract mytoken is ERC20 ,Ownable{
    
    constructor() ERC20("tockenCR","tcr") Ownable(msg.sender){
                _mint(msg.sender, 10000 * 10**decimals());

    }


}