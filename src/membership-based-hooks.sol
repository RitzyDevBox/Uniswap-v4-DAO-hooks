// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import { IHooks } from '@v4-core/interfaces/IHooks.sol';
import {IPoolManager} from "@v4-core/interfaces/IPoolManager.sol";
import {PoolKey} from "@v4-core/types/PoolKey.sol";
import {BalanceDelta} from "@v4-core/types/BalanceDelta.sol";



contract GatedHooks is IHooks {

    IERC721 internal membershipNFT;

    modifier onlyMembersWithThreshold(uint256 threshold) {
        require(
            membershipNFT.balanceOf(msg.sender) > threshold,
            "This action requires members who match or exceed balance threshold"
        );
        _;
    }

    constructor(IERC721 _membershiptNFT) {
        membershipNFT = _membershiptNFT;
    }
    
    function beforeInitialize(address, PoolKey memory, uint160) external view override onlyMembersWithThreshold(5) returns (bytes4) {
        return IHooks.beforeInitialize.selector;
    }

    function afterInitialize(address, PoolKey memory, uint160, int24) external pure override returns (bytes4) {
        return IHooks.afterInitialize.selector;
    }

    function beforeModifyPosition(address, PoolKey calldata, IPoolManager.ModifyPositionParams calldata)
        external
        view
        override
        onlyMembersWithThreshold(2)
        returns (bytes4)
    {
        return IHooks.beforeModifyPosition.selector;
    }

    function afterModifyPosition(address, PoolKey calldata, IPoolManager.ModifyPositionParams calldata, BalanceDelta)
        external
        pure
        override
        returns (bytes4)
    {
        return IHooks.afterModifyPosition.selector;
    }

    function beforeSwap(address, PoolKey calldata, IPoolManager.SwapParams calldata)
        external
        view
        override
        onlyMembersWithThreshold(1)
        returns (bytes4)
    {
        return IHooks.beforeSwap.selector;
    }

    function afterSwap(address, PoolKey calldata, IPoolManager.SwapParams calldata, BalanceDelta)
        external
        pure
        override
        returns (bytes4)
    {
        return IHooks.afterSwap.selector;
    }

    function beforeDonate(address, PoolKey calldata, uint256, uint256) external view override onlyMembersWithThreshold(1) returns (bytes4) {
        return IHooks.beforeDonate.selector;
    }

    function afterDonate(address, PoolKey calldata, uint256, uint256) external pure override returns (bytes4) {
        return IHooks.afterDonate.selector;
    }

    
}

