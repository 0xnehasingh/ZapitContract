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

    function createOrder(address tokenAddress, uint256 amount, bool isERC20) external returns (uint256) {
        require(amount > 0, "Amount must be greater than 0");
        if(isERC20) {
            require(IERC20(tokenAddress).transferFrom(msg.sender, address(this), amount), "Transfer failed");
        }
        
        uint256 orderId = nextOrderId++;
        Order storage order = orders[orderId];
        order.seller = msg.sender;
        order.tokenAddress = tokenAddress;
        order.amount = amount;
        order.isERC20 = isERC20;
        order.isFulfilled = false;

        emit OrderCreated(orderId, msg.sender, tokenAddress, amount, isERC20);
        return orderId;
    }

    function registerAsBuyer(uint256 orderId, string calldata message) external {
        Order storage order = orders[orderId];
        require(!order.isFulfilled, "Order is already fulfilled");
        order.buyerMessages[msg.sender] = message;
        order.registeredBuyers.push(msg.sender);

        emit BuyerRegistered(orderId, msg.sender, message);
    }
    receive() external payable {}
}
