//SPDX-License-Identifier: MIT
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import {LessonNine} from "./Challenge/9-Lesson.sol";

pragma solidity ^0.8.18;

contract Solution is IERC721Receiver {
    // Address of the ERC721 contract that holds the NFTs.
    address public contractAddress = 0x33e1fD270599188BB1489a169dF1f0be08b83509;
    address owner;

    uint256 public correctAnswer;
    LessonNine public lessonNine;

    // The constructor sets the contractAddress and correctAnswer based on some initialization logic.
    constructor() {
        lessonNine = LessonNine(contractAddress);
        owner = msg.sender;
    }

    // Function to call the solveChallenge function on the ChallengeInterface contract.
    function callSolveChallenge() external {
        correctAnswer = uint256(keccak256(abi.encodePacked(address(this), block.prevrandao, block.timestamp))) % 100000;
        lessonNine.solveChallenge(correctAnswer, "sharonplima");
    }

    function onERC721Received(address operator, address from, uint256 tokenId, bytes calldata data)
        public override returns (bytes4) {
        return this.onERC721Received.selector;
    }

    function transferTime(address NFTcontract, uint256 tokenId)public {
        ERC721 target = ERC721(NFTcontract);
        target.transferFrom(address(this), owner, tokenId);
    }

}





