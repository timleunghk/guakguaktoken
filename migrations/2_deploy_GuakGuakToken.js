const GuakGuakToken = artifacts.require("GuakGuakToken");
 
module.exports = function(deployer) {
    deployer.deploy(GuakGuakToken);
 };