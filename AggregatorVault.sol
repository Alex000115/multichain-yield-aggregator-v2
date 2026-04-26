// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract AggregatorVault is ERC20, Ownable {
    using SafeERC20 for IERC20;
    
    IERC20 public immutable underlyingAsset;
    uint256 public totalInvested;

    event Deposited(address indexed user, uint256 amount, uint256 shares);
    event Rebalanced(address targetChain, uint256 amount);

    constructor(
        address _asset, 
        string memory _name, 
        string memory _symbol
    ) ERC20(_name, _symbol) Ownable(msg.sender) {
        underlyingAsset = IERC20(_asset);
    }

    function deposit(uint256 _amount) external {
        uint256 totalAssets = underlyingAsset.balanceOf(address(this)) + totalInvested;
        uint256 shares = (totalSupply() == 0) ? _amount : (_amount * totalSupply()) / totalAssets;
        
        underlyingAsset.safeTransferFrom(msg.sender, address(this), _amount);
        _mint(msg.sender, shares);
        
        emit Deposited(msg.sender, _amount, shares);
    }

    function setTotalInvested(uint256 _newAmount) external onlyOwner {
        totalInvested = _newAmount;
    }
}
