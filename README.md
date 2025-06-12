# ZySwitch – USSD DeFi Wallet on Celo

ZySwap enables USSD-based DeFi access on the Celo blockchain using smart contract wallets, mobile money integration, and meta-transaction relaying.

## Features
- Smart Wallet Factory (Solidity)
- Token transfers, balance checks
- USSD interface (Africa's Talking)
- PostgreSQL user storage
- Node.js relayer for gasless execution

## Getting Started

### Prerequisites
- Node.js
- PostgreSQL
- Celo wallet (private key with testnet CELO)

### Setup
```bash
git clone https://github.com/yourusername/zyswap-fullstack.git
cd zyswap-fullstack
cp .env.example .env
npm install
```

### Run Locally
```bash
psql -U postgres -f schema.sql
node backend/index.js
```

## .env Example
```env
RELAYER_PRIVATE_KEY=...
DATABASE_URL=postgres://user:pass@localhost:5432/zyswap
```

## API Endpoints
- POST `/send`
- POST `/balance`
- POST `/wallet-info`
- POST `/create-wallet`
- POST `/ussd`
