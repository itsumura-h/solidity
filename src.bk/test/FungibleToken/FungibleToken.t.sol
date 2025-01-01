// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {FungibleToken} from "../../src/FT/FungibleToken.sol";
import {IERC20Errors} from "../../src/FT/libs/erc20/IERC20Errors.sol";

contract FungibleTokenTest is Test {
    FungibleToken public token;

    function setUp() public {
        token = new FungibleToken("TestToken", "TEST");
    }

    function test_getter() public view {
        assertEq(token.name(), "TestToken");
        assertEq(token.symbol(), "TEST");
        assertEq(token.decimals(), 18);
        assertEq(token.totalSupply(), 0);
    }

    function test_mintAndBurn(uint256 x) public {
        token.mint(address(this), x);
        assertEq(token.balanceOf(address(this)), x);
        assertEq(token.totalSupply(), x);

        token.burn(address(this), x);
        assertEq(token.balanceOf(address(this)), 0);
        assertEq(token.totalSupply(), 0);
    }

    function test_transfer() public {
        address alice = makeAddr("alice");
        address bob = makeAddr("bob");

        token.mint(alice, 100);
        assertEq(token.balanceOf(alice), 100);
        assertEq(token.balanceOf(bob), 0);

        vm.prank(alice); // alice がトランザクションを送信する
        token.transfer(bob, 100);
        assertEq(token.balanceOf(alice), 0);
        assertEq(token.balanceOf(bob), 100);
    }

    function test_transferFrom() public {
        address alice = makeAddr("alice");
        address bob = makeAddr("bob");

        token.mint(alice, 100);
        assertEq(token.balanceOf(alice), 100);
        assertEq(token.balanceOf(bob), 0);

        // approve
        vm.prank(alice);
        token.approve(bob, 100);
        assertEq(token.allowance(alice, bob), 100);

        // transferFrom
        vm.prank(bob);
        token.transferFrom(alice, bob, 100);
        assertEq(token.balanceOf(alice), 0);
        assertEq(token.balanceOf(bob), 100);
        assertEq(token.allowance(alice, bob), 0);
    }

    function test_transferFrom_revert() public {
        address alice = makeAddr("alice");
        address bob = makeAddr("bob");

        token.mint(alice, 100);
        assertEq(token.balanceOf(alice), 100);
        assertEq(token.balanceOf(bob), 0);

        assertEq(token.allowance(alice, bob), 0);
        vm.prank(bob);
        vm.expectRevert(
            abi.encodeWithSelector(
                IERC20Errors.ERC20InsufficientAllowance.selector,
                bob, // transferFrom を実行しようとしているアドレス
                0, // 現在許可されているトークンの量
                100 // 転送に必要な許可されているトークンの量
            )
        );
        token.transferFrom(alice, bob, 100);
    }

    function test_increaseAllowance(uint256 x) public {
        console2.log("x", x);
        address alice = makeAddr("alice");
        address bob = makeAddr("bob");

        assertEq(token.allowance(alice, bob), 0);
        vm.prank(alice);
        token.increaseAllowance(bob, x);
        assertEq(token.allowance(alice, bob), x);
    }

    function test_increaseAllowance_overflow() public {
        address alice = makeAddr("alice");
        address bob = makeAddr("bob");

        assertEq(token.allowance(alice, bob), 0);
        vm.prank(alice);
        token.increaseAllowance(bob, type(uint256).max);
        assertEq(token.allowance(alice, bob), type(uint256).max);
    }

    function test_decreaseAllowance(uint256 x) public {
        address alice = makeAddr("alice");
        address bob = makeAddr("bob");

        assertEq(token.allowance(alice, bob), 0);
        vm.prank(alice);
        token.decreaseAllowance(bob, x);
        assertEq(token.allowance(alice, bob), 0);
    }

    function test_decreaseAllowance_underflow() public {
        address alice = makeAddr("alice");
        address bob = makeAddr("bob");

        assertEq(token.allowance(alice, bob), 0);
        vm.prank(alice);
        token.decreaseAllowance(bob, type(uint256).max);
        assertEq(token.allowance(alice, bob), 0);
    }
}
