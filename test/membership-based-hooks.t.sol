// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { Test, console2 } from "forge-std/Test.sol";
import { GatedHooks } from "../src/membership-based-hooks.sol";
import { Membership } from "../src/mocks/membership.sol";
import { PoolKey } from "@v4-core/types/PoolKey.sol";
import { BalanceDelta } from "@v4-core/types/BalanceDelta.sol";
import { IPoolManager } from "@v4-core/interfaces/IPoolManager.sol";
import { IHooks } from '@v4-core/interfaces/IHooks.sol';

contract GatedHooksTest is Test {
    GatedHooks public gatedHooks;
    Membership public membership;

    function setUp() public {
        membership = new Membership(); 
        gatedHooks = new GatedHooks(membership);
    }

    // limit the fuzzing to uint8 since minting will take time
    function testMint(uint8 mintAmountFuzz) public {
        address mockUser = address(99999);
        assertEq(membership.balanceOf(mockUser), 0);
        if(mintAmountFuzz == 0) return;

        membership.safeMint(mockUser, mintAmountFuzz);
        assertEq(membership.balanceOf(mockUser), mintAmountFuzz);
    }

    function testBeforeSwapIsGated() public {
        
        uint256 threshold = gatedHooks.SWAP_THRESHOLD();
        address testAccount = address(1001);

        vm.startPrank(testAccount);
        assertEq(membership.balanceOf(testAccount), 0);
                
        PoolKey memory poolKey;
        IPoolManager.SwapParams memory swapParams;

        vm.expectRevert("This action requires members who match or exceed balance threshold");
        gatedHooks.beforeSwap(testAccount, poolKey, swapParams);
        vm.stopPrank();

        membership.safeMint(testAccount, threshold);

        vm.startPrank(testAccount);
        assertEq(membership.balanceOf(testAccount), threshold);
        
        bytes4 selectorResult = gatedHooks.beforeSwap(testAccount, poolKey, swapParams);
        assertEq(selectorResult, IHooks.beforeSwap.selector);

        vm.stopPrank();
    }

    function testBeforeDonateIsGated() public {
        
        uint256 threshold = gatedHooks.DONATE_THRESHOLD();
        address testAccount = address(1001);

        vm.startPrank(testAccount);
        assertEq(membership.balanceOf(testAccount), 0);
                
        PoolKey memory poolKey;
        uint256 amount0;
        uint256 amount1;

        vm.expectRevert("This action requires members who match or exceed balance threshold");
        gatedHooks.beforeDonate(testAccount, poolKey, amount0, amount1);
        vm.stopPrank();

        membership.safeMint(testAccount, threshold);

        vm.startPrank(testAccount);
        assertEq(membership.balanceOf(testAccount), threshold);
        
        bytes4 selectorResult = gatedHooks.beforeDonate(testAccount, poolKey, amount0, amount1);
        assertEq(selectorResult, IHooks.beforeDonate.selector);

        vm.stopPrank();
    }

    function testBeforeModifyPositionIsGated() public {
        
        uint256 threshold = gatedHooks.MODIFY_POSITION_THRESHOLD();
        address testAccount = address(1001);

        vm.startPrank(testAccount);
        assertEq(membership.balanceOf(testAccount), 0);
                
        PoolKey memory poolKey;
        IPoolManager.ModifyPositionParams memory params;

        vm.expectRevert("This action requires members who match or exceed balance threshold");
        gatedHooks.beforeModifyPosition(testAccount, poolKey, params);
        vm.stopPrank();

        membership.safeMint(testAccount, threshold);

        vm.startPrank(testAccount);
        assertEq(membership.balanceOf(testAccount), threshold);
        
        bytes4 selectorResult = gatedHooks.beforeModifyPosition(testAccount, poolKey, params);
        assertEq(selectorResult, IHooks.beforeModifyPosition.selector);

        vm.stopPrank();
    }

    function testBeforeInitializeIsGated() public {
        
        uint256 threshold = gatedHooks.INITIALIZE_THRESHOLD();
        address testAccount = address(1001);

        vm.startPrank(testAccount);
        assertEq(membership.balanceOf(testAccount), 0);
                
        PoolKey memory poolKey;
        uint160 sqrtPriceX96;

        vm.expectRevert("This action requires members who match or exceed balance threshold");
        gatedHooks.beforeInitialize(testAccount, poolKey, sqrtPriceX96);
        vm.stopPrank();

        membership.safeMint(testAccount, threshold);

        vm.startPrank(testAccount);
        assertEq(membership.balanceOf(testAccount), threshold);
        
        bytes4 selectorResult = gatedHooks.beforeInitialize(testAccount, poolKey, sqrtPriceX96);
        assertEq(selectorResult, IHooks.beforeInitialize.selector);

        vm.stopPrank();
    }
}
