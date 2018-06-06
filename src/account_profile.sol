pragma solidity ^0.4.24;

import "../mix-item-store/src/item_store_interface.sol";
import "../mix-item-store/src/item_store_registry.sol";


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
     * @dev ItemStoreRegistry contract.
     */
    ItemStoreRegistry itemStoreRegistry;

    /**
     * @dev An account has set its profile item.
     * @param account Account that has set its profile item.
     * @param itemId itemId of the profile.
     */
    event ProfileSet(address indexed account, bytes32 itemId);

    /**
     * @dev Constructor.
     * @param _itemStoreRegistry Address of the ItemStoreRegistry contract.
     */
    constructor(ItemStoreRegistry _itemStoreRegistry) public {
        // Store the address of the ItemStoreRegistry contract.
        itemStoreRegistry = _itemStoreRegistry;
    }

    /**
     * @dev Sets the profile for an account.
     * @param itemId itemId of the profile.
     */
    function setProfile(bytes32 itemId) external {
        // Ensure the item is owned by the sender.
        require(itemStoreRegistry.getItemStore(itemId).getOwner(itemId) == msg.sender);
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
