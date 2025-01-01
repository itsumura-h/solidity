// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {console} from "forge-std/console.sol";

contract Counter {
  uint256 public number;

  function setNumber(uint256 newNumber) public {
    console.log("Setting number to", newNumber);
    number = newNumber;
  }

  function increment() public {
    console.log("Incrementing number to", number + 1);
    number++;
  }
}
