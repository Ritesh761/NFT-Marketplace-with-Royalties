// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

/**
 * @title NFT Marketplace with Royalties
 * @dev A comprehensive NFT marketplace that supports minting, trading, and automatic royalty distribution
 */
contract Project is ERC721URIStorage, Ownable, ReentrancyGuard {
    using Counters for Counters.Counter;
    
    Counters.Counter private _tokenIds;
    Counters.Counter private _itemsSold;
    
    uint256 public listingPrice = 0.025 ether;
    
    struct MarketItem {
        uint256 tokenId;
        address payable seller;
        address payable owner;
        uint256 price;
        bool sold;
    }
    
    struct RoyaltyInfo {
        address recipient;
        uint256 percentage; // Basis points (e.g., 250 = 2.5%)
    }
    
    mapping(uint256 => MarketItem) private idToMarketItem;
    mapping(uint256 => RoyaltyInfo) private tokenRoyalties;
    
    event MarketItemCreated(
        uint256 indexed tokenId,
        address seller,
        address owner,
        uint256 price,
        bool sold
    );
    
    event MarketItemSold(
        uint256 indexed tokenId,
        address seller,
        address buyer,
        uint256 price
    );
    
    event RoyaltyPaid(
        uint256 indexed tokenId,
        address recipient,
        uint256 amount
    );
    
    constructor() ERC721("NFT Marketplace", "NFTMP") Ownable(msg.sender) {}
    
    /**
     * @dev Core Function 1: Create and mint NFT with royalty information
     * @param tokenURI The metadata URI for the NFT
     * @param price The listing price for the NFT
     * @param royaltyRecipient The address that will receive royalties
     * @param royaltyPercentage The royalty percentage in basis points (e.g., 250 = 2.5%)
     */
    function createToken(
        string memory tokenURI,
        uint256 price,
        address royaltyRecipient,
        uint256 royaltyPercentage
    ) public payable nonReentrant {
        require(price > 0, "Price must be greater than 0");
        require(royaltyPercentage <= 1000, "Royalty cannot exceed 10%");
        require(msg.value == listingPrice, "Price must be equal to listing price");
        
        _tokenIds.increment();
        uint256 newTokenId = _tokenIds.current();
        
        _mint(msg.sender, newTokenId);
        _setTokenURI(newTokenId, tokenURI);
        
        // Set royalty information
        tokenRoyalties[newTokenId] = RoyaltyInfo(royaltyRecipient, royaltyPercentage);
        
        createMarketItem(newTokenId, price);
    }
    
    /**
     * @dev Core Function 2: Purchase NFT with automatic royalty distribution
     * @param tokenId The ID of the NFT to purchase
     */
    function createMarketSale(uint256 tokenId) public payable nonReentrant {
        uint256 price = idToMarketItem[tokenId].price;
        address seller = idToMarketItem[tokenId].seller;
        
        require(msg.value == price, "Please submit the asking price");
        require(idToMarketItem[tokenId].sold == false, "Item already sold");
        
        // Calculate and distribute royalty
        RoyaltyInfo memory royalty = tokenRoyalties[tokenId];
        uint256 royaltyAmount = 0;
        
        if (royalty.recipient != address(0) && royalty.recipient != seller) {
            royaltyAmount = (price * royalty.percentage) / 10000;
            payable(royalty.recipient).transfer(royaltyAmount);
            
            emit RoyaltyPaid(tokenId, royalty.recipient, royaltyAmount);
        }
        
        // Transfer remaining amount to seller
        uint256 sellerAmount = price - royaltyAmount;
        payable(seller).transfer(sellerAmount);
        
        // Transfer NFT to buyer
        _transfer(seller, msg.sender, tokenId);
        
        // Update market item
        idToMarketItem[tokenId].owner = payable(msg.sender);
        idToMarketItem[tokenId].sold = true;
        _itemsSold.increment();
        
        // Transfer listing fee to contract owner
        payable(owner()).transfer(listingPrice);
        
        emit MarketItemSold(tokenId, seller, msg.sender, price);
    }
    
    /**
     * @dev Core Function 3: Fetch all available market items for sale
     * @return Array of unsold market items
     */
    function fetchMarketItems() public view returns (MarketItem[] memory) {
        uint256 itemCount = _tokenIds.current();
        uint256 unsoldItemCount = _tokenIds.current() - _itemsSold.current();
        uint256 currentIndex = 0;
        
        MarketItem[] memory items = new MarketItem[](unsoldItemCount);
        
        for (uint256 i = 0; i < itemCount; i++) {
            if (idToMarketItem[i + 1].owner == address(this)) {
                uint256 currentId = i + 1;
                MarketItem storage currentItem = idToMarketItem[currentId];
                items[currentIndex] = currentItem;
                currentIndex += 1;
            }
        }
        
        return items;
    }
    
    /**
     * @dev Internal function to create a market item
     */
    function createMarketItem(uint256 tokenId, uint256 price) private {
        idToMarketItem[tokenId] = MarketItem(
            tokenId,
            payable(msg.sender),
            payable(address(this)),
            price,
            false
        );
        
        _transfer(msg.sender, address(this), tokenId);
        
        emit MarketItemCreated(
            tokenId,
            msg.sender,
            address(this),
            price,
            false
        );
    }
    
    /**
     * @dev Get royalty information for a token
     */
    function getRoyaltyInfo(uint256 tokenId) public view returns (address, uint256) {
        RoyaltyInfo memory royalty = tokenRoyalties[tokenId];
        return (royalty.recipient, royalty.percentage);
    }
    
    /**
     * @dev Update listing price (only owner)
     */
    function updateListingPrice(uint256 _listingPrice) public onlyOwner {
        listingPrice = _listingPrice;
    }
    
    /**
     * @dev Get the listing price
     */
    function getListingPrice() public view returns (uint256) {
        return listingPrice;
    }
    
    /**
     * @dev Fetch NFTs owned by the caller
     */
    function fetchMyNFTs() public view returns (MarketItem[] memory) {
        uint256 totalItemCount = _tokenIds.current();
        uint256 itemCount = 0;
        uint256 currentIndex = 0;
        
        for (uint256 i = 0; i < totalItemCount; i++) {
            if (idToMarketItem[i + 1].owner == msg.sender) {
                itemCount += 1;
            }
        }
        
        MarketItem[] memory items = new MarketItem[](itemCount);
        for (uint256 i = 0; i < totalItemCount; i++) {
            if (idToMarketItem[i + 1].owner == msg.sender) {
                uint256 currentId = i + 1;
                MarketItem storage currentItem = idToMarketItem[currentId];
                items[currentIndex] = currentItem;
                currentIndex += 1;
            }
        }
        
        return items;
    }
    
    /**
     * @dev Fetch NFTs created by the caller
     */
    function fetchItemsCreated() public view returns (MarketItem[] memory) {
        uint256 totalItemCount = _tokenIds.current();
        uint256 itemCount = 0;
        uint256 currentIndex = 0;
        
        for (uint256 i = 0; i < totalItemCount; i++) {
            if (idToMarketItem[i + 1].seller == msg.sender) {
                itemCount += 1;
            }
        }
        
        MarketItem[] memory items = new MarketItem[](itemCount);
        for (uint256 i = 0; i < totalItemCount; i++) {
            if (idToMarketItem[i + 1].seller == msg.sender) {
                uint256 currentId = i + 1;
                MarketItem storage currentItem = idToMarketItem[currentId];
                items[currentIndex] = currentItem;
                currentIndex += 1;
            }
        }
        
        return items;
    }
}
