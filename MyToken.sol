// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts@5.0.0/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@5.0.0/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts@5.0.0/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts@5.0.0/access/Ownable.sol";

contract MyToken is ERC721, ERC721URIStorage, ERC721Burnable {

    uint256 private tokenId = 0;

    constructor()
        ERC721("Edubuk", "EDBK")
    {}
    
    mapping(address=>uint256[]) private tokenIds;

    function safeMint(address to, string[] memory uri)
        public
    {
        uint len=uri.length;
        require(to != address(0), "Invalid address");
        require(len > 0, "No URIs provided");
        for(uint i=0;i<len;i++)
        {
        tokenId++;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri[i]);
        tokenIds[to].push(tokenId);
        }
    }

    // The following functions are overrides required by Solidity.

    function tokenURI(uint256 _tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(_tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

   function getTokenIds(address user) external view returns (uint256[] memory)
   {
    return tokenIds[user] ;
   }
}
