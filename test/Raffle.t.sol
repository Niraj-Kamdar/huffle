// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

interface Raffle {
    function getEntranceFee() external view returns (uint256);
    function enterRaffle() external payable;
    function getPlayer(uint256) external view returns (address);
    function getInterval() external view returns (uint256);
}

contract RaffleTest is Test {
    /// @dev Address of the SimpleStore contract.
    event RaffleEnter(address indexed player);

    Raffle public raffle;
    uint256 public constant raffleEntranceFee = 1 ether;
    uint256 public constant interval = 30;

    address public PLAYER = makeAddr("player");
    uint256 public constant STARTING_USER_BALANCE = 10 ether;

    /// @dev Setup the testing environment.
    function setUp() public {
        raffle = Raffle(
            HuffDeployer
                .config()
                .with_args(bytes.concat(abi.encode(raffleEntranceFee, interval)))
                .deploy("Raffle")
        );
        vm.deal(PLAYER, STARTING_USER_BALANCE);
    }

    function testInterval() public {
        uint256 actualInterval = raffle.getInterval();
        assertEq(
            actualInterval,
            interval,
            "Entrance fee is not same as the one we set"
        );
    }

    function testGetEntranceFee() public {
        uint256 actualEntranceFee = raffle.getEntranceFee();
        assertEq(actualEntranceFee, raffleEntranceFee, "Entrance fee is not same as the one we set");
    }

    function testRaffleRecordsPlayerWhenTheyEnter() public {
        // Arrange
        vm.prank(PLAYER);
        // Act
        raffle.enterRaffle{value: raffleEntranceFee}();
        // Assert
        address playerRecorded = raffle.getPlayer(0);
        assert(playerRecorded == PLAYER);
    }
}
