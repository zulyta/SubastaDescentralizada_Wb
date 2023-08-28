# Potenciando la Economía del Token: Subasta Descentralizada utilizando  ERC20 y  ERC721 

# La Economía del Token

El blockchain abrió la puerta a la economía del token. En esta nueva economía, el dinero es programado en código y ejecutado en el blockchain. Los usuarios tienen la capacidad de crear sus propios tipo de moneda o dinero digital usando contratos inteligentes. Ello trajo consigo que através del tiempo se estandaricen los activos digitales en al menos dos grupos: tokens fungibles y tokens no fungibles.

## Estándares de token

Son tres los estándares de token más conocidos y usados: `ERC20`, `ERC721` y `ERC1155`.

[![tokens estándar 20,721,1155](https://private-user-images.githubusercontent.com/3300958/244394774-110446e6-95b5-4269-9ba4-8c59cb16ce91.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTEiLCJleHAiOjE2OTMyNjE4MjgsIm5iZiI6MTY5MzI2MTUyOCwicGF0aCI6Ii8zMzAwOTU4LzI0NDM5NDc3NC0xMTA0NDZlNi05NWI1LTQyNjktOWJhNC04YzU5Y2IxNmNlOTEucG5nP1gtQW16LUFsZ29yaXRobT1BV1M0LUhNQUMtU0hBMjU2JlgtQW16LUNyZWRlbnRpYWw9QUtJQUlXTkpZQVg0Q1NWRUg1M0ElMkYyMDIzMDgyOCUyRnVzLWVhc3QtMSUyRnMzJTJGYXdzNF9yZXF1ZXN0JlgtQW16LURhdGU9MjAyMzA4MjhUMjIyNTI4WiZYLUFtei1FeHBpcmVzPTMwMCZYLUFtei1TaWduYXR1cmU9YTBmZDA0NzQwNDM4ZmQ5ZmM4ODE2NTdlYjM0ZjMyZGZjODQyNzZmMjM3MzYxYzUyZDgwMzAxOWIwY2JkMTVmNiZYLUFtei1TaWduZWRIZWFkZXJzPWhvc3QmYWN0b3JfaWQ9MCZrZXlfaWQ9MCZyZXBvX2lkPTAifQ.KsvseeMsanBV-D5m_TvYEUbguHDDxIUGhJO1XF9zMW4)](https://private-user-images.githubusercontent.com/3300958/244394774-110446e6-95b5-4269-9ba4-8c59cb16ce91.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTEiLCJleHAiOjE2OTMyNjE4MjgsIm5iZiI6MTY5MzI2MTUyOCwicGF0aCI6Ii8zMzAwOTU4LzI0NDM5NDc3NC0xMTA0NDZlNi05NWI1LTQyNjktOWJhNC04YzU5Y2IxNmNlOTEucG5nP1gtQW16LUFsZ29yaXRobT1BV1M0LUhNQUMtU0hBMjU2JlgtQW16LUNyZWRlbnRpYWw9QUtJQUlXTkpZQVg0Q1NWRUg1M0ElMkYyMDIzMDgyOCUyRnVzLWVhc3QtMSUyRnMzJTJGYXdzNF9yZXF1ZXN0JlgtQW16LURhdGU9MjAyMzA4MjhUMjIyNTI4WiZYLUFtei1FeHBpcmVzPTMwMCZYLUFtei1TaWduYXR1cmU9YTBmZDA0NzQwNDM4ZmQ5ZmM4ODE2NTdlYjM0ZjMyZGZjODQyNzZmMjM3MzYxYzUyZDgwMzAxOWIwY2JkMTVmNiZYLUFtei1TaWduZWRIZWFkZXJzPWhvc3QmYWN0b3JfaWQ9MCZrZXlfaWQ9MCZyZXBvX2lkPTAifQ.KsvseeMsanBV-D5m_TvYEUbguHDDxIUGhJO1XF9zMW4)

## ERC20

Es el estándar predominantemente usado para crear tokens fungibles en todo Blockchain compatible con el EVM.

Todo activo fungible es aquel que es intercambiable o idéntico a otros activos del mismo tipo. Cada unidad del activo es indistiguible de otro activo del mismo tipo. También, estos tokens si están en la misma cantidad posee en el mismo valor. Es decir que $10.00 sería fácilmente reemplazado por otros $10.00, lo mismo aplica para una cantidad cualquier de Bitcoins. No importa qué tipo de billete o token poseas, todos son equivalentes si estan en la misma cantidad.

A través de la poseción de este token, un usuario puede ganar derechos de voto, recibir recompensas por participar en la red y otras actividades que se hacen en el blockchain.

Los stable coins como el USDT, USDC, BUSD siguen los estándares del ERC20.

**Características del Estándar ERC-20**

El estándar ERC-20 establece varias funciones clave que deben estar presentes en cualquier contrato que cumpla con el estándar.

**Getters**

Funciones de Lectura (no modifican el estado de la cadena de bloques):

- `balanceOf(address _owner)`: Devuelve el saldo de tokens de un usuario específico.
- `totalSupply()`: Devuelve la cantidad total de tokens en circulación.
- `allowance(address _owner, address _spender)`: Devuelve la cantidad de tokens que un tercero autorizado puede gastar en nombre del propietario.
- `name()`: Devuelve el nombre del token.
- `symbol()`: Devuelve el símbolo del token.
- `decimals()`: Devuelve la cantidad de decimales utilizados por el token.

**Setters**

Funciones de Escritura (modifican el estado de la cadena de bloques)

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

**ERC721_MarketNFT**

Este contrato actúa como el mercado principal para las obras de arte en forma de tokens no fungibles (NFTs). 

***Funciones***

- Crear y registrar nuevos tokens no fungibles (NFTs) cuando los propietarios suben obras de arte a la plataforma.
- Crear subastas asociadas con los NFTs registrados. 
- Gestionar la creación y finalización de subastas.
- Facilitar la transferencia de NFTs al ganador de la subasta una vez que esta finaliza.
- Mantener un registro de las subastas activas y sus respectivos tokens NFTs.

**ERC20_Subastas** 

Este contrato se encarga de gestionar las subastas individuales. 

***Funciones***

- Recibir ofertas de los participantes en la subasta utilizando tokens fungibles (FTs).
- Mantener el seguimiento de las ofertas actuales y el participante que realizó la oferta más alta.
- Extender el tiempo de la subasta si se realizan ofertas cercanas a su finalización.
- Permitir a los participantes no ganadores recuperar sus ofertas.
- Facilitar la transferencia del NFT subastado al ganador una vez que la subasta finaliza.
- Emitir eventos para informar sobre los cambios en la subasta.

## Implementación

## Demostración 

## Cierre del Webinar 

- Recomendaciones 

- Invitacion al Bootcamp