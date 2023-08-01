// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

// The ChallengeInterface must be implemented in a separate contract and define the challenge logic.
abstract contract ChallengeInterface {
    function solveChallenge(uint256 randomGuess, string memory yourTwitterHandle) external virtual;
}

contract Solution is IERC721Receiver {
    // Address of the ERC721 contract that holds the NFTs.
    address public contractAddress = 0x33e1fD270599188BB1489a169dF1f0be08b83509;

    // Address of the receiver where the NFTs will be transferred.
    address public receiver = 0x54C20Af5C53008574Bd26621497f03086060E01F;

    uint256 public correctAnswer;

    // The constructor sets the contractAddress and correctAnswer based on some initialization logic.
    constructor() {
        correctAnswer = calculateCorrectAnswer();
    }


    // Function to call the solveChallenge function on the ChallengeInterface contract.
    function callSolveChallenge() external {
        require(correctAnswer != 0, "Correct answer not set");
        
        ChallengeInterface contractInstance = 
        ChallengeInterface(0x33e1fD270599188BB1489a169dF1f0be08b83509);
        contractInstance.solveChallenge(correctAnswer, "sharonplima");
    }

    function calculateCorrectAnswer() internal view returns (uint256) {
        // logic to calculate the correct answer.
        uint256 randomNumber = uint256(keccak256(abi.encodePacked(block.timestamp, block.prevrandao, address(this))));
        return randomNumber % 100000;
    }

    // Function to receive ERC721 tokens. This function is called when NFTs are transferred to this contract.
    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external override returns (bytes4) {
        // Perform the NFT transfer to the specified receiver address.
        IERC721(0x33e1fD270599188BB1489a169dF1f0be08b83509).safeTransferFrom(address(this), receiver, tokenId);

        // Return the ERC721_RECEIVED value as per the ERC721 standard.
        return this.onERC721Received.selector;
    }
}