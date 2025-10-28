// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title Time Chain: Timestamp Authentication System for Digital Media
 * @dev A decentralized registry that timestamps and authenticates digital media on-chain.
 */
contract Project {
    struct MediaRecord {
        address creator;
        string mediaHash; // e.g., IPFS or SHA256 hash of the media
        uint256 timestamp;
    }

    mapping(string => MediaRecord) private mediaRecords;

    event MediaRegistered(address indexed creator, string mediaHash, uint256 timestamp);

    /**
     * @dev Registers a digital media file on-chain with its hash.
     * @param _mediaHash Hash of the digital media file.
     */
    function registerMedia(string memory _mediaHash) external {
        require(mediaRecords[_mediaHash].timestamp == 0, "Media already registered");
        mediaRecords[_mediaHash] = MediaRecord(msg.sender, _mediaHash, block.timestamp);
        emit MediaRegistered(msg.sender, _mediaHash, block.timestamp);
    }

    /**
     * @dev Verifies if a media file hash is registered.
     * @param _mediaHash Hash of the digital media file.
     * @return creator Address of the registrant.
     * @return timestamp Timestamp of registration.
     */
    function verifyMedia(string memory _mediaHash)
        external
        view
        returns (address creator, uint256 timestamp)
    {
        require(mediaRecords[_mediaHash].timestamp != 0, "Media not found");
        MediaRecord memory record = mediaRecords[_mediaHash];
        return (record.creator, record.timestamp);
    }

    /**
     * @dev Checks if a media hash has been registered.
     * @param _mediaHash Hash to check.
     * @return True if registered, false otherwise.
     */
    function isRegistered(string memory _mediaHash) external view returns (bool) {
        return mediaRecords[_mediaHash].timestamp != 0;
    }
}
