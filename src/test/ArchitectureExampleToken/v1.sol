// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {ArchitectureExampleToken} from "../../src/ArchitectureExampleToken/v1/ArchitectureExampleToken.sol";
import {RoleList} from "../../src/ArchitectureExampleToken/v1/storage/Schema.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";

contract ArchitectureExampleTokenV1Test is Test {
  ArchitectureExampleToken public token;
  address public deployer = makeAddr("deployer");

  function setUp() public {
    vm.startPrank(deployer);
    ArchitectureExampleToken _token = new ArchitectureExampleToken();
    ERC1967Proxy _proxy = new ERC1967Proxy(
      address(_token), abi.encodeWithSelector(ArchitectureExampleToken.initialize.selector, "Test", "TEST")
    );
    token = ArchitectureExampleToken(address(_proxy));
    vm.stopPrank();
  }

  function test_initialized() public {
    assertEq(token.name(), "Test");
    assertEq(token.symbol(), "TEST");
  }

  function test_mint() public {
    address minter = makeAddr("minter");
    address alice = makeAddr("alice");

    assertEq(token.balanceOf(alice), 0);

    vm.prank(deployer);
    token.grantMinterRole(minter);

    bool hasMintRole = token.hasMinterRole(minter);
    console.log("hasMintRole", hasMintRole);
    assertTrue(hasMintRole);

    vm.prank(minter);
    token.mint(alice, 100);
    assertEq(token.balanceOf(alice), 100);
  }

  function test_CannotMintWithoutAuthorization() public {
    address userWithoutRole = makeAddr("userWithoutRole");
    vm.prank(userWithoutRole);
    vm.expectRevert();
    token.mint(userWithoutRole, 100);

    bool hasMinterRole = token.hasMinterRole(userWithoutRole);
    assertFalse(hasMinterRole);
  }

  //   function test_Transfer() public {
  //     address minter = makeAddr("minter");
  //     address alice = makeAddr("alice");
  //     address bob = makeAddr("bob");

  //     vm.prank(deployer);
  //     proxy.grantMinterRole(minter);

  //     vm.prank(minter);
  //     proxy.mint(alice, 100);

  //     vm.prank(alice);
  //     proxy.transfer(bob, 10);

  //     assertEq(proxy.balanceOf(alice), 90);
  //     assertEq(proxy.balanceOf(bob), 10);
  //   }
}
