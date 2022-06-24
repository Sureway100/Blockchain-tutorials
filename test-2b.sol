// SPDX-License-Identifier: GPL-3.0

//define solidity version that your contract should support
pragma solidity >=0.4.16 <0.9.0;


//  bool hasFavNum = true;
//     uint8 FavNum = 5;
//     string FavNumString = "five";
//     address Address = 0xB18429936eF1C582c41d3867724c380195Fa113D;
//     bytes8 FavByte = "five";


contract SimpleStorage{
   uint256 public FavNum = 15;

   struct People{
       uint256 FavNum;
       string name;
   }

   People[] public user;

   mapping (uint256 => string) public userName;

   //you can also make string as key
   //mapping (string => uint256) public userName;

   function changeMind ( uint256 _FavNum) public {
       FavNum = _FavNum;
   }

   function checkStatus () public view returns(uint256){
       return FavNum;
   }

   function addPerson(string memory x , uint y) public {
       user.push(People(y,x));
       userName[y] = x;
       //userName[x] = y;
   }
}