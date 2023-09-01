// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./ERC721Market.sol"; 

contract EnglishAuctionNFT is Ownable {
    ERC20 public token;  // El contrato utiliza tokens ERC20 para las ofertas.
    ERC721Market public nftContract; // Referencia al contrato ERC721Market

    constructor(address _tokenAddress, address _nftContractAddress) {
        token = ERC20(_tokenAddress);
        nftContract = ERC721Market(_nftContractAddress); // Asigna la dirección del contrato ERC721Market
    }

    struct Auction {
        address creadorNFT;
        uint256 tokenId;
        uint256 startTime;
        uint256 endTime;
        address highestBidder;
        uint256 highestBid;
        bool finalizada;
        mapping(address => uint256) ofertas;
    }

    mapping(bytes32 => Auction) public subastas;
    mapping(bytes32 => uint256) public auctionIndex;


    bytes32[] public subastasActivas;
    bytes32[] public subastasPasadas;

    event SubastaCreada(bytes32 indexed _idSubasta, address indexed _creador);
    event OfertaRealizada(bytes32 indexed _idSubasta, address indexed _postor, uint256 _oferta);
    event SubastaFinalizada(bytes32 indexed _idSubasta, address indexed _ganador, uint256 _oferta);

    function crearSubasta(uint256 _idToken, uint256 _horaInicio, uint256 _horaFin) external {
        require(_horaFin > _horaInicio, "Parametros de tiempo invalidos");

        // Obtiene el creador del NFT
        address creadorNFT = nftContract.getNftCreator(_idToken);

        // Verifica que el creador del NFT sea el que crea la subasta
        require(msg.sender == creadorNFT, "Solo el creador del NFT puede crear subastas");

        bytes32 idSubasta = _crearIdSubasta(_idToken, _horaInicio, _horaFin);
        Auction storage subasta = subastas[idSubasta];
        subasta.creadorNFT = msg.sender;
        subasta.tokenId = _idToken;
        subasta.startTime = _horaInicio;
        subasta.endTime = _horaFin;
        subastasActivas.push(idSubasta);
        emit SubastaCreada(idSubasta, msg.sender);
    }

    function realizarOferta(bytes32 _idSubasta, uint256 _montoOferta) external {
        Auction storage subasta = subastas[_idSubasta];
        require(!subasta.finalizada, "Subasta ya finalizada");
        require(block.timestamp >= subasta.startTime && block.timestamp <= subasta.endTime, "Subasta no activa");
        require(_montoOferta > subasta.highestBid, "La oferta debe ser mayor que la oferta actual mas alta");
        require(token.transferFrom(msg.sender, address(this), _montoOferta), "Fallo al transferir tokens");
        
        if (subasta.highestBidder != address(0)) {
            token.transfer(subasta.highestBidder, subasta.highestBid);
        }

        subasta.highestBidder = msg.sender;
        subasta.highestBid = _montoOferta;
        subasta.ofertas[msg.sender] = _montoOferta;

        emit OfertaRealizada(_idSubasta, msg.sender, _montoOferta);
    }

    function eliminarSubasta(bytes32 _idSubasta) internal {
        uint256 indiceEliminar = auctionIndex[_idSubasta];
        require(indiceEliminar < subastasActivas.length, "Subasta no encontrada en subastas activas");

        if (indiceEliminar < subastasActivas.length - 1) {
            // Reorganiza el arreglo para eliminar el elemento
            subastasActivas[indiceEliminar] = subastasActivas[subastasActivas.length - 1];
            // Actualiza la posición en el mapeo para el elemento movido
            auctionIndex[subastasActivas[indiceEliminar]] = indiceEliminar;
        }

        // Elimina la referencia en el mapeo
        delete auctionIndex[_idSubasta];
    }

    function finalizarSubasta(bytes32 _idSubasta) external onlyOwner {
        Auction storage subasta = subastas[_idSubasta];
        require(!subasta.finalizada, "Subasta ya finalizada");
        require(block.timestamp > subasta.endTime, "Subasta aun no finalizada");

        subasta.finalizada = true; // Marca la subasta como finalizada en lugar de eliminarla

        subastasPasadas.push(_idSubasta);

        if (subasta.highestBidder != address(0)) {
            token.transfer(subasta.creadorNFT, subasta.highestBid);
            emit SubastaFinalizada(_idSubasta, subasta.highestBidder, subasta.highestBid);
        }
    }

    function retirarOferta(bytes32 _idSubasta) external {
        Auction storage subasta = subastas[_idSubasta];
        require(!subasta.finalizada, "Subasta ya finalizada");
        require(subasta.ofertas[msg.sender] > 0, "No hay oferta para retirar");
        require(subasta.startTime > block.timestamp, "No se puede retirar despues de que inicie la subasta");
        
        uint256 cantidad = subasta.ofertas[msg.sender];
        subasta.ofertas[msg.sender] = 0;
        require(token.transfer(msg.sender, cantidad), "Fallo al transferir tokens");

        emit OfertaRealizada(_idSubasta, msg.sender, 0); // Emite una oferta con monto 0 para señalar la retirada de la oferta
    }

    function obtenerSubastasActivas() external view returns (bytes32[] memory) {
        return subastasActivas;
    }

    function obtenerSubastasPasadas() external view returns (bytes32[] memory) {
        return subastasPasadas;
    }

    function _crearIdSubasta(
        uint256 _idToken,
        uint256 _horaInicio,
        uint256 _horaFin
    ) internal view returns (bytes32) {
        return keccak256(abi.encodePacked(_idToken, _horaInicio, _horaFin, block.timestamp));
    }
}
