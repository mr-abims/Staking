// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./Iape.sol";
contract Staking is ERC20 {


uint rewardPerStake;
address BoredApe = 0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D;
IAPE private ape = IAPE(BoredApe);
struct stakeProfile{
    address staker;
    uint stakeStart;
    uint amountStaked;
    bool status;
}
mapping (address => stakeProfile)public Stakers;
// mapping (address => uint) stakedBalances;
 constructor(string memory _name, string memory _symbol) ERC20(_name, _symbol) {
        _mint(msg.sender, 200000 * 10 ** 18 );
    }


function Stake(uint _amount) public  {
    stakeProfile storage Sp = Stakers[msg.sender];
    require(_balances[msg.sender] >=  _amount, "insufficient amount");
    require(ape.balanceOf(msg.sender) >= 1, "Not a boredApe owner");
    if(Sp.status = true){
        uint256 daySpent = block.timestamp - Sp.stakeStart;
        if(daySpent > 3 days){
            uint256 interests = Sp.amountStaked * (daySpent/ 86400) / 300;
            Sp.amountStaked += interests + _amount;
       
        }
            else{ Sp.amountStaked += _amount;
            }
    }
    else {
    Sp.staker = msg.sender;
    Sp.amountStaked += _amount;
    Sp.status = true;

}

transfer(address(this), _amount);
Sp.stakeStart = block.timestamp;
}



function withdrawSTake(uint256 _amountToWithdraw) public returns(uint256 total) {
    stakeProfile storage Sp = Stakers[msg.sender];
    require(Sp.status == true, "You are not allowed to use this function");
   
   uint256 daySpent = block.timestamp - Sp.stakeStart;
   if(daySpent > 3 seconds){
       uint256 interests = Sp.amountStaked * (daySpent/ 86400) / 300;
       Sp.amountStaked += interests;
       Sp.amountStaked = total;   
   }
   require(Sp.amountStaked >_amountToWithdraw, "Insufficient funds");

    Sp.amountStaked -= _amountToWithdraw;
    _balances[address(this)] -= _amountToWithdraw;
    _balances[msg.sender] += _amountToWithdraw;
     Sp.stakeStart = block.timestamp;
     Sp.amountStaked == 0 ? false: true;
     

}

}
    

