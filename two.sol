//lets interact with contract from another contract (SimpleStorage)
//SPDX-license-Identifier: MIT

pragma solidity ^0.6.0;

import "./SimpleStorage.sol";

// if you want to make a contract inherit another and still be independent
//use this contract StorageFactory is SimpleStorage{}
contract StorageFactory {
    //array type, visibility, array name
    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        //create a new object/class of SimpleStorage, name it simpleStorage, let it be an instance of SimpleStorage()
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }

    function sfstore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber)
        public
    {
        //if you want to interact with a contract, you need two things, the address  and the ABI
        //adress can be gotten from the simpleStorageArray with indexed
        //ABI -> application binary interface from the import
        SimpleStorage simpleStorage = SimpleStorage(
            address(simpleStorageArray[_simpleStorageIndex])
        );

        simpleStorage.store(_simpleStorageNumber);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256) {
        SimpleStorage simpleStorage = SimpleStorage(
            address(simpleStorageArray[_simpleStorageIndex])
        );
        return simpleStorage.retrieve();
    }
}
