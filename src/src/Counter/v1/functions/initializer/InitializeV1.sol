// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Schema} from "../../storage/Schema.sol";
import {Storage} from "../../storage/Storage.sol";

contract InitializeV1 {
  function initialize(uint256 initialNumber) external {
    Schema.State storage $ = Storage.state();
    $.number = initialNumber;
  }
}