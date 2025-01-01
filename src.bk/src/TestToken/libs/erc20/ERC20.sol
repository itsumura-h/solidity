// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol

import "@openzeppelin/contracts/utils/math/Math.sol";
import {Context} from "./Context.sol";
import {ERC20Internal} from "./ERC20Internal.sol";
import {IERC20} from "./IERC20.sol";

abstract contract ERC20 is IERC20, ERC20Internal {
  constructor(
    string memory name_,
    string memory symbol_
  ) ERC20Internal(name_, symbol_) {}

  // ==================== Getter ====================
  function name() public view returns (string memory) {
    return _name;
  }

  function symbol() public view returns (string memory) {
    return _symbol;
  }

  function decimals() public pure returns (uint8) {
    return 18;
  }

  function totalSupply() public view returns (uint256) {
    return _totalSupply;
  }

  function balanceOf(address account) public view returns (uint256) {
    return _balanceOf[account];
  }

  function allowance(
    address owner,
    address spender
  ) public view returns (uint256) {
    return _allowances[owner][spender];
  }

  // ==================== Setter ====================
  function transfer(address to, uint256 value) public returns (bool) {
    address owner = _msgSender();
    _transfer(owner, to, value);
    return true;
  }

  function approve(address spender, uint256 value) public returns (bool) {
    address owner = _msgSender();
    _approve(owner, spender, value, true);
    return true;
  }

  function transferFrom(
    address from,
    address to,
    uint256 value
  ) public returns (bool) {
    address spender = _msgSender();
    _spendAllowance(from, spender, value);
    _transfer(from, to, value);
    return true;
  }

  function increaseAllowance(
    address spender,
    uint256 addedValue
  ) public returns (bool) {
    address owner = _msgSender();
    (bool success, uint256 newAllowance) = Math.tryAdd(
      _allowances[owner][spender],
      addedValue
    );
    if (!success) newAllowance = type(uint256).max;
    _approve(owner, spender, newAllowance, true);
    return true;
  }

  function decreaseAllowance(
    address spender,
    uint256 subtractedValue
  ) public returns (bool) {
    address owner = _msgSender();

    (bool success, uint256 newAllowance) = Math.trySub(
      _allowances[owner][spender],
      subtractedValue
    );
    if (!success) newAllowance = 0;
    _approve(owner, spender, newAllowance, true);
    return true;
  }
}
