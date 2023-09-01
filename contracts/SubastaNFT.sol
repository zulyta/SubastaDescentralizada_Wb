// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./ERC721Market.sol";

contract MiContratoERC20 is ERC20 {
    ERC721Market private nftContract;
    address private ownerMarketplace;

    constructor(address _nftContractAddress, address _ownerMarketplace) ERC20("SubastaNFT", "SNFT") {
        nftContract = ERC721Market(_nftContractAddress);
        ownerMarketplace = _ownerMarketplace;
    }

    struct Subasta {
        address creadorNFT;
        uint256 tokenId;
        uint256 precioInicial;
        uint256 horaInicio;
        uint256 horaFin;
        uint256 ofertaMasAlta;
        address ganador;
    }

    Subasta[] public subastas;

    function iniciarSubasta(
        uint256 _tokenId,
        uint256 _precioInicial,
        uint256 _horaInicio,
        uint256 _horaFin
    ) external {
        require(_precioInicial > 0, "El precio inicial debe ser mayor a 0");
        require(_horaInicio < _horaFin, "La hora de inicio debe ser antes de la hora de finalizacion");

        address creadorNFT = nftContract.getNftCreator(_tokenId); // Obtener el creador del NFT
        

        Subasta memory nuevaSubasta;
        nuevaSubasta.creadorNFT = creadorNFT;
        nuevaSubasta.tokenId = _tokenId;
        nuevaSubasta.precioInicial = _precioInicial;
        nuevaSubasta.horaInicio = _horaInicio;
        nuevaSubasta.horaFin = _horaFin;
        nuevaSubasta.ofertaMasAlta = 0;
        nuevaSubasta.ganador = address(0);

        subastas.push(nuevaSubasta);
    }

    function ofertar(uint256 _idSubasta, uint256 _oferta) external {
        Subasta storage subasta = subastas[_idSubasta];
        require(block.timestamp >= subasta.horaInicio, "La subasta aun no ha comenzado");
        require(block.timestamp <= subasta.horaFin, "La subasta ha finalizado");
        require(_oferta > subasta.ofertaMasAlta, "La oferta debe ser mayor a la oferta actual");

        if (subasta.ofertaMasAlta > 0) {
            _transfer(msg.sender, subasta.ganador, subasta.ofertaMasAlta);
        }

        subasta.ofertaMasAlta = _oferta;
        subasta.ganador = msg.sender;
    }

    function finalizarSubasta(uint256 _idSubasta) external {
    Subasta storage subasta = subastas[_idSubasta];
    require(block.timestamp > subasta.horaFin, "La subasta aun no ha finalizado");
    require(subasta.ganador != address(0), "La subasta no tiene ganador");
    require(msg.sender == ownerMarketplace, "Solo el owner del marketplace puede finalizar la subasta");

    // Marca la subasta como finalizada
    subasta.horaFin = block.timestamp;

    // Transfiere el NFT al ganador
    nftContract.transferir(subasta.creadorNFT, subasta.ganador, subasta.tokenId);

    // Transfiere los fondos de la subasta al creador del NFT
    _transfer(address(this), subasta.creadorNFT, subasta.ofertaMasAlta);

    emit SubastaFinalizada(_idSubasta, subasta.ganador, subasta.ofertaMasAlta);
    }
    event SubastaFinalizada(uint256 indexed idSubasta, address ganador, uint256 monto);
}
