// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {console2} from "forge-std/console2.sol";
import {FungibleToken} from "../src/FT/FungibleToken.sol";

struct Wallet {
    address addr;
    uint256 publicKeyX;
    uint256 publicKeyY;
    uint256 privateKey;
}

contract Address is Script {
    function run() public {
        address thisAddress = address(this);
        address alice = makeAddr("alice");
        address bob = makeAddr("bob");

        console2.log("address this: ", thisAddress);
        console2.log("address alice:", alice);
        console2.log("address bob:", bob);

        FungibleToken token = new FungibleToken("TestToken", "TEST");
        token.mint(alice, 100);
        console2.log("alice balance:", token.balanceOf(alice));
    }
}
