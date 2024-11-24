// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {Schema} from "./storage/Schema.sol";
import {Storage} from "./storage/Storage.sol";
import {UUPS} from "./functions/UUPS/UUPS.sol";
import {ERC20Token} from "./functions/ERC20/ERC20Token.sol";

contract ArchitectureExampleTokenV1 is UUPS, ERC20Token {
  function initialize(
    string memory name,
    string memory symbol
  ) public initializer {
    Schema.ArchitectureExampleTokenSchema storage s = Storage.state();
    __UUPS_init();
    __ERC20Token_init(name, symbol);
    __Role_init();
  }
}
