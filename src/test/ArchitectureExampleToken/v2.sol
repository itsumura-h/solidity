// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {ArchitectureExampleToken as ArchitectureExampleTokenV1} from
  "../../src/ArchitectureExampleToken/v1/ArchitectureExampleToken.sol";
import {ArchitectureExampleToken as ArchitectureExampleTokenV2} from
  "../../src/ArchitectureExampleToken/v2/ArchitectureExampleToken.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";

contract ArchitectureExampleTokenV2Test is Test {
  ArchitectureExampleTokenV1 public v1Token;
  ArchitectureExampleTokenV2 public v2Token;
  address public deployer = makeAddr("deployer");
  address public minter = makeAddr("minter");
  address public alice = makeAddr("alice");
  address public bob = makeAddr("bob");

  function setupV1() private {
    ArchitectureExampleTokenV1 _v1Token = new ArchitectureExampleTokenV1();
    vm.prank(deployer);
    ERC1967Proxy _v1Proxy =
      new ERC1967Proxy(address(_v1Token), abi.encodeWithSelector(_v1Token.initialize.selector, "Test", "TEST"));
    v1Token = ArchitectureExampleTokenV1(address(_v1Proxy));

    vm.prank(deployer);
    v1Token.grantMinterRole(minter);

    vm.prank(minter);
    v1Token.mint(alice, 10000);
    assertEq(v1Token.balanceOf(alice), 10000);
  }

  function setupV2() private {
    ArchitectureExampleTokenV2 _v2TokenImpl = new ArchitectureExampleTokenV2();
    vm.prank(deployer);
    v1Token.upgradeToAndCall(
      address(_v2TokenImpl), abi.encodeWithSelector(ArchitectureExampleTokenV2.initializeV2.selector, "Test v2", "TEST")
    );
    v2Token = ArchitectureExampleTokenV2(address(v1Token));
    assertEq(v2Token.balanceOf(alice), 10000);
  }

  function setUp() public {
    setupV1();
    setupV2();

    //     ArchitectureExampleTokenV2 token = new ArchitectureExampleTokenV2();
    //     vm.prank(deployer);
    //     v1Proxy.upgradeToAndCall(address(token), abi.encodeWithSelector(token.initialize.selector));
    //     proxy = ArchitectureExampleTokenV2(address(v1Proxy));
  }

  function test_v2() public {}

  //   function test_V2Initialized() public {
  //     assertEq(proxy.name(), "TestV2");
  //     assertEq(proxy.symbol(), "TESTV2");
  //   }

  //   function test_AliceBalance() public {
  //     uint256 balance = proxy.balanceOf(alice);
  //     console.log("balance", balance);
  //     assertEq(balance, 10000);
  //   }

  //   /**
  //    * 送信した合計金額を記録するテーブル
  //    */
  //   function test_SumTransfered() public {
  //     uint256 sum = proxy.sumTransfered(alice);
  //     console.log("alice sumTransfered: ", sum);
  //     assertEq(sum, 0);

  //     vm.prank(alice);
  //     proxy.transfer(bob, 1000);

  //     sum = proxy.sumTransfered(alice);
  //     console.log("alice sumTransfered: ", sum);
  //     assertEq(sum, 1000);
  //   }
}
