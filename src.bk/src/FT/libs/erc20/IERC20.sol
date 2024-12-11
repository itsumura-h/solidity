// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol

interface IERC20 {
  /**
   * @dev `value`トークンがあるアカウント(`from`)から別のアカウント(`to`)に移動したときに発行されます。
   *
   * `value`はゼロの場合もあることに注意してください。
   */
  event Transfer(address indexed from, address indexed to, uint256 value);

  /**
   * @dev `owner`の`spender`に対する許可量が{approve}の呼び出しによって設定されたときに発行されます。
   * `value`は新しい許可量です。
   */
  event Approval(address indexed owner, address indexed spender, uint256 value);

  function totalSupply() external view returns (uint256);

  function balanceOf(address account) external view returns (uint256);

  function transfer(address recipient, uint256 amount) external returns (bool);

  function allowance(
    address owner,
    address spender
  ) external view returns (uint256);

  function approve(address spender, uint256 amount) external returns (bool);

  function transferFrom(
    address sender,
    address recipient,
    uint256 amount
  ) external returns (bool);
}
