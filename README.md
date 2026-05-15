# KiiPay

![Solidity](https://img.shields.io/badge/Solidity-0.8.20-blue)
![Network](https://img.shields.io/badge/Network-Kii_Testnet-green)
![License](https://img.shields.io/badge/License-MIT-yellow)

A decentralized merchant payment and settlement smart contract deployed on Kii Chain testnet.

---

## Overview

KiiPay is a merchant-oriented payment infrastructure smart contract built for the Kii Chain ecosystem.

The contract allows merchants to register themselves, receive onchain payments from users, manage balances securely, and withdraw earnings transparently through a decentralized settlement mechanism.

---

## Features

- Merchant registration system
- Onchain merchant payment processing
- Secure balance management
- Merchant withdrawal functionality
- Platform fee mechanism
- Event-based transaction transparency
- Owner-controlled fee management

---

## Workflow

1. Merchant registers on the platform
2. Users send payments to registered merchants
3. Contract securely stores merchant balances
4. Platform fee is automatically deducted
5. Merchants withdraw their earnings anytime

---

## Smart Contract Functions

### Merchant Functions

- `registerMerchant()`
- `withdraw()`

### Payment Functions

- `payMerchant()`

### Admin Functions

- `updatePlatformFee()`
- `withdrawPlatformFees()`

### View Functions

- `getMerchant()`
- `getContractBalance()`

---

## Tech Stack

- Solidity ^0.8.20
- Remix IDE
- Kii Chain Testnet

---

## Contract Address

```text
0x892CD52Dd6b8DB48c8c78363D73FdA48D337e74a
```

---

## Tested Workflow

The following contract functionalities were successfully tested on Kii Chain testnet:

- Merchant registration
- Merchant payment processing
- Merchant balance tracking
- Merchant withdrawal system
- Platform fee handling
- State validation and access control

---

## Future Improvements

- Multi-merchant analytics dashboard
- Stablecoin payment support
- Recurring subscription payments
- Merchant reputation system
- Frontend dashboard integration
- Transaction history indexing

---

## License

MIT
