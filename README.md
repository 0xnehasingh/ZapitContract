## Prerequisites

- Basic understanding of Solidity and smart contracts
- Familiarity with the ERC-20 token standard

## Setup Instructions

### Hardhat Environment

1. **Installation**

   - Clone the repository: `git clone <repository-url>`
   - Install dependencies: `npm install`

2. **Testing**

   - Run tests: `npx hardhat test`

3. **Deploying**

   - Deploy the contract to a local Hardhat network: `npx hardhat run scripts/deploy.js --network localhost`

4. **Interacting**

   - Interact with the deployed contract using the provided scripts or custom interactions.

# Zapit Trade Contract

## Overview

The Zapit Trade Contract is a Solidity smart contract designed for facilitating decentralized trades between sellers and buyers. It allows sellers to create orders, buyers to register for these orders, and the sellers to fulfill the orders upon agreement.

## Features

1. **Order Creation**
    - Sellers can create orders by specifying the token address, amount, and whether the token is an ERC-20 token or not.

2. **Buyer Registration**
    - Buyers can register for an order by providing a message. Multiple buyers can register for the same order.

3. **Order Fulfillment**
    - Sellers can fulfill orders by confirming the buyer's message, marking the order as fulfilled, and transferring the specified amount of tokens (either ERC-20 or native) to the buyer.

4. **ERC-20 and Ether Support**
    - The contract supports both ERC-20 token transfers and Ether transfers.

## Usage

### 1. Creating an Order

   - Call the `createOrder` function, specifying the token address, amount, and whether it's an ERC-20 token.

### 2. Buyer Registration

   - Buyers can register for an order using the `registerAsBuyer` function, providing a message.

### 3. Order Fulfillment

   - Sellers can fulfill an order using the `fulfillOrder` function after verifying the buyer's message. This transfers the specified tokens to the buyer.

### 4. Viewing Order Details

   - Use `getOrderDetails` to retrieve information about a specific order, including the seller, token details, order amount, and fulfillment status.

### 5. Viewing Buyer Messages

   - Use getBuyerMessage to retrieve the message provided by a specific buyer for a particular order.


# Token Contract

## Overview

The Token Smart Contract is a Solidity implementation of the ERC-20 standard, providing a basic fungible token with the added functionality of permit-based approvals using the ERC-20 Permit extension.

## Features

1. **ERC-20 Standard**
    - The contract adheres to the ERC-20 standard, providing basic functionalities such as transfer, approve, and transferFrom.

2. **Permit Functionality**
    - Utilizes the ERC-20 Permit extension, allowing users to approve transfers via a signed message, simplifying the approval process.
