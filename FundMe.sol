//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

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
      addressToAmountFunded[msg.sender] += msg.value;
      
    }

    function withDraw() public {
      for(uint256 funderIndex=0 ; funderIndex< funders.length ; funderIndex=funderIndex+1 ){
           address funder = funders[funderIndex];
           addressToAmountFunded[funder] =0;
      }

      //reset an array
      funders = new address[](0);

      // actually withdraw the funds through 3 waaays
      // trasfer
     // payable(msg.sender).trasfer(address(this).balance);
      //send 
      //bool sendSuccess = payable(msg.sender).send(address(this).balance);
      //require(sendSuccess, "Didn't send success!")
      //call
       (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
      require(callSuccess, "Didn't call success!")
    }

    
    

}
