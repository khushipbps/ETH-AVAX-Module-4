// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// Minting new tokens: The platform should be able to create new tokens and distribute them to players as rewards. Only the owner can mint tokens.
// Transferring tokens: Players should be able to transfer their tokens to others.
// Redeeming tokens: Players should be able to redeem their tokens for items in the in-game store.
// Checking token balance: Players should be able to check their token balance at any time.
// Burning tokens: Anyone should be able to burn tokens, that they own, that are no longer needed.


import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "hardhat/console.sol";

contract FighterContract is ERC20, Ownable, ERC20Burnable {
    struct StoreItem {
        string name;
        uint256 value;
    }

    mapping(uint256 => StoreItem) public storeMap;

    constructor() ERC20("Degen", "DGN") {
        storeMap[1] = StoreItem("Gun", 1000);
        storeMap[2] = StoreItem("Suite", 5000);
        storeMap[3] = StoreItem("Bullet", 500);
    }
    modifier senderHavingEnoughBalance(uint256 amount) {
        require(balanceOf(msg.sender) >= amount, "You do not have enough balance");
        _;
    }

    modifier validChoice(uint256 _input) {
        require(_input <=3,"Invalid choice selection");
        require(_input >= 1,"Invalid choice selection");
        _;
    }

    function getStoreItems() external pure returns(string memory){
        return "1. Gun = 1000 \
                2. Suite = 5000  \
                3. Bullet = 500";
    }


    function reedemTokens(uint256 _input) external payable validChoice(_input){
            StoreItem memory storeItem = storeMap[_input];
            uint256 value = storeItem.value;

            require(value <= this.balanceOf(msg.sender), "You do not have enough balance");
            approve(msg.sender, value);
            transferFrom(msg.sender, owner(), value);
        }

        // Minting only by owner
        function mint(address to, uint256 amount) external onlyOwner{
            _mint(to, amount);
        }

        // Transfer tomen to other user
        function transferTokens(address _reciever, uint256 amount) external senderHavingEnoughBalance(amount){
            approve(msg.sender, amount);
            transferFrom(msg.sender, _reciever, amount);
        }


        // Get balance of the user
        function checkBalance() external view returns(uint){
           return this.balanceOf(msg.sender);
        }
        
        // burn own balance
        function burnTokens(uint256 amount) external senderHavingEnoughBalance(amount) {
            _burn(msg.sender, amount);
        }


}