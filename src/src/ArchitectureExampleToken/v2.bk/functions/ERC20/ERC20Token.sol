// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {Role} from "../../libs/Role/Role.sol";
import {Schema} from "../../storage/Schema.sol";
import {Storage} from "../../storage/Storage.sol";
import {ERC20Upgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";

contract ERC20Token is ERC20Upgradeable, Role {
  function __ERC20Token_init(string memory name, string memory symbol) internal onlyInitializing {
    __ERC20_init(name, symbol);
  }

  function __ERC20Token_init_v2(string memory name, string memory symbol) internal onlyInitializing {
    __ERC20_init_unchained(name, symbol);
  }

  function mint(address to, uint256 amount) public onlyMinter {
    _mint(to, amount);
  }

  function sumTransfered(address account) public view returns (uint256) {
    Schema.ArchitectureExampleTokenSchema storage s = Storage.state();
    return s.sumTransfered[account];
  }

  function transfer(address to, uint256 amount) public override(ERC20Upgradeable) returns (bool) {
    Schema.ArchitectureExampleTokenSchema storage s = Storage.state();
    super.transfer(to, amount);
    s.sumTransfered[msg.sender] += amount;
    return true;
  }

  function transferFrom(address from, address to, uint256 amount) public override(ERC20Upgradeable) returns (bool) {
    Schema.ArchitectureExampleTokenSchema storage s = Storage.state();
    super.transferFrom(from, to, amount);
    s.sumTransfered[from] += amount;
    return true;
  }
}
