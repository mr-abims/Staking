import { ethers } from "hardhat";

async function main() {
  const Staking = await ethers.getContractFactory("Staking");
  const staking = await Staking.deploy("Boredape", "BRT");
  await staking.deployed();
  console.log("staking address", staking.address);
  const border = "0x2C804244D7CA969fA75c866891dAF6F3f1f8B174";

  const sign = await ethers.getSigner(border);
  const Stake = await staking.Stake(20);
  console.log(Stake);
  const withdraw = await staking.connect(sign).withdrawSTake(10);
  console.log(withdraw);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
