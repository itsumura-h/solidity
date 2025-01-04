// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

library GetSlotLocation {
  function invoke(string memory name) internal pure returns (bytes32) {
    return keccak256(abi.encode(uint256(keccak256(abi.encodePacked(name))) - 1)) & ~bytes32(uint256(0xff));
  }
}
