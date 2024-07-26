// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;
import "../contracts/ChainLink_Interface/AggregatorV3Interface.sol";

error Notadmin();
contract Fundme {

    AggregatorV3Interface private PriceETHfetch;
    address immutable public admin;
    uint public constant minimun_funding_valueinusd = 5e18;
    address[] public ourfunders;
    mapping(address => uint) public ourfunders_contributedamount;

    constructor() {
        // The address is sepolia test net one
        PriceETHfetch = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        admin = msg.sender;
    }


    fallback() external payable{
        receive_funds();
    }



    function receive_funds() public payable {
        require(getConversionRate(msg.value) >= minimun_funding_valueinusd,"Minimum amount to send is : $5 ");
        ourfunders.push(msg.sender);
        ourfunders_contributedamount[msg.sender] += msg.value;
    }

    function withdraw_funds_adminonly(address payable _to) public {
        for(uint256 i=0 ;i < ourfunders.length; i++){
        address resetfunders_array = ourfunders[i];
            ourfunders_contributedamount[resetfunders_array] = 0;
        }
    ourfunders  = new address[](0);
//                require(msg.sender == admin, "You are not the admin");
        if(msg.sender == admin){
            revert Notadmin();
        }
                _to.transfer(address(this).balance);
    }

    function getPrice() public view returns (uint256) {
        (, int256 answer, , , ) = PriceETHfetch.latestRoundData();
        return uint256(answer * 1e10);
    }

    function getConversionRate(uint ethAmount) public view returns (uint) {
        uint answerr = getPrice();
        uint ethamountin_usd = (answerr * ethAmount) / 1e18;
        return ethamountin_usd;
    }

}
