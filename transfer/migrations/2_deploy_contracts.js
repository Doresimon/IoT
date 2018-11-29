var Trans = artifacts.require("./Trans.sol");
// var Ownable = artifacts.require("./openzeppelin-solidity/contracts/ownership/Ownable.sol");

module.exports = function(deployer) {
    console.log('[deployer.deploy(Trans)]')
    deployer.deploy(Trans);
};