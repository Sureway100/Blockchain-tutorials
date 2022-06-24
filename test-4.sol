// SPDX-License-Identifier: GPL-3.0

//define solidity version that your contract should support
pragma solidity >=0.4.16 <0.9.0;

import "./test-2.sol";
//this is about teaching inheritance and overrides
contract ExtraStorage is SimpleStorage {
//lets say we want to add small features to our simplestorage store function...
//we need to add into the function override keyword to the inheriting file 
//and virtual keyword into the inherited file function.
     function store(uint256 _favoriteNumber) public  override {
        favoriteNumber = _favoriteNumber + 5;
    }

}