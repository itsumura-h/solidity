// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Initializable} from "@openzeppelin/contracts/proxy/utils/Initializable.sol";
import {Storage} from "./storage/Storage.sol";

contract Counter is Initializable {
  using Storage for Schema.CounterState;

  function initialize() public initializer {
    Storage.CounterState().number = 0;
  }
}
