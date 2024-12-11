// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Context} from "./Context.sol";
import {IERC20Metadata} from "./IERC20Metadata.sol";
import {IERC20Errors} from "./IERC20Errors.sol";
import {console2} from "forge-std/console2.sol";

abstract contract ERC20Internal is Context, IERC20Metadata, IERC20Errors {
  string internal _name;
  string internal _symbol;
  uint256 internal _totalSupply;

  mapping(address => uint256) internal _balanceOf;
  mapping(address account => mapping(address spender => uint256))
    internal _allowances;

  constructor(string memory name_, string memory symbol_) {
    _name = name_;
    _symbol = symbol_;
  }

  /**
   * @dev トークンの転送を行います。
   * @param from 送信者のアドレス。
   * @param to 受信者のアドレス。
   * @param value 転送されるトークンの量。
   */
  function _update(address from, address to, uint256 value) internal virtual {
    if (from == address(0)) {
      unchecked {
        _totalSupply += value;
      }
    } else {
      uint256 fromBalance = _balanceOf[from];
      if (fromBalance < value) {
        revert ERC20InsufficientBalance(from, fromBalance, value);
      }
      unchecked {
        _balanceOf[from] = fromBalance - value;
      }
    }

    if (to == address(0)) {
      unchecked {
        _totalSupply -= value;
      }
    } else {
      unchecked {
        _balanceOf[to] += value;
      }
    }

    emit Transfer(from, to, value);
  }

  function _mint(address account, uint256 value) internal {
    if (account == address(0)) {
      revert ERC20InvalidReceiver(address(0));
    }
    _update(address(0), account, value);
  }

  function _burn(address account, uint256 value) internal {
    if (account == address(0)) {
      revert ERC20InvalidSender(account);
    }
    _update(account, address(0), value);
  }

  function _transfer(address from, address to, uint256 value) internal {
    if (from == address(0)) {
      revert ERC20InvalidSender(address(0));
    }
    if (to == address(0)) {
      revert ERC20InvalidReceiver(address(0));
    }
    _update(from, to, value);
  }

  function _approve(
    address owner,
    address spender,
    uint256 value,
    bool emitEvent
  ) internal {
    if (owner == address(0)) {
      revert ERC20InvalidApprover(address(0));
    }
    if (spender == address(0)) {
      revert ERC20InvalidSpender(address(0));
    }
    _allowances[owner][spender] = value;
    if (emitEvent) {
      emit Approval(owner, spender, value);
    }
  }

  function _spendAllowance(
    address owner,
    address spender,
    uint256 value
  ) internal virtual {
    uint256 currentAllowance = _allowances[owner][spender];
    if (currentAllowance < value) {
      revert ERC20InsufficientAllowance(spender, currentAllowance, value);
    }
    unchecked {
      _approve(owner, spender, currentAllowance - value, false);
    }
  }
}
