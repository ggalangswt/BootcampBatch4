// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Reksadana} from "../src/Reksadana.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ReksadanaTest is Test {
    Reksadana public reksadana;

    address weth = 0x82aF49447D8a07e3bd95BD0d56f35241523fBab1;
    address usdc = 0xaf88d065e77c8cC2239327C5EDb3A432268e5831;
    address wbtc = 0x2f2a2543B76A4166549F7aaB2e75Bef0aefC5B0f;

    function setUp() public {
        vm.createSelectFork("https://arb-mainnet.g.alchemy.com/v2/LgZ4I2PxxWqtqLJapEseKb5nK-dIQTCw", 335094777);
        reksadana = new Reksadana();
    }

    function test_totalAsset() public {
        deal(wbtc, address(reksadana), 1e8); // 1 WBTC ke dalam Reksadana
        deal(weth, address(reksadana), 10e18); // 10 WETH ke dalam Reksadana
        
        console.log("Total Asset: ", reksadana.totalAsset());
    }


}