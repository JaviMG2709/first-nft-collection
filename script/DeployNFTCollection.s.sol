// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.34;

import {Script} from "forge-std/Script.sol";
import {BANFTCollection} from "../src/BANFTCollection.sol";

contract DeployNFTCollection is Script {
    function run() external returns (BANFTCollection) {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        string memory name_ = "Blockchain Accelerator NFT";
        string memory symbol_ = "BANFT";
        uint256 totalSupply_ = 2;
        string memory baseUri_ = "ipfs://bafybeihh224yxxgmabdku65mb3jpogx6m3bgfwkmsbretr32am3kaqjkt4/";

        BANFTCollection nftCollection = new BANFTCollection(name_, symbol_, totalSupply_, baseUri_);

        vm.stopBroadcast();
        return nftCollection;
    }
}
