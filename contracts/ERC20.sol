// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract BoredApe is ERC20 {
    constructor() ERC20("BoredApe", "BRT") {
        _mint(msg.sender, 20000 * 10 ** decimals());
    }
}