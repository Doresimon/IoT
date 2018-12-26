// import Axios from "axios";

{
  /* 
      <script
      src="https://cdn.jsdelivr.net/gh/ethereum/web3.js@1.0.0-beta.36/dist/web3.min.js"
      integrity="sha256-nWBTbvxhJgjslRyuAKJHK+XcZPlCnmIAAMixz6EefVk="
      crossorigin="anonymous"
      ></script> 
  */
}

var ourNode = "http://localhost:7545";
// var web3 = new Web3(Web3.givenProvider || ourNode);
// var web3 = new Web3(Web3.givenProvide);  // metamask
var web3 = new Web3(ourNode); // just read infomation

var accounts = [];
var contract = {};

async function getSmartContract() {
  axios
    .post("/resource/contract", {})
    .then(async function(response) {
      console.log(response);
      contract = response.data;
      await callSmartContract(contract);
    })
    .catch(function(error) {
      console.log(error);
    });
}

async function getAccounts() {
  accounts = await web3.eth.getAccounts();
  console.log(accounts);
}

async function sendTX() {
  let recipt = await web3.eth.sendTransaction({
    from: accounts[0],
    to: "0x79Dc85660eC520C21557911f5544E0cBda05E8B5",
    value: "1000000000000000"
  });
  console.log(recipt);

  /* @ successful return
    {
      blockHash: "0x5800e6a31d7f0c849d0356af8f4530028195e60fefaa58085e01f5379f01ac8e"
      blockNumber: 3
      contractAddress: null
      cumulativeGasUsed: 21000
      gasUsed: 21000
      logs: []
      logsBloom: "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
      status: true
      transactionHash: "0x5d423ef6ac0ba24e3f6fd06ef5d15afb3f8aabc84b3f0e976eab6431a0b9d246"
      transactionIndex: 0
    }
  */
}

async function callSmartContract(contract_json) {
  //   let jsonInterface = [{}]; // 合约编译后的json文件读取出来
  let contractAddress = "0xaea53d42b93103803dd7f21d41ec0643f36a5728";
  let myContract = new web3.eth.Contract(contract_json.abi, contractAddress, {
    from: "0x70c470B72DC4bDD629615afAB230E9C75FC7237f", // default from address
    gasPrice: "20000000000" // default gas price in wei, 20 gwei in this case
  });
  //invoke function
  myContract.methods
    .registerIoT("0x1A15041cEAc3aE3912613A9bdAe14D73aB0b05e0")
    .send({ from: "0x70c470B72DC4bDD629615afAB230E9C75FC7237f" })
    .then(console.log);

  //call(read) function
  //   myContract.methods
  //     .myMethod(123)
  //     .call({ from: "0x70c470B72DC4bDD629615afAB230E9C75FC7237f" });
}

async function main() {
  await getAccounts();
  await sendTX();
  await getSmartContract();
}

main();
