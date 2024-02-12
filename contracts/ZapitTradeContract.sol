// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ZapitTradeContract {
    struct Order {
        address seller;
        address tokenAddress;
        uint256 amount;
        bool isERC20;
        bool isFulfilled;
        mapping(address => string) buyerMessages; // Changed from bytes32 to string
        address[] registeredBuyers;
    }

    mapping(uint256 => Order) private orders;
    uint256 private nextOrderId;

    event OrderCreated(uint256 orderId, address indexed seller, address indexed tokenAddress, uint256 amount, bool isERC20);
    event BuyerRegistered(uint256 orderId, address indexed buyer, string message); // Changed from bytes32 to string
    event OrderFulfilled(uint256 orderId, address indexed buyer, string message); // Changed from bytes32 to string

    modifier onlySeller(uint256 orderId) {
        require(msg.sender == orders[orderId].seller, "Caller is not the seller of the order");
        _;
    }

    receive() external payable {}
}
