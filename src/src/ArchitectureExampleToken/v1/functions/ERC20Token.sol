// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC20Upgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";

contract ERC20Token is ERC20Upgradeable {
  function initialize(string memory name, string memory symbol) public initializer {
    __ERC20_init(name, symbol);
  }

  function mint(address to, uint256 value) public virtual returns (bool) {
    _mint(to, value);
    return true;
  }
}
