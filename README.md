# Blockchain Accelerator NFT

[English](README.md) | [Español](README.es.md)

Blockchain Accelerator NFT is a small ERC-721 collection built with Solidity and Foundry. Anyone can mint one of two NFTs on a first-come, first-served basis. Token metadata and images are hosted on IPFS.

## Features

- `mint()` mints the next available token to the caller. Minting has no contract fee, per-wallet limit, or owner restriction; network gas fees still apply.
- The maximum supply is set to **2** in the deployment script. Token IDs start at `0` and end at `1`.
- `currentTokenId` tracks the next token ID, while `totalSupply` stores the maximum supply.
- `tokenURI(tokenId)` returns the IPFS base URI followed by the token ID and `.json` (for example, `.../0.json`). It reverts for tokens that do not exist.
- Each successful mint emits the custom `MinNFT` event, as well as the standard ERC-721 `Transfer` event.

## Deployed contract

The latest successful deployment recorded in this repository is on **Arbitrum One** (chain ID `42161`):

- [Contract on Arbiscan](https://arbiscan.io/address/0x8fd339ad2074d7ddef3e5d8e5aaf9f53915581d2): `0x8fd339ad2074d7ddef3e5d8e5aaf9f53915581d2`
- [Collection on OpenSea](https://opensea.io/es/collection/blockchain-accelerator-nft-139082643): view the NFTs

The OpenSea page displays the collection's NFTs. You can use the Arbiscan link to check the contract address.

## Tech stack

- Solidity `0.8.34`
- Foundry / Forge for compilation and deployment
- OpenZeppelin Contracts for ERC-721 and string conversion
- IPFS for token metadata and images

## Project structure

| Path | Purpose |
| --- | --- |
| `src/BANFTCollection.sol` | ERC-721 contract and minting logic |
| `script/DeployNFTCollection.s.sol` | Deployment script and collection settings |
| `uris/0.json`, `uris/1.json` | Local copies of the token metadata |
| `broadcast/` | Recorded Arbitrum deployments |
| `foundry.toml` | Foundry configuration |
| `lib/` | Git submodules for dependencies |

## Getting started

Install [Foundry](https://getfoundry.sh/) and Git, then clone the repository with its submodules:

```sh
git clone --recurse-submodules <repository-url>
cd nft-collection
```

If you already cloned the repository without submodules:

```sh
git submodule update --init --recursive
```

Build the contracts and check their formatting:

```sh
forge build
forge fmt --check
```

The deployment script reads `PRIVATE_KEY` from the environment and uses the RPC URL supplied to Forge. Review the script's name, symbol, maximum supply, and IPFS base URI before deploying your own collection.

## Testing and current scope

`forge build` succeeds. There are **no automated tests yet**; `forge test` currently reports that no tests were found. The repository's CI workflow runs formatting, build, and test commands.

The contract has no owner controls, mint price, per-wallet limit, or metadata update function. The metadata base URI and maximum supply are fixed at deployment. The custom event is named `MinNFT` in the contract; this spelling is retained because it is part of the deployed contract's interface. This is a learning project and has not been audited for production use.

## What I am learning

- Creating an ERC-721 collection with OpenZeppelin.
- Assigning sequential token IDs and enforcing a supply cap.
- Storing NFT metadata and images on IPFS.
- Deploying a contract with Foundry and checking its recorded transactions.

## Next steps

- Add tests for successful mints, the sold-out condition, token URIs, and event emission.
- Review minting behavior with contracts that implement `onERC721Received`.
- If deploying a new version, rename `MinNFT` to `MintNFT` and update any clients that consume the event.
