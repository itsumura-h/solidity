import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@nomicfoundation/hardhat-foundry";
import "@nomicfoundation/hardhat-viem";

const config: HardhatUserConfig = {
  solidity: "0.8.24",
};

export default config;
