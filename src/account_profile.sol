pragma solidity ^0.4.24;


/**
 * @title AccountProfile
 * @author Jonathan Brown <jbrown@mix-blockchain.org>
 * @dev Smart contract for each account to associate itself with a profile item.
 */
contract AccountProfile {

    /**
     * @dev Mapping of account to profile item.
     */
    mapping(address => bytes32) accountProfile;

    /**
     * @dev An account has set its profile item.
     * @param account Account that has set its profile item.
     * @param itemId itemId of the profile.
     */
    event ProfileSet(address indexed account, bytes32 itemId);

    /**
     * @dev Sets the profile for an account.
     * @param itemId itemId of the profile.
     */
    function setProfile(bytes32 itemId) external {
        // Store the itemId for the sender.
        accountProfile[msg.sender] = itemId;
        // Log the event.
        emit ProfileSet(msg.sender, itemId);
    }

    /**
     * @dev Gets the profile for an account.
     * @param account Account to get the profile for.
     */
    function getProfile(address account) external view returns (bytes32) {
        return accountProfile[account];
    }

}
