// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

abstract contract RoleEvents {
  event GrantAdminRole(address indexed account);
  event GrantMinterRole(address indexed account);
}
