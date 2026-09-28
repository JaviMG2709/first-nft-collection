# NFT Collection — Limited ERC-721 Minting

[English](README.md) | [Español](README.es.md)

NFT Collection is a personal Solidity learning project built with Foundry. It implements a small ERC-721 collection with public minting, sequential token IDs, a fixed supply cap, and token metadata referenced through IPFS.

## Features

- `mint()` mints the next available token to the caller on a first-come, first-served basis.
- Minting has no contract fee, per-wallet limit, allowlist, or owner restriction. Minters still pay the network gas fee.
- Token IDs are assigned sequentially starting at `0`.
- `currentTokenId` stores the next token ID to be minted.
- `totalSupply` stores the collection's maximum supply; it does not represent the number of tokens already minted.
- Minting reverts with `Sold out` once `currentTokenId` reaches `totalSupply`.
- `tokenURI(tokenId)` returns the base URI followed by the token ID and `.json`, and reverts when the token does not exist.
- Each successful mint emits the custom `MinNFT` event and the standard ERC-721 `Transfer` event.
- The collection name, symbol, supply cap, and base URI are set in the constructor and cannot be updated later.

The current deployment script configures a maximum supply of **2**, so its token IDs are `0` and `1`.

## Deployment

The latest successful deployment recorded in this repository is on **Arbitrum One** (chain ID `42161`):

- [View the contract on Arbiscan](https://arbiscan.io/address/0x8fd339ad2074d7ddef3e5d8e5aaf9f53915581d2): `0x8fd339ad2074d7ddef3e5d8e5aaf9f53915581d2`

## Tech Stack

- Solidity `0.8.34`
- Foundry and Forge for formatting, compilation, testing, and deployment
- OpenZeppelin Contracts for the ERC-721 implementation and integer-to-string conversion
- IPFS URIs for token metadata and images
- GitHub Actions for continuous integration

## Project Structure

| Path | Purpose |
| --- | --- |
| `src/BANFTCollection.sol` | ERC-721 contract and minting logic |
| `script/DeployNFTCollection.s.sol` | Deployment script and current collection parameters |
| `uris/0.json`, `uris/1.json` | Local copies of the token metadata |
| `broadcast/` | Recorded Arbitrum One deployment transactions |
| `.github/workflows/test.yml` | CI checks for formatting, compilation, and tests |
| `foundry.toml` | Foundry configuration |
| `lib/` | Git submodules containing Foundry and OpenZeppelin dependencies |

## Getting Started

Install [Foundry](https://getfoundry.sh/) and Git, then clone the repository with its submodules:

```sh
git clone --recurse-submodules <repository-url>
cd nft-collection
```

If the repository was cloned without its submodules, initialize them separately:

```sh
git submodule update --init --recursive
```

Build the contract and check its formatting:

```sh
forge build
forge fmt --check
```

The deployment script reads `PRIVATE_KEY` from the environment and uses the RPC URL supplied to Forge. Before deploying a new collection, review the constructor parameters defined in the script, especially the name, symbol, maximum supply, and IPFS base URI.

## Testing

The contract compiles successfully and passes the formatting check. There are currently no automated tests; `forge test` reports that no tests were found.

The GitHub Actions workflow runs formatting, compilation, and test commands on pushes, pull requests, and manual dispatches.

## Current Scope

This repository contains one mintable ERC-721 contract, a Foundry deployment script, two local metadata files, and recorded Arbitrum One deployments. It does not include a frontend or an off-chain indexing service.

The contract has no owner controls, mint price, per-wallet limit, allowlist, pause mechanism, reveal mechanism, or metadata update function. The base URI and maximum supply are fixed at deployment. This is a learning project and has not been audited for production use.

The custom event is named `MinNFT` in the contract. That spelling is retained here because it is part of the deployed contract's interface.

## What I Am Learning

- Building an ERC-721 collection with OpenZeppelin.
- Assigning sequential token IDs and enforcing a supply cap.
- Linking NFT metadata and images through IPFS.
- Writing and running a deployment script with Foundry.
- Inspecting recorded deployment transactions on a public network.

## Next Steps

- Add tests for successful minting, the sold-out condition, token URIs, and event emission.
- Test minting to contracts that implement `onERC721Received`.
- If deploying a new version, rename `MinNFT` to `MintNFT` and update any event consumers.
- Consider adding a frontend for viewing the collection and minting available tokens.
- Run static analysis and obtain a security review before considering production use.
