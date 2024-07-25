// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;
import "../ChainLink_Interface/AggregatorV3Interface.sol";

contract Fundme{

    AggregatorV3Interface private PriceETHfetch;

    constructor(){
        // The address is sepolia test net one
        PriceETHfetch = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    }

     // 1e18 = 1 Ether
    uint public minimun_funding_valueinusd;


    function receive_funds() public payable {
        (,int ethcurrent_price,,,) = PriceETHfetch.latestRoundData();
        uint(ethcurrent_price) =  minimun_funding_valueinusd;
        require(msg.value >= minimun_funding_valueinusd,"Minimum amount to send is : $5 ");



    }



    function getPrice() public {}
    function getConversionRate()public{}
    function withdraw_funds_adminonly() public {}



}