pragma solidity ^0.4.24;

import "ds-test/test.sol";

import "./account_profile.sol";


/**
 * @title AccountProfileTest
 * @author Jonathan Brown <jbrown@mix-blockchain.org>
 * @dev Testing contract for AccountProfile.
 */
contract AccountProfileTest is DSTest {

    AccountProfile accountProfile;

    function setUp() public {
        accountProfile = new AccountProfile();
    }

    function testSetProfile() public {
      assertEq(accountProfile.getProfile(this), 0);
      accountProfile.setProfile(0x1234);
      assertEq(accountProfile.getProfile(this), 0x1234);
      accountProfile.setProfile(0x2345);
      assertEq(accountProfile.getProfile(this), 0x2345);
      accountProfile.setProfile(0x3456);
      assertEq(accountProfile.getProfile(this), 0x3456);
      accountProfile.setProfile(0x4567);
      assertEq(accountProfile.getProfile(this), 0x4567);
    }

}
