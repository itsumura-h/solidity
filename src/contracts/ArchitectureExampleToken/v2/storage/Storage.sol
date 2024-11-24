// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {Schema} from "./Schema.sol";

library Storage {
  bytes32 constant STATE_POSITION =
    keccak256(
      abi.encode(
        uint256(keccak256("erc20.architecture.example.token.state")) - 1
      )
    );

  function state()
    internal
    pure
    returns (Schema.ArchitectureExampleTokenSchema storage s)
  {
    bytes32 position = STATE_POSITION;
    assembly {
      s.slot := position
    }
  }
}
