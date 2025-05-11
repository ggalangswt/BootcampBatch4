// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {MockUSDC} from "../src/MockUSDC.sol";
import {Vault} from "../src/Vault.sol";

contract VaultTest is Test {
    MockUSDC public usdc;
    Vault public vault;

    address public alice = makeAddr("Alice"); //Membuat akun alice
    address public bob = makeAddr("Bob"); //Membuat akun bob
    address public charlie = makeAddr("Charlie"); //Membuat akun charlie

    function setUp() public {
        usdc = new MockUSDC();
        vault = new Vault(address(usdc));
    }

    function test_Deposit() public {
        //alice deposit 1000 usdc
        vm.startPrank(alice); //prank sebagai alice
        usdc.mint(alice, 1000);
        usdc.approve(address(vault), 1000);
        vault.deposit(1000);
        //cek apakah alice memiliki 1000 shares
        assertEq(vault.balanceOf(alice), 1000);
        vm.stopPrank();

        //bob deposit 2000 usdc
        vm.startPrank(bob); //prank sebagai bob
        usdc.mint(bob, 2000);
        usdc.approve(address(vault), 2000);
        vault.deposit(2000);
        //cek apakah bob memiliki 2000 shares
        assertEq(vault.balanceOf(bob), 2000);
        vm.stopPrank();
    }

    function test_scenario() public {
        //alice deposit ijt
        //bob deposit 2jt
        //distributeYield 1jt
        //charlie deposit 1jt

        //persiapkan
        usdc.mint(alice, 1_000_000);
        usdc.mint(bob, 2_000_000);
        usdc.mint(charlie, 1_000_000);

        //alice deposit 1jt
        vm.startPrank(alice); //prank sebagai alice
        usdc.approve(address(vault), 1_000_000);
        vault.deposit(1_000_000);
        //cek apakah alice memiliki 1jt shares
        assertEq(vault.balanceOf(alice), 1_000_000);
        vm.stopPrank();

        //bob deposit 2jt
        vm.startPrank(bob); //prank sebagai bob
        usdc.approve(address(vault), 2_000_000);
        vault.deposit(2_000_000);
        //cek apakah bob memiliki 2jt shares
        assertEq(vault.balanceOf(bob), 2_000_000);
        vm.stopPrank();

        //distributeYield 1jt
        usdc.mint(address(this), 1_000_000);
        usdc.approve(address(vault), 1_000_000);
        vault.distributeYield(1_000_000);

        //charlie deposit 1jt
        vm.startPrank(charlie); //prank sebagai charlie
        usdc.approve(address(vault), 1_000_000);
        vault.deposit(1_000_000);
        //cek apakah charlie memiliki 750k shares
        assertEq(vault.balanceOf(charlie), 750_000);
        vm.stopPrank();

        //alice withdraw 1jt
        vm.startPrank(alice); //prank sebagai alice
        vault.withdraw(1_000_000);
        //cek apakah alice memiliki 1.333jt shares
        assertEq(usdc.balanceOf(alice), 1_333_333);
        vm.stopPrank();

        //bob withdraw 2jt
        vm.startPrank(bob); //prank sebagai bob
        vault.withdraw(2_000_000);
        //cek apakah bob memiliki 2.666jt shares
        assertEq(usdc.balanceOf(bob), 2_666_666);
        vm.stopPrank();
    }
}
