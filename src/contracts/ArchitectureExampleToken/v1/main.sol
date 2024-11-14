// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {Schema} from "./storage/Schema.sol";
import {Storage} from "./storage/Storage.sol";
import {ERC20Token} from "./functions/ERC20/ERC20Token.sol";

contract ArchitectureExampleTokenV1 is UUPSUpgradeable, ERC20Token {
  function initialize(
    string memory name,
    string memory symbol
  ) public initializer {
    Schema.ArchitectureExampleTokenSchema storage s = Storage.state();
    __UUPSUpgradeable_init();
    __ERC20Token_init(name, symbol);
    __Role_init();
  }

  // ==================================================
  // UUPS
  // ==================================================
  function _authorizeUpgrade(address newImplementation) internal override {}
}
