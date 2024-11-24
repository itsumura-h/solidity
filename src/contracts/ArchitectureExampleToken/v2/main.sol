// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {Schema} from "./storage/Schema.sol";
import {Storage} from "./storage/Storage.sol";
import {UUPS} from "./functions/UUPS/UUPS.sol";
import {ERC20Token} from "./functions/ERC20/ERC20Token.sol";

contract ArchitectureExampleTokenV2 is UUPS, ERC20Token {
  function initialize() public reinitializer(2) {
    __ERC20Token_init_v2("TestV2", "TESTV2");
  }
}
