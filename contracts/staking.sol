// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
contract Staking {
address BoredApe = 0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D;
IERC721 boredApe = IERC721(BoredApe);
struct stakeProfile{
    address staker;
    uint stakeStart;
    uint amountStaked;
}
mapping (address => stakeProfile)public Stakers;
// mapping (address => uint) stakedBalances;
function Stake(uint _amount) public {
    require(boredApe.balanceOf(msg.sender) >= 1, "Not a boredApe owner");
    Stakers[msg.sender].staker = msg.sender;
    Stakers[msg.sender].stakeStart = block.timestamp;
    Stakers[msg.sender].amountStaked += _amount;
}
// function withdrawSTake()  returns () external {
//     require((block.timestamp - Stakers[msg.sender].stakeStart) < 3 days, "Cannot withdraw now");

    
}
    

}