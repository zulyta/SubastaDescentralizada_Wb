# Potenciando la Economía del Token: Subasta Descentralizada utilizando  ERC20 y  ERC721 

# La Economía del Token

El blockchain abrió la puerta a la economía del token. En esta nueva economía, el dinero es programado en código y ejecutado en el blockchain. Los usuarios tienen la capacidad de crear sus propios tipo de moneda o dinero digital usando contratos inteligentes. Ello trajo consigo que através del tiempo se estandaricen los activos digitales en al menos dos grupos: tokens fungibles y tokens no fungibles.

## Estándares de token

Son tres los estándares de token más conocidos y usados: `ERC20`, `ERC721` y `ERC1155`.



## ERC20

Es el estándar predominantemente usado para crear tokens fungibles en todo Blockchain compatible con el EVM.

Todo activo fungible es aquel que es intercambiable o idéntico a otros activos del mismo tipo. Cada unidad del activo es indistiguible de otro activo del mismo tipo. También, estos tokens si están en la misma cantidad posee en el mismo valor. Es decir que $10.00 sería fácilmente reemplazado por otros $10.00, lo mismo aplica para una cantidad cualquier de Bitcoins. No importa qué tipo de billete o token poseas, todos son equivalentes si estan en la misma cantidad.

A través de la poseción de este token, un usuario puede ganar derechos de voto, recibir recompensas por participar en la red y otras actividades que se hacen en el blockchain.

Los stable coins como el USDT, USDC, BUSD siguen los estándares del ERC20.

**Características del Estándar ERC-20**

El estándar ERC-20 establece varias funciones clave que deben estar presentes en cualquier contrato que cumpla con el estándar.

**Getters**



- `balanceOf(address _owner)`: Devuelve el saldo de tokens de un usuario específico.
- `totalSupply()`: Devuelve la cantidad total de tokens en circulación.
- `allowance(address _owner, address _spender)`: Devuelve la cantidad de tokens que un tercero autorizado puede gastar en nombre del propietario.
- `name()`: Devuelve el nombre del token.
- `symbol()`: Devuelve el símbolo del token.
- `decimals()`: Devuelve la cantidad de decimales utilizados por el token.

**Setters**



- `mint(address _to, uint256 _value)`: Permite la creación o generación de nuevos tokens a favor de una cuenta específica.
- `burn(uint256 _value)`:Permite quemar (eliminar) tokens, lo que puede generar deflación en la economía.
- `transfer(address _to, uint256 _value)`: Transfiere una cantidad específica de tokens desde la cuenta del remitente a la cuenta de destino.
- `transferFrom(address _from, address _to, uint256 _value)`: Permite a un tercero autorizado transferir tokens desde la cuenta del remitente a la cuenta de destino.
- `approve(address _spender, uint256 _value)`: Permite a un tercero autorizado gastar una cantidad específica de tokens en nombre del propietario.
- `transferOwnership(address newOwner)`: Transfiere la propiedad del contrato del token a una nueva dirección.
- `increaseAllowance`: Permite incrementar la cantidad de tokens que una cuenta ha autorizado para ser gastada por otra cuenta.

## ERC721

Este es el token estándar para crear tokens no fungible (NFT) que es un activo digital único e indivisible que representa la propiedad o autenticidad de un objeto digital o físico. A diferencia de los tokens fungibles, como los tokens ERC20, los NFT no son intercambiables directamente uno por uno. 

Cada NFT tiene su propio identificador único y no puede ser reemplazado por otro token.

**Características del Estándar ERC-20**

El estándar ERC-721 establece varias funciones clave que deben estar presentes en cualquier contrato que cumpla con el estándar.

**Getters**

- `balanceOf(address _owner)`: Devuelve el número de tokens no fungibles (NFT) que un propietario tiene en su posesión.
- `ownerOf(uint256 _tokenId)`: Devuelve la dirección del propietario de un NFT específico.
- `getApproved(uint256 _tokenId)`: Devuelve la dirección aprobada para la transferencia de un NFT específico.
- `isApprovedForAll(address _owner, address _operator)`: Devuelve true si el operador está aprobado para transferir todos los NFT del propietario.

**Setters**

- `safeTransferFrom(address _from, address _to, uint256 _tokenId)`: Transfiere la propiedad de un NFT de una dirección a otra de forma segura.
- `safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes memory _data)`: Transfiere la propiedad de un NFT de una dirección a otra de forma segura y permite la ejecución de un contrato externo después de la transferencia.
- `transferFrom(address _from, address _to, uint256 _tokenId)`: Transfiere la propiedad de un NFT de una dirección a otra.
- `approve(address _approved, uint256 _tokenId)`: Permite a una dirección específica aprobar o desaprobar la transferencia de un NFT en su nombre.
- `setApprovalForAll(address _operator, bool _approved)`: Permite a un operador aprobar o desaprobar todas las transferencias de NFT en nombre del propietario.

## Programando una subasta descentralizada aplicando ERC721 y ERC20

 Crearemos una plataforma de subastas descentralizadas que combina los estándares ERC721 y ERC20 en Ethereum en donde dos contratos principales involucrados deberán interactuar entre si. 

Cada uno tiene responsabilidades específicas en el proceso de subasta. 

**Contrato ERC721:**

Actúa como el mercado principal de tokens no fungibles (NFT).

- Facilita la creación y el registro de nuevos NFT cuando los propietarios cargan NFT u otros activos únicos.
- Permite la transferencia de los NFT al ganador de la subasta una vez que esta culmina.
- Mantiene un registro de las subastas en curso y los NFT asociados a ellas.

**Contrato ERC20:**

Controla y gestiona todo el proceso de las subastas 

- Crea subastas vinculadas a los NFT registrados en el contrato ERC721.
- Supervisa el inicio y la finalización de las subastas.
- Acepta ofertas de los participantes en forma de tokens fungibles (ERC20).
- Extiende automáticamente la duración de la subasta si se realizan ofertas más altas en los últimos 5 minutos.
- Permite a los postores no ganadores recuperar sus ofertas después de que la subasta finaliza.
- Emite eventos para notificar cambios y actualizaciones relacionados con las subastas.

La interacción entre estos dos contratos se basa en la creación de subastas enlazadas a los NFT registrados en el contrato ERC721. Posteriormente, el contrato ERC20 asume la responsabilidad de administrar las subastas individuales, incluyendo la recepción de ofertas, el seguimiento de la subasta, la extensión temporal y la transferencia del NFT al ganador.

## Implementación

## Demostración 

## Cierre del Webinar 

- Recomendaciones 

- Invitacion al Bootcamp

