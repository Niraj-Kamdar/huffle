// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

interface Raffle {
    function getEntranceFee() external view returns (uint256);
}


contract RaffleTest is Test {
    Raffle public raffle;
    uint256 raffleEntranceFee;

    /// @dev Setup the testing environment.
    function setUp() public {
        raffle = Raffle(HuffDeployer.deploy_with_args("Raffle", abi.encode(raffleEntranceFee)));
    }

    function testGetEntranceFee() public {
        uint256 actualEntranceFee = raffle.getEntranceFee();
        assertEq(actualEntranceFee, raffleEntranceFee, "Entrance fee is not same as the one we set");
    }
}
