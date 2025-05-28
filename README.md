# NFT Marketplace with Royalties

## Project Description

The NFT Marketplace with Royalties is a comprehensive decentralized application built on Ethereum that enables users to mint, buy, and sell Non-Fungible Tokens (NFTs) while ensuring creators receive automatic royalty payments on secondary sales. This smart contract combines the functionality of an NFT collection with a fully-featured marketplace, providing a seamless experience for both creators and collectors.

The platform implements the ERC-721 standard for NFTs and includes advanced features such as automatic royalty distribution, secure payment handling, and comprehensive marketplace functionality. Every time an NFT is resold, the original creator automatically receives a predetermined percentage of the sale price, ensuring ongoing compensation for their creative work.

## Project Vision

Our vision is to create a fair and sustainable ecosystem for digital creators and collectors by building a transparent, secure, and user-friendly NFT marketplace. We aim to bridge the gap between artists and collectors while ensuring that creators are fairly compensated for their work throughout the entire lifecycle of their digital assets.

By implementing automatic royalty distribution and providing a decentralized marketplace, we envision a future where digital creativity is properly valued and creators can build sustainable income streams from their work. Our platform promotes transparency, security, and fairness in the NFT space.

## Key Features

### 🎨 **NFT Minting with Royalties**
- Create and mint unique NFTs with custom metadata
- Set royalty percentages (up to 10%) for automatic creator compensation
- Secure and gas-efficient minting process
- Support for any metadata format (images, videos, audio, etc.)

### 💰 **Automatic Royalty Distribution**
- Automatic calculation and distribution of royalties on secondary sales
- Transparent royalty tracking and payment system
- Configurable royalty percentages during minting
- Real-time royalty payment notifications

### 🛒 **Comprehensive Marketplace**
- List NFTs for sale with custom pricing
- Secure purchase mechanism with escrow functionality
- Browse all available NFTs in the marketplace
- View personal NFT collections and created items

### 🔒 **Security Features**
- ReentrancyGuard protection against reentrancy attacks
- Secure payment handling with automatic fund distribution
- Access control for administrative functions
- Input validation and error handling

### 📊 **Marketplace Analytics**
- Track total items sold and marketplace activity
- View personal NFT portfolios
- Monitor created vs. owned NFTs
- Transparent transaction history

### ⚙️ **Administrative Controls**
- Configurable listing fees for marketplace sustainability
- Owner-only functions for platform management
- Flexible royalty system supporting various business models

## Future Scope

### 🔮 **Phase 1: Enhanced Marketplace Features**
- **Auction System**: Implement English and Dutch auction mechanisms
- **Offer System**: Allow users to make offers on unlisted NFTs
- **Bundle Sales**: Enable selling multiple NFTs as collections
- **Advanced Filtering**: Add search and filter capabilities by price, creator, and category

### 🌐 **Phase 2: Cross-Chain Integration**
- **Multi-Chain Support**: Deploy on Polygon, BSC, and other EVM-compatible chains
- **Bridge Functionality**: Enable cross-chain NFT transfers
- **Gas Optimization**: Implement Layer 2 solutions for reduced transaction costs

### 🤝 **Phase 3: Social and Community Features**
- **Creator Profiles**: Enhanced creator pages with portfolio showcases
- **Social Features**: Following, commenting, and rating systems
- **Community Governance**: DAO-based platform governance with voting mechanisms
- **Creator Verification**: Verification system for authentic creators

### 💡 **Phase 4: Advanced Functionality**
- **Fractional Ownership**: Enable fractional NFT ownership and trading
- **Rental System**: Implement NFT rental and lending mechanisms
- **AI Integration**: AI-powered NFT valuation and recommendation system
- **Analytics Dashboard**: Comprehensive analytics for creators and collectors

### 🔄 **Phase 5: DeFi Integration**
- **NFT Staking**: Stake NFTs to earn platform tokens
- **Liquidity Pools**: NFT-backed liquidity provision
- **Insurance**: NFT insurance against theft and fraud
- **Yield Farming**: Rewards for active marketplace participants

### 📱 **Phase 6: Mobile and Accessibility**
- **Mobile DApp**: Native mobile application for iOS and Android
- **Wallet Integration**: Support for major wallet providers
- **Gasless Transactions**: Meta-transaction support for improved UX
- **Accessibility**: Enhanced accessibility features for users with disabilities


---

## Installation and Setup

### Prerequisites
- Node.js (v14 or higher)
- Hardhat or Truffle development environment
- MetaMask or compatible Web3 wallet

### Installation Steps
1. Clone the repository
2. Install dependencies: `npm install`
3. Configure network settings in `hardhat.config.js`
4. Deploy the contract: `npx hardhat run scripts/deploy.js`
5. Verify the contract on Etherscan (optional)

### Usage
1. Connect your Web3 wallet to the DApp
2. Mint NFTs by providing metadata URI and setting royalty parameters
3. List NFTs for sale in the marketplace
4. Browse and purchase NFTs from other creators
5. Receive automatic royalty payments on secondary sales

---

## Contract Architecture

### Core Functions
- **createToken()**: Mint NFTs with royalty configuration
- **createMarketSale()**: Purchase NFTs with automatic royalty distribution
- **fetchMarketItems()**: Retrieve all available marketplace items

### Smart Contract Features
- ERC-721 compliance for NFT standards
- Reentrancy protection for secure transactions
- Ownable pattern for administrative controls
- Event logging for transparent transaction tracking

---

*Built with ❤️ for the creator economy*


## Contract Address: 0x86F7A781215339Acf6c79543771225f2bFcbD836
![image](https://github.com/user-attachments/assets/00839870-a0a4-446c-9e15-d1e941bd8f74)
