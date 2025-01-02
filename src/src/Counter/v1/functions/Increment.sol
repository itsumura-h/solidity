// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ICounter} from "../ICounter.sol";
import {Schema} from "../storage/Schema.sol";
import {Storage} from "../storage/Storage.sol";

contract Increment {
  function invoke() external {
    Schema.State storage $ = Storage.state();
    $.number++;
    emit ICounter.NumberSet($.number);
  }
}
