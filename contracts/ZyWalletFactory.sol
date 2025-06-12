// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "./ZySmartWallet.sol";

contract ZyWalletFactory {
    address public admin;
    mapping(bytes32 => address) public userWallets;

    event WalletCreated(bytes32 userId, address wallet);

    constructor() {
        admin = msg.sender;
    }

    function createWallet(
        bytes32 userId,
        address owner
    ) external returns (address) {
        require(userWallets[userId] == address(0), "Wallet exists");
        ZySmartWallet wallet = new ZySmartWallet(owner);
        userWallets[userId] = address(wallet);
        emit WalletCreated(userId, address(wallet));
        return address(wallet);
    }

    function getWallet(bytes32 userId) external view returns (address) {
        return userWallets[userId];
    }
}
