// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";


contract VirtualLandNFT is ERC721, Ownable {
    using SafeMath for uint256;


    uint256 private nextLandId;


    mapping(uint256 => LandDetails) public landDetails;


    struct LandDetails {
        string location;
        string description;
    }


    event LandMinted(uint256 tokenId, address owner, string location, string description);

    constructor() ERC721("VirtualLandNFT", "VLTNFT") {
        nextLandId = 1;
    }

    function mintLand(string memory _location, string memory _description) external onlyOwner {
        uint256 tokenId = nextLandId;
        _safeMint(msg.sender, tokenId);

        
        landDetails[tokenId] = LandDetails({
            location: _location,
            description: _description
        });

        
        emit LandMinted(tokenId, msg.sender, _location, _description);


        nextLandId = nextLandId.add(1);
    }

    function getLandDetails(uint256 _tokenId) external view returns (string memory location, string memory description) {
        LandDetails memory details = landDetails[_tokenId];
        return (details.location, details.description);
    }
}
