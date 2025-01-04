// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/extensions/IERC20Metadata.sol

import {IERC20} from "./IERC20.sol";

interface IERC20Metadata is IERC20 {
  function name() external view returns (string memory);

  function symbol() external view returns (string memory);

  function decimals() external view returns (uint8);
}
