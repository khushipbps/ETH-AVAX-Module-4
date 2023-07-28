# ETH + AVAX Module 4

This project is an application of connecting Remix IDE with Testnet SnowTrace, MetaMask and perform certains operations which can be seen in demo very well

## Features

This project has following features/applications:
- Minting new tokens
- Transferring tokens
- Redeeming tokens
- Checking token balance
- Burning tokens
- connecting Testnet Snowtrace with Metamask Provider


## Description
Project mainly concerns with burning, minting, checking balance, burning the tokens. Below is a great detailed explanation
First we have created two modifier functions which are reusables
1. `senderHavingEnoughBalance` is used to check if user has enough balance as compared to amount as argument
```solidity
modifier senderHavingEnoughBalance(uint256 amount)
```
2. `validChoice` modifier is used to check if use has entered correct choice or not
```solidity
modifier validChoice(uint256 _input)
```
1. This function is used to check the balance of sender
```solidity
function checkBalance() external view returns(uint)
```

Further useful functions are :- 

1. Burn function is used to decrease the tokens and it used `_burn` function from inherited modules
```solidity
function burnTokens(uint256 amount) external senderHavingEnoughBalance(amount)
```

2. `getStoreItems` is used to fetch the items available in store
```solidity
function getStoreItems() external pure returns(string memory)
```

3. This function is used to redeem tokens from the store based on available balance of the user
```solidity
 function reedemTokens(uint256 _input) external payable validChoice(_input)
```
4. Mint function is mainly used to increase tokens where only owner is allowed to do so
```solidity
 function mint(uint256 amount) external onlyOwner {
     _mint(msg.sender, amount);
 }
```
5. This function allows calling having enough tokens and transfers to recipient
```solidity
function transferTokens(address _reciever, uint256 amount) external senderHavingEnoughBalance(amount)
```

## Getting Started
### Pre-requisites
- MetaMask Extension

### Setup
- Clone this code
- Mostly solidity code is required. So copy that and paste in remix IDE
- Now in Remix IDE, select Injected Provider Metamask
- Also Metamask should be configured to testnet snowtrace
- Compile and deploy the code giving permissions
- Then copy the contract address and paste in `At address` and bring the build and interact with the deployed contract
- After performing some transactions, you can see there also

## Authors
Khushi Kumari

## License
This project is licensed under the MIT License - see the LICENSE.md file for details
