// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

contract ERC20Storage {
  struct Storage {
    string name;
    string symbol;
    uint256 totalSupply;
    mapping(address => uint256) balanceOf;
    mapping(address => mapping(address => uint256)) allowances;
  }

  Storage internal s;

  function _setName(string memory name_) internal {
    s.name = name_;
  }

  function _getName() internal view returns (string memory) {
    return s.name;
  }

  function _setSymbol(string memory symbol_) internal {
    s.symbol = symbol_;
  }

  function _getSymbol() internal view returns (string memory) {
    return s.symbol;
  }

  function _setTotalSupply(uint256 totalSupply_) internal {
    s.totalSupply = totalSupply_;
  }

  function _getTotalSupply() internal view returns (uint256) {
    return s.totalSupply;
  }

  function _setBalanceOf(address account, uint256 balance) internal {
    s.balanceOf[account] = balance;
  }

  function _getBalanceOf(address account) internal view returns (uint256) {
    return s.balanceOf[account];
  }

  function _setAllowance(
    address owner,
    address spender,
    uint256 amount
  ) internal {
    s.allowances[owner][spender] = amount;
  }

  function _getAllowance(
    address owner,
    address spender
  ) internal view returns (uint256) {
    return s.allowances[owner][spender];
  }
}
