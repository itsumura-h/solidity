// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

/**
 * @title Counter Interface v0.1.0
 * @custom:version schema:0.1.0
 * @custom:version functions:0.1.0
 * @custom:version errors:0.1.0
 * @custom:version events:0.1.0
 */
interface ICounter {
  // Events
  event NumberSet(uint256 newNumber);

  // Functions
  function initializeV1(uint256 initialNumber) external;
  function getNumber() external returns (uint256);
  function increment() external;
  function setNumber(uint256 newNumber) external;
}
