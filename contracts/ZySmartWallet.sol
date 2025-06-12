// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface IERC20 {
    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    function balanceOf(address account) external view returns (uint256);
}

contract ZySmartWallet {
    address public owner;
    address public guardian;
    mapping(address => bool) public relayers;

    event Executed(address target, bytes data);
    event OwnershipTransferred(address newOwner);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    modifier onlyRelayer() {
        require(relayers[msg.sender], "Not relayer");
        _;
    }

    constructor(address _owner) {
        owner = _owner;
    }

    function setGuardian(address _guardian) external onlyOwner {
        guardian = _guardian;
    }

    function transferOwnership(address _newOwner) external {
        require(msg.sender == guardian, "Only guardian");
        owner = _newOwner;
        emit OwnershipTransferred(_newOwner);
    }

    function addRelayer(address _relayer) external onlyOwner {
        relayers[_relayer] = true;
    }

    function execute(
        address _target,
        bytes calldata _data
    ) external onlyRelayer {
        (bool success, ) = _target.call(_data);
        require(success, "Tx failed");
        emit Executed(_target, _data);
    }

    function getBalance(address token) external view returns (uint256) {
        return IERC20(token).balanceOf(address(this));
    }
}
