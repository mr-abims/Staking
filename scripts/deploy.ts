import { ethers } from "hardhat";
import { Signer } from "ethers";

async function main() {
  const owner = "0x6315AE672539D1d843F0581a11102a77A948f671";
  const ownerSigner = await ethers.getSigner(owner);
  // @ts-ignore
  await hre.network.provider.request({
    method: "hardhat_impersonateAccount",
    params: [owner],
  });
  // @ts-ignore
  await hre.network.provider.send("hardhat_setBalance", [
    owner,
    "0x2000000000000000000000000000000",
  ]);

  const Staking = await ethers.getContractFactory("Staking");
  const staking = await Staking.connect(ownerSigner).deploy("Boredape", "BRT");
  await staking.deployed();
  const balance = await ethers.getContractAt("IERC20", staking.address);
  const bal = await balance.balanceOf(owner);
  console.log(bal);
  const border = "0x2C804244D7CA969fA75c866891dAF6F3f1f8B174";

  await balance.connect(ownerSigner).transfer(border, 20);
  const balanceOfBorder = await balance.balanceOf(border);
  console.log(balanceOfBorder);

  console.log("staking address", staking.address);
  // @ts-ignore
  await hre.network.provider.request({
    method: "hardhat_impersonateAccount",
    params: [border],
  });
  // @ts-ignore
  await hre.network.provider.send("hardhat_setBalance", [
    border,
    "0x2000000000000000000000000000000",
  ]);

  const sign: Signer = await ethers.getSigner(border);
  const Stake = await staking.connect(sign).Stake(10);
  console.log(Stake);
  const withdraw = await staking.connect(sign).withdrawSTake(2);
  console.log(withdraw);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
