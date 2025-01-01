// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {TestToken} from "../src/TestToken/TestToken.sol";

contract DeployTest {
  function run() public {
    TestToken token = new TestToken("TestToken", "TEST");
  }
}
