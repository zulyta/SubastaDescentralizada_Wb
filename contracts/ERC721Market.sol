// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MiContratoERC721 is ERC721, Ownable {
    constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol) {}

    function mint(address _to, uint256 _tokenId) external onlyOwner {
        _safeMint(_to, _tokenId);
    }

    function approveTransfer(address _to, uint256 _tokenId) external onlyOwner {
        approve(_to, _tokenId);
    }

    function transferir(address _destinatario, uint256 _tokenId) external {
        safeTransferFrom(msg.sender, _destinatario, _tokenId);
    }
}