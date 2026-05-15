// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract KiiPay {

    address public owner;
    uint256 public platformFeePercent = 1;

    constructor() {
        owner = msg.sender;
    }

    struct Merchant {
        string name;
        address wallet;
        uint256 balance;
        bool registered;
    }

    mapping(address => Merchant) public merchants;

    // EVENTS
    event MerchantRegistered(address indexed merchant, string name);
    event PaymentReceived(
        address indexed from,
        address indexed merchant,
        uint256 amount
    );
    event Withdrawal(address indexed merchant, uint256 amount);
    event PlatformFeeUpdated(uint256 newFee);

    // MODIFIERS
    modifier onlyOwner() {
        require(msg.sender == owner, "Not contract owner");
        _;
    }

    modifier onlyMerchant() {
        require(
            merchants[msg.sender].registered,
            "Merchant not registered"
        );
        _;
    }

    // Register merchant
    function registerMerchant(string calldata _name) external {
        require(
            !merchants[msg.sender].registered,
            "Already registered"
        );

        merchants[msg.sender] = Merchant({
            name: _name,
            wallet: msg.sender,
            balance: 0,
            registered: true
        });

        emit MerchantRegistered(msg.sender, _name);
    }

    // Pay merchant
    function payMerchant(address _merchant) external payable {
        require(
            merchants[_merchant].registered,
            "Merchant not found"
        );

        require(msg.value > 0, "Amount must be greater than 0");

        uint256 fee = (msg.value * platformFeePercent) / 100;
        uint256 merchantAmount = msg.value - fee;

        merchants[_merchant].balance += merchantAmount;

        emit PaymentReceived(
            msg.sender,
            _merchant,
            merchantAmount
        );
    }

    // Merchant withdraws earnings
    function withdraw() external onlyMerchant {

        uint256 amount = merchants[msg.sender].balance;

        require(amount > 0, "No balance available");

        merchants[msg.sender].balance = 0;

        (bool success, ) = payable(msg.sender).call{value: amount}("");

        require(success, "Transfer failed");

        emit Withdrawal(msg.sender, amount);
    }

    // Update platform fee
    function updatePlatformFee(uint256 _newFee)
        external
        onlyOwner
    {
        require(_newFee <= 10, "Fee too high");

        platformFeePercent = _newFee;

        emit PlatformFeeUpdated(_newFee);
    }

    // Owner withdraws collected fees
    function withdrawPlatformFees()
        external
        onlyOwner
    {
        uint256 contractBalance = address(this).balance;

        require(contractBalance > 0, "No fees available");

        (bool success, ) = payable(owner).call{
            value: contractBalance
        }("");

        require(success, "Transfer failed");
    }

    // View merchant details
    function getMerchant(address _merchant)
        external
        view
        returns (
            string memory name,
            address wallet,
            uint256 balance,
            bool registered
        )
    {
        Merchant memory merchant = merchants[_merchant];

        return (
            merchant.name,
            merchant.wallet,
            merchant.balance,
            merchant.registered
        );
    }

    // View contract balance
    function getContractBalance()
        external
        view
        returns (uint256)
    {
        return address(this).balance;
    }
}
