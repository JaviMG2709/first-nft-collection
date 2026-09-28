# Colección NFT — Acuñación limitada de ERC-721

[English](README.md) | [Español](README.es.md)

Este repositorio es un proyecto personal de aprendizaje de Solidity desarrollado con Foundry. Implementa una pequeña colección ERC-721 con acuñación pública, identificadores de token secuenciales, un suministro máximo fijo y metadatos referenciados mediante IPFS.

## Funcionalidades

- `mint()` acuña el siguiente token disponible para quien llama a la función, por orden de llegada.
- La acuñación no tiene un precio establecido por el contrato, límite por cartera, lista de permitidos ni restricción de propietario. Quien acuña sí debe pagar el gas de la red.
- Los identificadores de token se asignan secuencialmente a partir de `0`.
- `currentTokenId` guarda el siguiente identificador que se acuñará.
- `totalSupply` guarda el suministro máximo de la colección; no representa la cantidad de tokens ya acuñados.
- La acuñación revierte con `Sold out` cuando `currentTokenId` alcanza `totalSupply`.
- `tokenURI(tokenId)` devuelve la URI base seguida del identificador del token y `.json`, y revierte si el token no existe.
- Cada acuñación correcta emite el evento personalizado `MinNFT` y el evento estándar `Transfer` de ERC-721.
- El nombre, el símbolo, el suministro máximo y la URI base de la colección se establecen en el constructor y no pueden modificarse después.

El script de despliegue actual configura un suministro máximo de **2**, por lo que sus identificadores de token son `0` y `1`.

## Despliegue

El último despliegue correcto registrado en este repositorio está en **Arbitrum One** (ID de cadena `42161`):

- [Ver el contrato en Arbiscan](https://arbiscan.io/address/0x8fd339ad2074d7ddef3e5d8e5aaf9f53915581d2): `0x8fd339ad2074d7ddef3e5d8e5aaf9f53915581d2`

## Tecnologías

- Solidity `0.8.34`
- Foundry y Forge para el formato, la compilación, las pruebas y el despliegue
- OpenZeppelin Contracts para la implementación de ERC-721 y la conversión de enteros a texto
- URI de IPFS para los metadatos y las imágenes de los tokens
- GitHub Actions para la integración continua

## Estructura del proyecto

| Ruta | Función |
| --- | --- |
| `src/BANFTCollection.sol` | Contrato ERC-721 y lógica de acuñación |
| `script/DeployNFTCollection.s.sol` | Script de despliegue y parámetros actuales de la colección |
| `uris/0.json`, `uris/1.json` | Copias locales de los metadatos de los tokens |
| `broadcast/` | Transacciones de despliegue registradas en Arbitrum One |
| `.github/workflows/test.yml` | Comprobaciones de formato, compilación y pruebas en CI |
| `foundry.toml` | Configuración de Foundry |
| `lib/` | Submódulos de Git con las dependencias de Foundry y OpenZeppelin |

## Primeros pasos

Instala [Foundry](https://getfoundry.sh/) y Git. Después, clona el repositorio con sus submódulos:

```sh
git clone --recurse-submodules <url-del-repositorio>
cd nft-collection
```

Si clonaste el repositorio sin sus submódulos, inicialízalos por separado:

```sh
git submodule update --init --recursive
```

Compila el contrato y comprueba su formato:

```sh
forge build
forge fmt --check
```

El script de despliegue lee `PRIVATE_KEY` del entorno y utiliza la URL RPC proporcionada a Forge. Antes de desplegar una colección nueva, revisa los parámetros del constructor definidos en el script, sobre todo el nombre, el símbolo, el suministro máximo y la URI base de IPFS.

## Pruebas

El contrato compila correctamente y supera la comprobación de formato. Actualmente no hay pruebas automatizadas; `forge test` indica que no se ha encontrado ninguna.

El flujo de GitHub Actions ejecuta los comandos de formato, compilación y pruebas con cada envío de cambios, solicitud de incorporación y ejecución manual.

## Alcance actual

Este repositorio contiene un contrato ERC-721 acuñable, un script de despliegue de Foundry, dos archivos locales de metadatos y despliegues registrados en Arbitrum One. No incluye una interfaz web ni un servicio externo de indexación.

El contrato no tiene controles de propietario, precio de acuñación, límite por cartera, lista de permitidos, mecanismo de pausa, mecanismo de revelado ni función para modificar los metadatos. La URI base y el suministro máximo quedan fijados durante el despliegue. Es un proyecto de aprendizaje y no se ha auditado para su uso en producción.

El evento personalizado se llama `MinNFT` en el contrato. Se conserva esa grafía en la documentación porque forma parte de la interfaz del contrato desplegado.

## Qué estoy aprendiendo

- Crear una colección ERC-721 con OpenZeppelin.
- Asignar identificadores secuenciales y aplicar un límite de suministro.
- Enlazar metadatos e imágenes de NFT mediante IPFS.
- Escribir y ejecutar un script de despliegue con Foundry.
- Inspeccionar las transacciones de despliegue registradas en una red pública.

## Próximos pasos

- Añadir pruebas para la acuñación correcta, el agotamiento de la colección, las URI de los tokens y la emisión de eventos.
- Probar la acuñación hacia contratos que implementen `onERC721Received`.
- Si se despliega una versión nueva, cambiar `MinNFT` por `MintNFT` y actualizar cualquier consumidor de los eventos.
- Valorar la creación de una interfaz web para consultar la colección y acuñar los tokens disponibles.
- Ejecutar análisis estático y obtener una revisión de seguridad antes de plantear un uso en producción.
