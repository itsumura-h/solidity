// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {GetSlotLocation} from "../libs/GetSlotLocation.sol";
import {Schema} from "./Schema.sol";

/**
 * @title Counter Storage Library v0.1.0
 */
library Storage {
  function state() internal pure returns (Schema.State storage ref) {
    bytes32 slot = GetSlotLocation.invoke("counter.number");
    assembly {
      ref.slot := slot
    }
  }
}
