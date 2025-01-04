// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

interface IArchitectureExampleToken {
  // functions
  // erc20
  function initialize(string memory name, string memory symbol) external;
  function name() external returns (string memory);
  function symbol() external returns (string memory);
  function decimals() external returns (uint8);
  function totalSupply() external returns (uint256);
  function balanceOf(address account) external returns (uint256);
  function mint(address to, uint256 value) external returns (bool);
  function transfer(address to, uint256 value) external returns (bool);
  function allowance(address owner, address spender) external returns (uint256);
  function approve(address spender, uint256 value) external returns (bool);
  function transferFrom(address from, address to, uint256 value) external returns (bool);
  // roles
  function hasAdminRole(address account) external returns (bool);
  function grantAdminRole(address account) external;
  function hasMinterRole(address account) external returns (bool);
  function grantMinterRole(address account) external;

  // events
  event Transfer(address indexed from, address indexed to, uint256 value);
  event Approval(address indexed owner, address indexed spender, uint256 value);
}
