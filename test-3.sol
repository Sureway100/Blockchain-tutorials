// SPDX-License-Identifier: GPL-3.0

//define solidity version that your contract should support
pragma solidity >=0.4.16 <0.9.0;

import "./test-2.sol";

// if you want to make a contract inherit another and still be independent
//use this contract StorageFactory is SimpleStorage{}
contract StorageFactory {
    //array type, visibility, array name
    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        //create a new object/class of SimpleStorage, name it simpleStorage, let it be an instance of SimpleStorage()
        //and stores the new instance into array simpleStorageArray
        //for every instance created, it stores the contract address into the array
        //now we can access the contract function inside the array
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }

    function sfstore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber)
        public
    {
        //with the array index, get the contract address you want to interact with and call its store
        //function to save your fav number
        SimpleStorage simpleStorage = SimpleStorage(simpleStorageArray[_simpleStorageIndex]);

        simpleStorage.store(_simpleStorageNumber);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256) {
        //with the array index, get the contract address you want to interact with and call its store
        //function to retrieve your fav number
        SimpleStorage simpleStorage = SimpleStorage(simpleStorageArray[_simpleStorageIndex]);
        return simpleStorage.retrieve();
    }
}

