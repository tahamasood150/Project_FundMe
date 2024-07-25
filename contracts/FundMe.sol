// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;
import "../ChainLink_Interface/AggregatorV3Interface.sol";

contract Fundme{

    AggregatorV3Interface private PriceETHfetch;
    address public admin;

    constructor(){
        // The address is sepolia test net one
        PriceETHfetch = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        admin = msg.sender;
    }

     // 1e18 = 1 Ether
    uint public minimun_funding_valueinusd = 5e18 ;


    function receive_funds() public payable {
        require(getConversionRate(msg.value) >= minimun_funding_valueinusd ,"Minimum amount to send is : $5 ");



    }



    function getPrice() public view returns(uint256){
        (,int256 answer,,,) = PriceETHfetch.latestRoundData();
        return uint256(answer * 1e10);
    }


    function getConversionRate(uint ethAmount)public returns(uint) {
        // 2000 $
        // 2  --->> 2 * 2000 =  4000$
        (uint answerr) = getPrice();
        uint ethamountin_usd = (answerr * ethAmount) / 1e18;
        return ethamountin_usd;
    }

function withdraw_funds_adminonly(address payable _to) public {
    require(msg.sender == admin, "You are not the admin");
    _to.transfer(address(this).balance);
}



}