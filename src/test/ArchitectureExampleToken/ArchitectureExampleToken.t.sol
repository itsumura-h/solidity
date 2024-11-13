// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {Test} from "forge-std/Test.sol";
import {ArchitectureExampleToken} from "../../contracts/ArchitectureExampleToken/main.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {RoleList} from "../../contracts/ArchitectureExampleToken/app/functions/Role/Role.sol";
import {console} from "forge-std/console.sol";

contract ArchitectureExampleTokenTest is Test {
  ArchitectureExampleToken public token;
  ArchitectureExampleToken public proxy;
  address public deployer = makeAddr("deployer");

  function setUp() public {
    token = new ArchitectureExampleToken();
    vm.prank(deployer);
    ERC1967Proxy _proxy = new ERC1967Proxy(
      address(token),
      abi.encodeWithSelector(token.initialize.selector, "Test", "TEST")
    );
    proxy = ArchitectureExampleToken(address(_proxy));
  }

  function test_initialized() public {
    assertEq(proxy.name(), "Test");
    assertEq(proxy.symbol(), "TEST");
  }

  function test_mint() public {
    address minter = makeAddr("minter");
    address alice = makeAddr("alice");

    assertEq(proxy.balanceOf(alice), 0);

    vm.prank(deployer);
    proxy.grantMinterRole(minter);

    bool hasMintRole = proxy.hasRole(RoleList.MINTER_ROLE, minter);
    console.log("hasMintRole", hasMintRole);
    assertTrue(hasMintRole);

    vm.prank(minter);
    proxy.mint(alice, 100);
    assertEq(proxy.balanceOf(alice), 100);
  }

  function test_CannotMintWithoutAuthorization() public {
    address userWithoutRole = makeAddr("userWithoutRole");
    vm.prank(userWithoutRole);
    vm.expectRevert();
    proxy.mint(userWithoutRole, 100);
  }
}
