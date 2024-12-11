// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {ArchitectureExampleTokenV1} from "../../src/ArchitectureExampleToken/v1/main.sol";
import {RoleList} from "../../src/ArchitectureExampleToken/v1/libs/Role/Role.sol";

contract ArchitectureExampleTokenV1Test is Test {
    ArchitectureExampleTokenV1 public token;
    ArchitectureExampleTokenV1 public proxy;
    address public deployer = makeAddr("deployer");

    function setUp() public {
        token = new ArchitectureExampleTokenV1();
        vm.prank(deployer);
        ERC1967Proxy _proxy = new ERC1967Proxy(
            address(token),
            abi.encodeWithSelector(token.initialize.selector, "Test", "TEST")
        );
        proxy = ArchitectureExampleTokenV1(address(_proxy));
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

    function test_Transfer() public {
        address minter = makeAddr("minter");
        address alice = makeAddr("alice");
        address bob = makeAddr("bob");

        vm.prank(deployer);
        proxy.grantMinterRole(minter);

        vm.prank(minter);
        proxy.mint(alice, 100);

        vm.prank(alice);
        proxy.transfer(bob, 10);

        assertEq(proxy.balanceOf(alice), 90);
        assertEq(proxy.balanceOf(bob), 10);
    }
}
