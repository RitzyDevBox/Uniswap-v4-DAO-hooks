// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { Test, console2 } from "forge-std/Test.sol";
import { GatedHooks } from "../src/membership-based-hooks.sol";
import { Membership } from "../src/mocks/membership.sol";

contract GatedHooksTest is Test {
    GatedHooks public gatedHooks;
    Membership public membership;

    function setUp() public {
        membership = new Membership(); 
        gatedHooks = new GatedHooks(membership);
    }

    function testIncrement() public {
        // counter.increment();
        // assertEq(counter.number(), 1);
    }

    function testSetNumber(uint256 x) public {
        // counter.setNumber(x);
        // assertEq(counter.number(), x);
    }
}
