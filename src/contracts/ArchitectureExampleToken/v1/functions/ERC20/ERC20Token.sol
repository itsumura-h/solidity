// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {ERC20Upgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import {Role} from "../../libs/Role/Role.sol";

contract ERC20Token is ERC20Upgradeable, Role {
  function __ERC20Token_init(
    string memory name,
    string memory symbol
  ) internal onlyInitializing {
    __ERC20_init(name, symbol);
  }

  function mint(address to, uint256 amount) public virtual onlyMinter {
    _mint(to, amount);
  }
}
