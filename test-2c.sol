// SPDX-License-Identifier: GPL-3.0

//define solidity version that your contract should support
pragma solidity >=0.4.16 <0.9.0;

//importing contract into another
import "./test-2b.sol";

contract StorageFactory{
    SimpleStorage public simplestorage;
    function callSimpleStorage() public{
        simplestorage = new SimpleStorage();
    }

}