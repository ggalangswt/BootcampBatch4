// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Vault is ERC20 {       
    
    address public usdc;
    constructor(address _usdc) ERC20("Vault", "VAULT") {         //inisiasi nama token
        usdc = _usdc;
    }

    function deposit(uint256 amount) public {
        //shares = deposit ammount  / total assets * total shares
        uint256 totalAssets = IERC20(usdc).balanceOf(address(this));
        uint256 totalShares = totalSupply();

        uint256 shares = 0;
        if (totalShares == 0) {
            shares = amount;
        } else {
            shares = (amount * totalShares) / totalAssets;
        }

        // mint shares to msg.sender
        _mint(msg.sender, shares);

        // transfer usdc from msg.sender to vault
        // USDC dari msg.sender diambil dikirim ke dalam vault
        IERC20(usdc).transferFrom(msg.sender, address(this), amount);
    }

    function withdraw(uint256 shares) public {
        // ammount = shares * total assets / total shares
        uint256 totalAssets = IERC20(usdc).balanceOf(address(this));
        uint256 totalShares = totalSupply();

        uint256 amount = (shares * totalAssets) / totalShares;

        _burn(msg.sender, shares); //fungsi burn untuk menghapus token dari msg.sender

        //transfer usdc from vault to msg.sender
        IERC20(usdc).transfer(msg.sender, amount);
    }

    function distributeYield(uint256 amount) public {
        // transfer usdc from msg.sender to vault
        IERC20(usdc).transferFrom(msg.sender, address(this), amount);
    }
}