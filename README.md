# Protocol Overview 

The Swap Contract is a Solidity smart contract designed to facilitate the exchange of one ERC20 token for another at a fixed rate. It utilizes the OpenZeppelin library for secure token interactions. The contract primarily consists of two main functions:

## `swapAforB(uint256 amount)`
Allows users to swap a specified amount of Token A for Token B. The output amount of Token B is calculated by multiplying the input amount of Token A by a fixed rate.

## `swapBforA(uint256 amount)`
Allows users to swap a specified amount of Token B for Token A. The output amount of Token A is calculated by dividing the input amount of Token B by the same fixed rate.

Feel free to use this markdown code in your GitHub readme!


# How to run
1.  **Install Foundry**

First, run the command below to get Foundryup, the Foundry toolchain installer:

``` bash
curl -L https://foundry.paradigm.xyz | bash
```

Then, in a new terminal session or after reloading your PATH, run it to get the latest forge and cast binaries:

``` console
foundryup
```

2. **Clone This Repo and install dependencies**
``` 
git clone https://github.com/anjanayraina/Assigment1
cd Assigment1
forge install

```

3. **Run the Tests**



``` 
forge test
```

# Design Choices

The Swap Contract makes several design choices:

## Fixed Exchange Rate
The exchange rate between Token A and Token B is set at contract deployment and remains constant. This simplifies the swap logic but does not allow for dynamic pricing based on market conditions.

## One-Way Rate Calculation
The rate is applied directly when swapping Token A for Token B (multiplication), and its inverse is used when swapping Token B for Token A (division). This could lead to rounding issues, especially for small amounts of Token B or when the rate is not an integer.

## Use of SafeERC20
The contract uses OpenZeppelin's SafeERC20 library to interact with ERC20 tokens. This library provides functions that throw errors if a token transfer fails, adding an extra layer of security against tokens that do not return a boolean value.

## Event Emission
The contract emits an event after each swap, which helps in tracking swaps off-chain and provides transparency for contract interactions.

## No Ownership or Administrative Functions
The contract lacks any ownership or administrative functions, meaning that once deployed, the rate cannot be changed, and tokens cannot be withdrawn by an administrator. This could be seen as a feature that promotes trust, as users know the contract cannot be altered to their disadvantage.

## Direct Transfer of Tokens
The contract directly transfers tokens from the user to the contract and vice versa, without any intermediary steps. This straightforward approach reduces complexity but also means that the contract itself must hold a sufficient balance of each token to fulfill swaps.

# Security Considerations 

The Swap Contract implements several security considerations to ensure safe operation and protect users' funds:

## Use of SafeERC20
By using OpenZeppelin's SafeERC20 library, the contract ensures that all token transfers are handled safely. The `safeTransfer` and `safeTransferFrom` methods provided by the library help prevent issues with tokens that do not return a boolean value upon transfer, which is a common ERC20 compliance issue.

## Reentrancy Protection
Although not explicitly mentioned in the provided code, the use of SafeERC20's `safeTransfer` and `safeTransferFrom` methods can mitigate reentrancy attacks because these methods ensure that control is not passed to an external contract with a non-zero transfer. However, it's worth noting that additional reentrancy guards could be implemented for extra security.

## Event Logging
The contract emits a `Swapped` event after each successful swap, providing transparency and an audit trail for all swap operations. This can be used to monitor and verify swap transactions.

## Immutable Rate
Once the exchange rate is set during contract deployment, it cannot be changed. This prevents any possibility of the rate being manipulated by an attacker or even the contract owner after deployment.

## Simplicity
The contract's simplicity reduces the attack surface. With fewer functions and less complex interactions, there are fewer opportunities for security vulnerabilities to arise.

Feel free to include this in your GitHub readme for a comprehensive overview of the security considerations in your Swap Contract.

