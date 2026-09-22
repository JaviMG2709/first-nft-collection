# Blockchain Accelerator NFT

[English](README.md) | [Español](README.es.md)

Blockchain Accelerator NFT es una pequeña colección ERC-721 creada con Solidity y Foundry. Cualquier persona puede acuñar uno de los dos NFT por orden de llegada. Los metadatos y las imágenes están alojados en IPFS.

## Características

- `mint()` acuña el siguiente token disponible para quien llama a la función. El contrato no cobra por la acuñación ni impone un límite por cartera o una restricción de propietario; sí se paga el gas de la red.
- El suministro máximo se establece en **2** en el script de despliegue. Los identificadores de token son `0` y `1`.
- `currentTokenId` indica el siguiente identificador y `totalSupply` guarda el suministro máximo.
- `tokenURI(tokenId)` devuelve la URI base de IPFS seguida del identificador y `.json` (por ejemplo, `.../0.json`). La llamada revierte si el token no existe.
- Cada acuñación correcta emite el evento personalizado `MinNFT` y el evento estándar `Transfer` de ERC-721.

## Contrato desplegado

El último despliegue correcto registrado en este repositorio está en **Arbitrum One** (ID de cadena `42161`):

- [Contrato en Arbiscan](https://arbiscan.io/address/0x8fd339ad2074d7ddef3e5d8e5aaf9f53915581d2): `0x8fd339ad2074d7ddef3e5d8e5aaf9f53915581d2`
- [Colección en OpenSea](https://opensea.io/es/collection/blockchain-accelerator-nft-139082643): ver los NFT

La página de OpenSea muestra los NFT de la colección. El enlace de Arbiscan permite comprobar la dirección del contrato.

## Tecnologías

- Solidity `0.8.34`
- Foundry / Forge para compilar y desplegar
- OpenZeppelin Contracts para ERC-721 y la conversión a texto
- IPFS para los metadatos y las imágenes

## Estructura del proyecto

| Ruta | Función |
| --- | --- |
| `src/BANFTCollection.sol` | Contrato ERC-721 y lógica de acuñación |
| `script/DeployNFTCollection.s.sol` | Script de despliegue y parámetros de la colección |
| `uris/0.json`, `uris/1.json` | Copias locales de los metadatos |
| `broadcast/` | Despliegues registrados en Arbitrum |
| `foundry.toml` | Configuración de Foundry |
| `lib/` | Submódulos de Git con las dependencias |

## Primeros pasos

Instala [Foundry](https://getfoundry.sh/) y Git. Después, clona el repositorio con sus submódulos:

```sh
git clone --recurse-submodules <url-del-repositorio>
cd nft-collection
```

Si ya clonaste el repositorio sin los submódulos:

```sh
git submodule update --init --recursive
```

Compila los contratos y comprueba el formato:

```sh
forge build
forge fmt --check
```

El script de despliegue lee `PRIVATE_KEY` del entorno y utiliza la URL RPC que se pasa a Forge. Revisa el nombre, el símbolo, el suministro máximo y la URI base de IPFS antes de desplegar tu propia colección.

## Pruebas y alcance actual

`forge build` termina correctamente. **Todavía no hay pruebas automatizadas**; por ahora, `forge test` indica que no encuentra ninguna. El flujo de CI del repositorio ejecuta las comprobaciones de formato, compilación y pruebas.

El contrato no tiene controles de propietario, precio de acuñación, límite por cartera ni función para modificar los metadatos. La URI base y el suministro máximo quedan fijados al desplegarlo. El evento personalizado se llama `MinNFT` en el contrato; se conserva esa grafía porque forma parte de la interfaz del contrato desplegado. Es un proyecto de aprendizaje y no se ha auditado para su uso en producción.

## Qué estoy aprendiendo

- Crear una colección ERC-721 con OpenZeppelin.
- Asignar identificadores consecutivos y limitar el suministro.
- Guardar metadatos e imágenes de NFT en IPFS.
- Desplegar un contrato con Foundry y comprobar las transacciones registradas.

## Próximos pasos

- Añadir pruebas para la acuñación, el agotamiento de la colección, las URI y la emisión de eventos.
- Revisar la acuñación dirigida a contratos que implementen `onERC721Received`.
- Si se despliega una nueva versión, corregir `MinNFT` por `MintNFT` y actualizar los clientes que consuman el evento.
