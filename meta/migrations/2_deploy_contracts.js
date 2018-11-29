var ConvertLib = artifacts.require("./ConvertLib.sol");
var MetaCoin = artifacts.require("./MetaCoin.sol");

module.exports = function(deployer) {
  
  console.log('CC')
  deployer.deploy(ConvertLib);
  
  console.log('DD')
  deployer.link(ConvertLib, MetaCoin);
  console.log('EE')
  deployer.deploy(MetaCoin);
  
  console.log('FF')
};
