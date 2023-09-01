// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract ERC721Market is ERC721 {

    struct nftSubasta {
        uint256 tokenId;
        string name;
        string description;
        address creator;
    }

    nftSubasta[] public tokens;
    uint256 public tokenCount;

    constructor() ERC721("MiERC721", "MINFT") {
        tokenCount = 0;
    }

    mapping(uint256 => address) public nftCreators; // Mapeo de tokenId a creador

    // Para registrar al creador
    function createToken(string memory _name, string memory _description) external {
        tokenCount++;
        nftSubasta memory newToken = nftSubasta(tokenCount, _name, _description, msg.sender);
        tokens.push(newToken);
        _mint(msg.sender, tokenCount);

        // Registra al creador del NFT
        nftCreators[tokenCount] = msg.sender;
    }

    // Función para obtener el creador de un NFT por su tokenId
    function getNftCreator(uint256 _tokenId) external view returns (address) {
        return nftCreators[_tokenId];
    }

    function getTokenCount() external view returns (uint256) {
        return tokenCount;
    }

    function approveTransfer(address _to, uint256 _tokenId) external {
        require(_tokenId > 0 && _tokenId <= tokenCount, "TokenId invalido");
        // require(msg.sender == creator), "No autorizado");
        approve(_to, _tokenId);
    }

    function transferir(address _from, address _destinatario, uint256 _tokenId) external {
        require(_tokenId > 0 && _tokenId <= tokenCount, "TokenId invalido");
        safeTransferFrom(_from, _destinatario, _tokenId);
    }

    function getTokenById(uint256 _tokenId) external view returns (uint256 , string memory, string memory, address ) {
        require(_tokenId > 0 && _tokenId <= tokenCount, "TokenId invalido");
        nftSubasta storage token = tokens[_tokenId - 1];
        return (token.tokenId, token.name, token.description, token.creator);
    }
}
