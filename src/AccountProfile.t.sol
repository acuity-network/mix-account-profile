pragma solidity ^0.5.10;

import "ds-test/test.sol";

import "./AccountProfile.sol";

import "mix-item-store/ItemStoreRegistry.sol";
import "mix-item-store/ItemStoreIpfsSha256.sol";
import "mix-item-store/ItemStoreIpfsSha256Proxy.sol";


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
      bytes32 itemId = itemStore.create(bytes2(0x0001), hex"1234");
      accountProfile.setProfile(itemId);
    }

    function testFailSetProfileNotOwner() public {
      bytes32 itemId = itemStoreProxy.create(bytes2(0x0001), hex"1234");
      accountProfile.setProfile(itemId);
    }

    function testControlGetProfileNoProfile() public {
      bytes32 itemId = itemStore.create(bytes2(0x0001), hex"1234");
      accountProfile.setProfile(itemId);
      accountProfile.getProfile();
    }

    function testFailGetProfileNoProfile() public view {
      accountProfile.getProfile();
    }

    function testSetProfile() public {
      bytes32 itemId = itemStore.create(bytes2(0x0001), hex"1234");
      accountProfile.setProfile(itemId);
      assertEq(accountProfile.getProfile(), itemId);

      itemId = itemStore.create(bytes2(0x0002), hex"1234");
      accountProfile.setProfile(itemId);
      assertEq(accountProfile.getProfile(), itemId);

      itemId = itemStore.create(bytes2(0x0003), hex"1234");
      accountProfile.setProfile(itemId);
      assertEq(accountProfile.getProfile(), itemId);

      itemId = itemStore.create(bytes2(0x0004), hex"1234");
      accountProfile.setProfile(itemId);
      assertEq(accountProfile.getProfile(), itemId);
    }

    function testControlGetProfileByAccountNoProfile() public {
      bytes32 itemId = itemStore.create(bytes2(0x0001), hex"1234");
      accountProfile.setProfile(itemId);
      accountProfile.getProfileByAccount(address(this));
    }

    function testFailGetProfileByAccountNoProfile() public view {
      accountProfile.getProfileByAccount(address(this));
    }

    function testSetProfileByAccount() public {
      bytes32 itemId = itemStore.create(bytes2(0x0001), hex"1234");
      accountProfile.setProfile(itemId);
      assertEq(accountProfile.getProfileByAccount(address(this)), itemId);

      itemId = itemStore.create(bytes2(0x0002), hex"1234");
      accountProfile.setProfile(itemId);
      assertEq(accountProfile.getProfileByAccount(address(this)), itemId);

      itemId = itemStore.create(bytes2(0x0003), hex"1234");
      accountProfile.setProfile(itemId);
      assertEq(accountProfile.getProfileByAccount(address(this)), itemId);

      itemId = itemStore.create(bytes2(0x0004), hex"1234");
      accountProfile.setProfile(itemId);
      assertEq(accountProfile.getProfileByAccount(address(this)), itemId);
    }

}