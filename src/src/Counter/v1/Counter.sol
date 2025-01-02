// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {GetNumber} from "./functions/GetNumber.sol";
import {Increment} from "./functions/Increment.sol";
import {SetNumber} from "./functions/SetNumber.sol";
import {InitializeV1} from "./functions/initializer/InitializeV1.sol";

import {ICounter} from "./interfaces/ICounter.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract Counter is UUPSUpgradeable, ICounter {
  address private getNumberAddress;
  address private incrementAddress;
  address private setNumberAddress;

  function _authorizeUpgrade(address newImplementation) internal override {}

  function initializeV1(uint256 initialNumber) public initializer {
    __UUPSUpgradeable_init();
    getNumberAddress = address(new GetNumber());
    incrementAddress = address(new Increment());
    setNumberAddress = address(new SetNumber());
    (bool success,) =
      address(new InitializeV1()).delegatecall(abi.encodeWithSelector(InitializeV1.initialize.selector, initialNumber));
    require(success, "Failed to initialize");
  }

  function getNumber() public returns (uint256) {
    (bool success, bytes memory result) =
      getNumberAddress.delegatecall(abi.encodeWithSelector(GetNumber.invoke.selector));
    require(success, "Failed to get number");
    return abi.decode(result, (uint256));
  }

  function increment() public {
    (bool success,) = incrementAddress.delegatecall(abi.encodeWithSelector(Increment.invoke.selector));
    require(success, "Failed to increment");
  }

  function setNumber(uint256 newNumber) public {
    (bool success,) = setNumberAddress.delegatecall(abi.encodeWithSelector(SetNumber.invoke.selector, newNumber));
    require(success, "Failed to set number");
  }
}
