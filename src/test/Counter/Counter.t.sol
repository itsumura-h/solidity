// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Counter} from "../../src/Counter/v1/Counter.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {Test} from "forge-std/Test.sol";

contract CounterTest is Test {
  Counter counter;

  function setUp() public {
    Counter _counterImpl = new Counter();
    ERC1967Proxy _counterProxy =
      new ERC1967Proxy(address(_counterImpl), abi.encodeWithSelector(Counter.initializeV1.selector, 0));
    counter = Counter(address(_counterProxy));
  }

  function test_setNumber() public {
    counter.setNumber(10);
    assertEq(counter.getNumber(), 10);
  }

  function test_increment() public {
    counter.increment();
    assertEq(counter.getNumber(), 1);
  }
}
