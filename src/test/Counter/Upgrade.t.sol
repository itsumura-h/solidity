// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Counter as CounterV1} from "../../src/Counter/v1/Counter.sol";
import {Counter as CounterV2} from "../../src/Counter/v2/Counter.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {Test} from "forge-std/Test.sol";

contract CounterUpgradeTest is Test {
  function setUp() public {}

  function test_counterUpgrade() public {
    // V1 ===============================================
    CounterV1 _counterV1Impl = new CounterV1();
    ERC1967Proxy _counterV1Proxy =
      new ERC1967Proxy(address(_counterV1Impl), abi.encodeWithSelector(CounterV1.initializeV1.selector, 0));
    CounterV1 counter = CounterV1(address(_counterV1Proxy));

    counter.setNumber(1);
    assert(counter.getNumber() == 1);

    counter.increment();
    assert(counter.getNumber() == 2);

    // V2 ===============================================
    CounterV2 _counterV2Impl = new CounterV2();
    counter.upgradeToAndCall(address(_counterV2Impl), abi.encodeWithSelector(CounterV2.initializeV2.selector));

    counter.setNumber(1);
    assert(counter.getNumber() == 1);

    counter.increment();
    assert(counter.getNumber() == 3);
  }
}
