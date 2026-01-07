// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Script.sol";

interface VRFConsumer {
    function requestRandom() external returns (uint256);

    function rawFulfillRandomWords(
        uint256 reqId,
        uint256[] calldata words
    ) external;

    function getLastRequestId() external view returns (bytes32);

    function getRandomNumber(bytes32) external view returns (uint256);
}

contract DeployVRFConsumer is Script {
    function run() public returns (VRFConsumer consumer) {
        vm.startBroadcast();
        consumer = VRFConsumer(HuffDeployer.deploy("VRFConsumer"));
        vm.stopBroadcast();
    }
}
