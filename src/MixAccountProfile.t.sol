pragma solidity ^0.5.10;

import "ds-test/test.sol";

import "./MixAccountProfile.sol";

import "mix-item-store/ItemStoreRegistry.sol";
import "mix-item-store/ItemStoreIpfsSha256.sol";
import "mix-item-store/ItemStoreIpfsSha256Proxy.sol";


contract MixAccountProfileTest is DSTest {

    ItemStoreRegistry itemStoreRegistry;
    ItemStoreIpfsSha256 itemStoreIpfsSha256;
    ItemStoreIpfsSha256Proxy itemStoreIpfsSha256Proxy;
    MixAccountProfile mixAccountProfile;

    function setUp() public {
        itemStoreRegistry = new ItemStoreRegistry();
        itemStoreIpfsSha256 = new ItemStoreIpfsSha256(itemStoreRegistry);
        itemStoreIpfsSha256Proxy = new ItemStoreIpfsSha256Proxy(itemStoreIpfsSha256);
        mixAccountProfile = new MixAccountProfile(itemStoreRegistry);
    }

    function testControlSetProfileNotOwner() public {
      bytes32 itemId = itemStoreIpfsSha256.create(bytes2(0x0001), hex"1234");
      mixAccountProfile.setProfile(itemId);
    }

    function testFailSetProfileNotOwner() public {
      bytes32 itemId = itemStoreIpfsSha256Proxy.create(bytes2(0x0001), hex"1234");
      mixAccountProfile.setProfile(itemId);
    }

    function testControlGetProfileNoProfile() public {
      bytes32 itemId = itemStoreIpfsSha256.create(bytes2(0x0001), hex"1234");
      mixAccountProfile.setProfile(itemId);
      mixAccountProfile.getProfile();
    }

    function testFailGetProfileNoProfile() public view {
      mixAccountProfile.getProfile();
    }

    function testSetProfile() public {
      bytes32 itemId = itemStoreIpfsSha256.create(bytes2(0x0001), hex"1234");
      mixAccountProfile.setProfile(itemId);
      assertEq(mixAccountProfile.getProfile(), itemId);

      itemId = itemStoreIpfsSha256.create(bytes2(0x0002), hex"1234");
      mixAccountProfile.setProfile(itemId);
      assertEq(mixAccountProfile.getProfile(), itemId);

      itemId = itemStoreIpfsSha256.create(bytes2(0x0003), hex"1234");
      mixAccountProfile.setProfile(itemId);
      assertEq(mixAccountProfile.getProfile(), itemId);

      itemId = itemStoreIpfsSha256.create(bytes2(0x0004), hex"1234");
      mixAccountProfile.setProfile(itemId);
      assertEq(mixAccountProfile.getProfile(), itemId);
    }

    function testControlGetProfileByAccountNoProfile() public {
      bytes32 itemId = itemStoreIpfsSha256.create(bytes2(0x0001), hex"1234");
      mixAccountProfile.setProfile(itemId);
      mixAccountProfile.getProfileByAccount(address(this));
    }

    function testFailGetProfileByAccountNoProfile() public view {
      mixAccountProfile.getProfileByAccount(address(this));
    }

    function testSetProfileByAccount() public {
      bytes32 itemId = itemStoreIpfsSha256.create(bytes2(0x0001), hex"1234");
      mixAccountProfile.setProfile(itemId);
      assertEq(mixAccountProfile.getProfileByAccount(address(this)), itemId);

      itemId = itemStoreIpfsSha256.create(bytes2(0x0002), hex"1234");
      mixAccountProfile.setProfile(itemId);
      assertEq(mixAccountProfile.getProfileByAccount(address(this)), itemId);

      itemId = itemStoreIpfsSha256.create(bytes2(0x0003), hex"1234");
      mixAccountProfile.setProfile(itemId);
      assertEq(mixAccountProfile.getProfileByAccount(address(this)), itemId);

      itemId = itemStoreIpfsSha256.create(bytes2(0x0004), hex"1234");
      mixAccountProfile.setProfile(itemId);
      assertEq(mixAccountProfile.getProfileByAccount(address(this)), itemId);
    }

}
