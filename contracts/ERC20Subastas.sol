// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./ERC721Market.sol";

contract MiContratoERC20 is ERC20, Ownable {
     MiContratoERC721 private nftContract;
    address private ownerMarketplace;

    constructor(address _nftContractAddress, address _ownerMarketplace) ERC20("NombreDelToken", "SimboloDelToken") {
        nftContract = MiContratoERC721(_nftContractAddress);
        ownerMarketplace = _ownerMarketplace;
    }

    struct Subasta {
        address creador;
        uint256 tokenId;
        uint256 precioInicial;
        uint256 horaInicio;
        uint256 horaFin;
        uint256 ofertaMasAlta;
        address ganador;
    }

    Subasta[] public subastas;
    event SubastaFinalizada(uint256 indexed idSubasta, address ganador, uint256 monto);

    function iniciarSubasta(uint256 _tokenId, uint256 _precioInicial, uint256 _horaInicio, uint256 _horaFin) external {
        require(_precioInicial > 0, "El precio inicial debe ser mayor a 0");
        require(_horaInicio < _horaFin, "La hora de inicio debe ser antes de la hora de finalizacion");

        nftContract.approveTransfer(address(ownerMarketplace), _tokenId); // Asegura el permiso para transferir el NFT

        subastas.push(Subasta({
            creador: msg.sender,
            tokenId: _tokenId,
            precioInicial: _precioInicial,
            horaInicio: _horaInicio,
            horaFin: _horaFin,
            ofertaMasAlta: 0,
            ganador: address(0)
        }));
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

        nftContract.transferir(subasta.ganador, subasta.tokenId); // Transfiere el NFT al ganador
        _transfer(subasta.ganador, subasta.creador, subasta.ofertaMasAlta);

        emit SubastaFinalizada(_idSubasta, subasta.ganador, subasta.ofertaMasAlta);
    }
}