// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {ERC20Upgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";

library Schema {
  struct ArchitectureExampleTokenSchema {
    ERC20Upgradeable erc20Store;
    mapping(address => uint256) sumTransfered;
  }
}
