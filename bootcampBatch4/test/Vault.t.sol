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

          //charlie deposit 3000 usdc
          vm.startPrank(charlie); //prank sebagai charlie
          usdc.mint(charlie, 3000);
          usdc.approve(address(vault), 3000);
          vault.deposit(3000);
          //cek apakah charlie memiliki 3000 shares
          assertEq(vault.balanceOf(charlie), 3000);
          vm.stopPrank();
     }
}
