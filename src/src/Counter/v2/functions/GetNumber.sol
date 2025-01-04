// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Schema} from "../storage/Schema.sol";
import {Storage} from "../storage/Storage.sol";

contract GetNumber {
  function invoke() external view returns (uint256) {
    Schema.State storage $ = Storage.state();
    return $.number;
  }
}
