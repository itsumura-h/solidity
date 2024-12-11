// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {AccessControlUpgradeable} from "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";
import {RoleEvents} from "./RoleEvent.sol";
import {IRole} from "./IRole.sol";

library RoleList {
  bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
  bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
}

contract Role is AccessControlUpgradeable, RoleEvents, IRole {
  function __Role_init() internal onlyInitializing {
    __AccessControl_init();
    _grantRole(RoleList.ADMIN_ROLE, msg.sender);
  }

  // ==================================================
  // Admin
  // ==================================================
  modifier onlyAdmin() {
    _checkRole(RoleList.ADMIN_ROLE);
    _;
  }

  function hasAdminRole(address account) public view virtual returns (bool) {
    return hasRole(RoleList.ADMIN_ROLE, account);
  }

  function grantAdminRole(address account) public virtual onlyAdmin {
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

  function hasMinterRole(address account) public view virtual returns (bool) {
    return hasRole(RoleList.MINTER_ROLE, account);
  }

  function grantMinterRole(address account) public virtual onlyAdmin {
    _grantRole(RoleList.MINTER_ROLE, account);
    emit GrantMinterRole(account);
  }
}
