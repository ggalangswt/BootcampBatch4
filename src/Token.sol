// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is
    ERC20 //is ERC20 untuk mengimport ERC20 dari
{
    constructor() ERC20("SAPTONO", "SPT") { //inisiasi nama token
    }

    function mint(address to, uint256 amount) public {
        //fungsi mint untuk mencetak token
        _mint(to, amount);
    }
}
