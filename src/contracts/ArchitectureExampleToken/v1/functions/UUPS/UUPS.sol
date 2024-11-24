// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract UUPS is UUPSUpgradeable {
  function __UUPS_init() internal initializer {
    __UUPSUpgradeable_init();
  }

  function _authorizeUpgrade(address newImplementation) internal override {}
}
