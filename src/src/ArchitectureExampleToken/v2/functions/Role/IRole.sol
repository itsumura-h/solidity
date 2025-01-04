// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

interface IRole {
  event GrantAdminRole(address account);
  event GrantMinterRole(address account);
  // admin

  function hasAdminRole(address account) external view returns (bool);
  function grantAdminRole(address account) external;

  // minter
  function hasMinterRole(address account) external view returns (bool);
  function grantMinterRole(address account) external;
}
