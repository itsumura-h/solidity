// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {Schema} from "./storage/Schema.sol";
import {Storage} from "./storage/Storage.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {ERC20Token} from "./functions/ERC20/ERC20Token.sol";
import {Interface} from "./Interface.sol";

import {console} from "forge-std/console.sol";

contract Implement is UUPSUpgradeable, Interface, ERC20Token {
  function __Implement_init(
    string memory name,
    string memory symbol
  ) internal initializer {
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
