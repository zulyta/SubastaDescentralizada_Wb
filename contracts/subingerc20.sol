// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

interface IERC20 {
    function transfer(address to, uint256 value) external returns (bool);
    function transferFrom(address from, address to, uint256 value) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract SubastaERC20 {
    struct Subasta {
        uint256 startTime;
        uint256 endTime;
        address mejorPostor;
        uint256 mejorOferta;
        mapping(address => uint256) ofertas;
    }
    mapping(bytes32 => Subasta) public subastas;

    // Subastas activas
    bytes32[] public subastasActivas;
    mapping(bytes32 => uint256) public indiceSubasta;

    uint256 contador;

    event SubastaCreada(bytes32 indexed _subastaId, address indexed _creador);
    event OfertaRealizada(address indexed _postor, uint256 _oferta);
    event SubastaFinalizada(address indexed _ganador, uint256 _oferta);

    error CantidadIncorrectaTokens();
    error TiempoInvalido();
    error SubastaInexistente();
    error FueraDeTiempo();
    error OfertaInvalida();
    error SubastaEnCurso();

    IERC20 public token;

    constructor(address _tokenAddress) {
        token = IERC20(_tokenAddress);
    }

    function crearSubasta(uint256 _startTime, uint256 _endTime) public {
        require(token.transferFrom(msg.sender, address(this), 1 ether), "CantidadIncorrectaTokens");
        require(_endTime > _startTime, "TiempoInvalido");

        bytes32 _subastaId = _crearId(_startTime, _endTime);
        subastasActivas.push(_subastaId);
        indiceSubasta[_subastaId] = contador;
        contador++;

        Subasta storage subasta = subastas[_subastaId];
        subasta.startTime = _startTime;
        subasta.endTime = _endTime;

        emit SubastaCreada(_subastaId, msg.sender);
    }

    function realizarOferta(bytes32 _subastaId) public {
        Subasta storage subasta = subastas[_subastaId];

        require(subasta.startTime != 0, "SubastaInexistente");
        require(subasta.endTime > block.timestamp, "FueraDeTiempo");

        uint256 ofertaTotal = subasta.ofertas[msg.sender] + 1 ether;

        require(ofertaTotal > subasta.mejorOferta, "OfertaInvalida");

        if (subasta.endTime - block.timestamp <= 5 minutes) {
            subasta.endTime += 5 minutes;
        }

        subasta.mejorPostor = msg.sender;
        subasta.mejorOferta = ofertaTotal;
        subasta.ofertas[msg.sender] = ofertaTotal;

        emit OfertaRealizada(msg.sender, ofertaTotal);
    }

    function finalizarSubasta(bytes32 _subastaId) public {
        Subasta storage subasta = subastas[_subastaId];
        require(subasta.startTime != 0, "SubastaInexistente");
        require(subasta.endTime <= block.timestamp, "SubastaEnCurso");

        subastasActivas[indiceSubasta[_subastaId]] = subastasActivas[subastasActivas.length - 1];
        subasta.startTime = 0;
        subasta.ofertas[subasta.mejorPostor] += 1 ether;
        subastasActivas.pop();
        contador--;

        require(token.transfer(subasta.mejorPostor, subasta.mejorOferta), "Transferencia fallida");

        emit SubastaFinalizada(subasta.mejorPostor, subasta.mejorOferta);
    }

    function recuperarOferta(bytes32 _subastaId) public {
        Subasta storage subasta = subastas[_subastaId];
        require(subasta.endTime > block.timestamp || subasta.startTime != 0, "SubastaEnCurso");
        uint256 cantidad = subasta.ofertas[msg.sender];
        subasta.ofertas[msg.sender] = 0;
        require(token.transfer(msg.sender, cantidad), "Transferencia fallida");
    }

    function verSubastasActivas() public view returns (bytes32[] memory) {
        return subastasActivas;
    }

    ////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////   MÉTODOS INTERNOS  ///////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////

    function _crearId(uint256 _startTime, uint256 _endTime) internal view returns (bytes32) {
        return keccak256(abi.encodePacked(_startTime, _endTime, msg.sender, block.timestamp));
    }
}
