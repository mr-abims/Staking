/* eslint-disable prettier/prettier */
// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
import { ethers } from "hardhat";

async function main() {
  const ownerAdress = "0x6315AE672539D1d843F0581a11102a77A948f671";
  const ownerSigner = await ethers.getSigner(ownerAdress);
  // @ts-ignore
  await hre.network.provider.request({
    method: "hardhat_impersonateAccount",
    params: [ownerAdress],
  });
  // @ts-ignore
  await network.provider.send("hardhat_setBalance", [
    ownerAdress,
    "0x20000000000000000000000",
  ]);

  const TokenContract = await ethers.getContractFactory("BoredApe");
  const tokencontract = await TokenContract.connect(ownerSigner).deploy(
    "BoredApe",
    "BRT"
  );
  await tokencontract.deployed();
  console.log("token address", tokencontract.address);

  const balance = await tokencontract.balanceOf(ownerAdress);
  console.log(`owner balance is ${balance}`);
}
// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
