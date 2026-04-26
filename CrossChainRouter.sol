// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

interface ILayerZeroEndpoint {
    function send(uint16 _dstChainId, bytes calldata _destination, bytes calldata _payload, address payable _refundAddress, address _zroPaymentAddress, bytes calldata _adapterParams) external payable;
}

contract CrossChainRouter is Ownable {
    ILayerZeroEndpoint public lzEndpoint;

    constructor(address _endpoint) Ownable(msg.sender) {
        lzEndpoint = ILayerZeroEndpoint(_endpoint);
    }

    function rebalanceToChain(
        uint16 _dstChainId, 
        bytes calldata _dstContract, 
        uint256 _amount
    ) external payable onlyOwner {
        bytes memory payload = abi.encode(_amount);
        lzEndpoint.send{value: msg.value}(
            _dstChainId,
            _dstContract,
            payload,
            payable(msg.sender),
            address(0),
            ""
        );
    }
}
