var DataExchange = artifacts.require("DataExchange");

var ether = 1000000000000000000;

contract("DataExchange", async accounts => {
  let instance;

  it("deploy contract", async () => {
    instance = await DataExchange.deployed();
  });

  it("deposit()", async () => {
    for (let i = 0; i < 5; i++) {
      await instance.deposit(accounts[i + 5], 0, {
        from: accounts[i],
        value: 500 * ether
      });
    }
  });

  it("getContractBalance()", async () => {
    let balance = await instance.getContractBalance.call();
    console.log("[contract balance]", balance.toNumber());
  });

  it("receive()", async () => {
    for (let i = 5; i < 10; i++) {
      await instance.deposit(accounts[i - 5], 0, {
        from: accounts[i]
      });
    }
  });

  it("getContractBalance()", async () => {
    let balance = await instance.getContractBalance.call();
    console.log("[contract balance]", balance.toNumber());
  });
});
