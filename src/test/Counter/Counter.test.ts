import { expect } from "chai";
import hre from "hardhat";

describe("Counter", () => {
  it("should work", async () => {
    const Counter = await hre.viem.deployContract("Counter");
    await Counter.write.setNumber([0n]);
    expect(await Counter.read.number()).to.equal(0);

    await Counter.write.increment();
    expect(await Counter.read.number()).to.equal(1);
  });
});
