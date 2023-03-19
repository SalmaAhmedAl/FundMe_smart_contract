//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "./PriceConverter.sol";

contract FundMe{
      using PriceConverter for uint256;
    uint256 minNumberUSD =50 * 1e18;

    address[] public funders;
    mapping (address =>uint256) addressToAmountFunded;
    function fund() public payable{
      //How do we send ETH to this contract?
      require(msg.value.getConversionRate() >= minNumberUSD, "Didn't send enough!");
      //18 decimal

      funders.push(msg.sender);
      addressToAmountFunded[msg.sender]= msg.value;
      
    }

    
    

}
