// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC20Storage} from "./ERC20Storage.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract UpgradableErc20 is ERC20Storage, UUPSUpgradeable {
  function initialize(
    string memory name,
    string memory symbol
  ) public initializer {
    _setName(name);
    _setSymbol(symbol);
  }

  function _authorizeUpgrade(address newImplementation) internal override {}
}
