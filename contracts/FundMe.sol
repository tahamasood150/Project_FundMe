// SPDX-License-Identifier: MIT
// Objectives:

//  1. Receive funds from the users<br>
//  2. Withdraw funds<br>
//  3. Set a minimum funding value

pragma solidity ^0.8.20;

contract Fundme{

     // 1e18 = 1 Ether
    // 1000000000000000 == 0.001 Ether == 3.45 $
    uint public minimun_funding_valueinusd; //$



     // Allow users to send $$
    // Have a minimum send value
    function receive_funds() public payable {
        require(msg.value >= minimun_funding_valueinusd,"Minimum amount to send is : $5 ");


    }
    function getPrice() public {
        
    }
    function getConversionRate()public {
        
    }

    



    function withdraw_funds_adminonly() public {}



}