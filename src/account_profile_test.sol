pragma solidity ^0.4.24;

import "ds-test/test.sol";

import "./account_profile.sol";

import "../mix-item-store/src/item_store_registry.sol";
import "../mix-item-store/src/item_store_ipfs_sha256.sol";
import "../mix-item-store/src/item_store_ipfs_sha256_proxy.sol";


/**
 * @title AccountProfileTest
 * @author Jonathan Brown <jbrown@mix-blockchain.org>
 * @dev Testing contract for AccountProfile.
 */
contract AccountProfileTest is DSTest {

    ItemStoreRegistry itemStoreRegistry;
    ItemStoreIpfsSha256 itemStore;
    ItemStoreIpfsSha256Proxy itemStoreProxy;
    AccountProfile accountProfile;

    function setUp() public {
        itemStoreRegistry = new ItemStoreRegistry();
        itemStore = new ItemStoreIpfsSha256(itemStoreRegistry);
        itemStoreProxy = new ItemStoreIpfsSha256Proxy(itemStore);
        accountProfile = new AccountProfile(itemStoreRegistry);
    }

    function testControlSetProfileNotOwner() public {
      bytes32 itemId = itemStore.create(bytes2(0x0001), 0x1234);
      accountProfile.setProfile(itemId);
    }

    function testFailSetProfileNotOwner() public {
      bytes32 itemId = itemStoreProxy.create(bytes2(0x0001), 0x1234);
      accountProfile.setProfile(itemId);
    }

    function testControlGetProfileNoProfile() public {
      bytes32 itemId = itemStore.create(bytes2(0x0001), 0x1234);
      accountProfile.setProfile(itemId);
      accountProfile.getProfile(this);
    }

    function testFailGetProfileNoProfile() public view {
      accountProfile.getProfile(this);
    }

    function testSetProfile() public {
      bytes32 itemId = itemStore.create(bytes2(0x0001), 0x1234);
      accountProfile.setProfile(itemId);
      assertEq(accountProfile.getProfile(this), itemId);

      itemId = itemStore.create(bytes2(0x0002), 0x1234);
      accountProfile.setProfile(itemId);
      assertEq(accountProfile.getProfile(this), itemId);

      itemId = itemStore.create(bytes2(0x0003), 0x1234);
      accountProfile.setProfile(itemId);
      assertEq(accountProfile.getProfile(this), itemId);

      itemId = itemStore.create(bytes2(0x0004), 0x1234);
      accountProfile.setProfile(itemId);
      assertEq(accountProfile.getProfile(this), itemId);
    }

}
