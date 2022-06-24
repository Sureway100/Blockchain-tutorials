// SPDX-License-Identifier: GPL-3.0

//define solidity version that your contract should support
pragma solidity >=0.4.16 <0.9.0;

contract SimpleStorage {
    //this will get initialized to 0
    uint256 public favoriteNumber;
    bool favoriteBool;

    //create an object
    struct People {
        uint256 favoriteNumber;
        string name;
    }

    //create an array..define array type, visibility and name of array
    People[] public people;

    mapping(string => uint256) public nameToFavoriteNumber;

//and virtual keyword into the inherited file function if it will
//be altered by an inheriting file
    function store(uint256 _favoriteNumber) public virtual{
        favoriteNumber = _favoriteNumber;
    }

    function retrieve() public view returns (uint256) {
        return favoriteNumber;
    }

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        people.push(People(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}
