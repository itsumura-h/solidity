// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {Implement} from "./app/Implement.sol";
import {console} from "forge-std/console.sol";

contract ArchitectureExampleToken is Implement {
  function initialize(string memory name, string memory symbol) public {
    __Implement_init(name, symbol);
  }
}
