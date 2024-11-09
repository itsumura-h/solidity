import { expect } from "chai";
import hre from "hardhat";

async function deployFungibleToken() {
  const FungibleToken = await hre.viem.deployContract("FungibleToken", [
    "TestToken",
    "TEST",
  ]);
  return FungibleToken;
}

describe("FungibleToken", () => {
  it("getters", async () => {
    const FungibleToken = await deployFungibleToken();
    expect(await FungibleToken.read.name()).to.equal("TestToken");
    expect(await FungibleToken.read.symbol()).to.equal("TEST");
    expect(await FungibleToken.read.decimals()).to.equal(18);
  });

  it("mint, burn", async () => {
    const [alice] = await hre.viem.getWalletClients();

    const FungibleToken = await deployFungibleToken();

    await FungibleToken.write.mint([alice.account.address, 100n]);
    expect(await FungibleToken.read.totalSupply()).to.equal(100n);
    expect(
      await FungibleToken.read.balanceOf([alice.account.address]),
    ).to.equal(100n);

    await FungibleToken.write.burn([alice.account.address, 50n]);
    expect(await FungibleToken.read.totalSupply()).to.equal(50n);
    expect(
      await FungibleToken.read.balanceOf([alice.account.address]),
    ).to.equal(50n);
  });

  it("transfer", async () => {
    const [alice, bob] = await hre.viem.getWalletClients();

    const FungibleToken = await deployFungibleToken();

    await FungibleToken.write.mint([alice.account.address, 100n]);
    expect(
      await FungibleToken.read.balanceOf([alice.account.address]),
    ).to.equal(100n);
    expect(await FungibleToken.read.balanceOf([bob.account.address])).to.equal(
      0n,
    );

    await FungibleToken.write.transfer([bob.account.address, 100n]);
    expect(
      await FungibleToken.read.balanceOf([alice.account.address]),
    ).to.equal(0n);
    expect(await FungibleToken.read.balanceOf([bob.account.address])).to.equal(
      100n,
    );
  });

  it("transferFrom", async () => {
    const [alice, bob] = await hre.viem.getWalletClients();

    const FungibleToken = await deployFungibleToken();

    await FungibleToken.write.mint([alice.account.address, 100n]);
    expect(
      await FungibleToken.read.balanceOf([alice.account.address]),
    ).to.equal(100n);
    expect(await FungibleToken.read.balanceOf([bob.account.address])).to.equal(
      0n,
    );

    await FungibleToken.write.approve([bob.account.address, 100n], {
      account: alice.account,
    });

    expect(
      await FungibleToken.read.allowance([
        alice.account.address,
        bob.account.address,
      ]),
    ).to.equal(100n);

    await FungibleToken.write.transferFrom(
      [alice.account.address, bob.account.address, 100n],
      {
        account: bob.account,
      },
    );

    expect(
      await FungibleToken.read.balanceOf([alice.account.address]),
    ).to.equal(0n);
    expect(await FungibleToken.read.balanceOf([bob.account.address])).to.equal(
      100n,
    );
  });
});
