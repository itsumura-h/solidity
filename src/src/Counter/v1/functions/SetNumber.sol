// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ICounter} from "../interfaces/ICounter.sol";
import {Schema} from "../storage/Schema.sol";
import {Storage} from "../storage/Storage.sol";

contract SetNumber {
  function invoke(uint256 newNumber) external {
    Schema.State storage $ = Storage.state();
    $.number = newNumber;
    emit ICounter.NumberSet(newNumber);
  }
}
