var Migrations = artifacts.require("./Migrations.sol");

module.exports = function(deployer) {
  console.log('AA')
  deployer.deploy(Migrations);
  console.log('BB')
};
