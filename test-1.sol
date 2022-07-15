// SPDX-License-Identifier: GPL-3.0

//define solidity version that your contract should support
pragma solidity >=0.4.16 <0.9.0;


//my contract TestBase starts here
contract TestBase {

    //this unsigned integer variable is private by default and permanently stores the storedDate on the block
    uint storedData;

    //function helps to update the value of the storedData on the blockcahin and will use more gas
    // because it is making a change to the state of the blockchain
    function set(uint x) public {
        storedData = x;
    }

    //function helps to just read value and disallows any modifications because of the view function there.
    //if pure was written,this helps to prevent reading and modification 
    function get() public view returns (uint) {
        return storedData;
    }
}

