// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./SSQSwapPair.sol";
import "./SSQSwapFactory.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SSQSwapRouter {
    SSQSwapFactory public factory;

    constructor(address _factory) {
        factory = SSQSwapFactory(_factory);
    }

    function createPair(address token0, address token1, uint256 token0Amount, uint256 token1Amount) public returns (address) {
        SSQSwapPair pair = SSQSwapPair(factory.createPair(token0, token1));

        address account = msg.sender;
        ERC20(token0).transferFrom(account, address(pair), token0Amount);
        ERC20(token1).transferFrom(account, address(pair), token1Amount);
        factory.initializePair(address(pair), account);

        return address(pair);
    }
}