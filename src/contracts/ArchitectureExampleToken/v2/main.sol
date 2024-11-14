// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {Schema} from "./storage/Schema.sol";
import {Storage} from "./storage/Storage.sol";
import {ERC20Token} from "./functions/ERC20/ERC20Token.sol";
import {console} from "forge-std/console.sol";

contract ArchitectureExampleTokenV2 is UUPSUpgradeable, ERC20Token {
  function initialize() public reinitializer(2) {
    __ERC20Token_init("TestV2", "TESTV2");
  }

  // ==================================================
  // UUPS
  // ==================================================
  function _authorizeUpgrade(address newImplementation) internal override {}
}
