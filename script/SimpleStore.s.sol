// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Script.sol";

interface SimpleStore {
    function setValue(uint256) external;

    function getValue() external returns (uint256);
}

contract DeploySimpleStore is Script {
    function run() public returns (SimpleStore simpleStore) {
        vm.startBroadcast();
        simpleStore = SimpleStore(HuffDeployer.deploy("SimpleStore"));
        vm.stopBroadcast();
    }
}
