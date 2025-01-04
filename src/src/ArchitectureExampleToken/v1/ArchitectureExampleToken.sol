// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {ERC20Token} from "./functions/ERC20Token.sol";
import {Role} from "./functions/Role/Role.sol";
import {Schema} from "./storage/Schema.sol";
import {Storage} from "./storage/Storage.sol";

import {AccessControlUpgradeable} from "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {ERC20Upgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";

contract ArchitectureExampleToken is UUPSUpgradeable {
  address private erc20TokenAddress;
  address private roleAddress;

  function _authorizeUpgrade(address newImplementation) internal override {}

  function initialize(string memory _name, string memory _symbol) public initializer {
    __UUPSUpgradeable_init();
    erc20TokenAddress = address(new ERC20Token());
    (bool success,) =
      erc20TokenAddress.delegatecall(abi.encodeWithSelector(ERC20Token.initialize.selector, _name, _symbol));
    require(success, "ERC20Token: initialize call failed");
    roleAddress = address(new Role());
    (success,) = roleAddress.delegatecall(abi.encodeWithSelector(Role.initialize.selector));
    require(success, "Role: initialize call failed");
  }

  function name() public returns (string memory) {
    (bool success, bytes memory result) =
      erc20TokenAddress.delegatecall(abi.encodeWithSelector(ERC20Upgradeable.name.selector));
    require(success, "ERC20Token: name call failed");
    return abi.decode(result, (string));
  }

  function symbol() public virtual returns (string memory) {
    (bool success, bytes memory result) =
      erc20TokenAddress.delegatecall(abi.encodeWithSelector(ERC20Upgradeable.symbol.selector));
    require(success, "ERC20Token: symbol call failed");
    return abi.decode(result, (string));
  }

  function decimals() public virtual returns (uint8) {
    (bool success, bytes memory result) =
      erc20TokenAddress.delegatecall(abi.encodeWithSelector(ERC20Upgradeable.decimals.selector));
    require(success, "ERC20Token: decimals call failed");
    return abi.decode(result, (uint8));
  }

  function totalSupply() public virtual returns (uint256) {
    (bool success, bytes memory result) =
      erc20TokenAddress.delegatecall(abi.encodeWithSelector(ERC20Upgradeable.totalSupply.selector));
    require(success, "ERC20Token: totalSupply call failed");
    return abi.decode(result, (uint256));
  }

  function balanceOf(address account) public virtual returns (uint256) {
    (bool success, bytes memory result) =
      erc20TokenAddress.delegatecall(abi.encodeWithSelector(ERC20Upgradeable.balanceOf.selector, account));
    require(success, "ERC20Token: balanceOf call failed");
    return abi.decode(result, (uint256));
  }

  function mint(address to, uint256 value) public onlyMinter returns (bool) {
    (bool success,) = erc20TokenAddress.delegatecall(abi.encodeWithSelector(ERC20Token.mint.selector, to, value));
    require(success, "ERC20Token: mint call failed");
    return true;
  }

  function transfer(address to, uint256 value) public virtual returns (bool) {
    (bool success, bytes memory result) =
      erc20TokenAddress.delegatecall(abi.encodeWithSelector(ERC20Upgradeable.transfer.selector, to, value));
    require(success, "ERC20Token: transfer call failed");
    return abi.decode(result, (bool));
  }

  function allowance(address owner, address spender) public virtual returns (uint256) {
    (bool success, bytes memory result) =
      erc20TokenAddress.delegatecall(abi.encodeWithSelector(ERC20Upgradeable.allowance.selector, owner, spender));
    require(success, "ERC20Token: allowance call failed");
    return abi.decode(result, (uint256));
  }

  function approve(address spender, uint256 value) public virtual returns (bool) {
    (bool success, bytes memory result) =
      erc20TokenAddress.delegatecall(abi.encodeWithSelector(ERC20Upgradeable.approve.selector, spender, value));
    require(success, "ERC20Token: approve call failed");
    return abi.decode(result, (bool));
  }

  function transferFrom(address from, address to, uint256 value) public virtual returns (bool) {
    (bool success, bytes memory result) =
      erc20TokenAddress.delegatecall(abi.encodeWithSelector(ERC20Upgradeable.transferFrom.selector, from, to, value));
    require(success, "ERC20Token: transferFrom call failed");
    return abi.decode(result, (bool));
  }

  // ==================== Role ====================
  modifier onlyAdmin() {
    require(hasAdminRole(msg.sender), "Role: caller is not an admin");
    _;
  }

  modifier onlyMinter() {
    require(hasMinterRole(msg.sender), "Role: caller is not a minter");
    _;
  }

  function hasAdminRole(address account) public returns (bool) {
    (bool success, bytes memory result) =
      roleAddress.delegatecall(abi.encodeWithSelector(Role.hasAdminRole.selector, account));
    require(success, "Role: hasAdminRole call failed");
    return abi.decode(result, (bool));
  }

  function grantAdminRole(address account) public {
    (bool success,) = roleAddress.delegatecall(abi.encodeWithSelector(Role.grantAdminRole.selector, account));
    require(success, "Role: grantAdminRole call failed");
  }

  function hasMinterRole(address account) public returns (bool) {
    (bool success, bytes memory result) =
      roleAddress.delegatecall(abi.encodeWithSelector(Role.hasMinterRole.selector, account));
    require(success, "Role: hasMinterRole call failed");
    return abi.decode(result, (bool));
  }

  function grantMinterRole(address account) public {
    (bool success,) = roleAddress.delegatecall(abi.encodeWithSelector(Role.grantMinterRole.selector, account));
    require(success, "Role: grantMinterRole call failed");
  }
}
