// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {RoleList} from "../../storage/Schema.sol";
import {IRole} from "./IRole.sol";
import {AccessControlUpgradeable} from "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";

contract Role is AccessControlUpgradeable, IRole {
  function initializeV2() public onlyInitializing {
    __AccessControl_init_unchained();
    _grantRole(RoleList.ADMIN_ROLE, msg.sender);
  }
  // ==================================================
  // Admin
  // ==================================================

  modifier onlyAdmin() {
    _checkRole(RoleList.ADMIN_ROLE);
    _;
  }

  function hasAdminRole(address account) public view returns (bool) {
    return hasRole(RoleList.ADMIN_ROLE, account);
  }

  function grantAdminRole(address account) public onlyAdmin {
    _grantRole(RoleList.ADMIN_ROLE, account);
    emit GrantAdminRole(account);
  }

  // ==================================================
  // Minter
  // ==================================================
  modifier onlyMinter() {
    _checkRole(RoleList.MINTER_ROLE);
    _;
  }

  function hasMinterRole(address account) public view returns (bool) {
    return hasRole(RoleList.MINTER_ROLE, account);
  }

  function grantMinterRole(address account) public onlyAdmin {
    _grantRole(RoleList.MINTER_ROLE, account);
    emit GrantMinterRole(account);
  }
}
