// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Schema} from "./Schema.sol";

/**
 * @title Counter Storage Library v0.1.0
 */
library Storage {
  bytes32 constant STATE_POSITION =
    keccak256(abi.encode(uint256(keccak256(abi.encodePacked("counter.number"))) - 1)) & ~bytes32(uint256(0xff));

  function state() internal pure returns (Schema.State storage ref) {
    bytes32 position = STATE_POSITION;
    assembly {
      ref.slot := position
    }
  }
}
