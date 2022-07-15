// SPDX-License-Identifier: GPL-3.0

//define solidity version that your contract should support
pragma solidity >=0.4.16 <0.9.0;

 //get funds
 //withdraw funds
 //set minimum funding value in usd
//import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
contract FundMe  {
    
  address public /* immutable */ i_owner;
    uint256 public constant MINIMUM_USD = 50 * 10 ** 18;
    
    constructor() {
        i_owner = msg.sender;
    }

   mapping(address => uint256) public addressToAmountFunded;
    address[] public funders;

    function fund() public payable{
        //make sure nothing less than 1 eth is sent = 1*10`18wei
        //require(msg.value > 1e18);
        //make sure nothing less than $50 is sent, how do we convert eth value to usd
        require(getConversionRate(msg.value) > minimumUsd);
        addressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);

    }
    
    function getPrice() public view returns(uint256) {
        // to interact with another contract with need ABI and Address
        //0x9326BFA02ADD2366b30bacB125260Af641031331
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x9326BFA02ADD2366b30bacB125260Af641031331);
         // 3000.00000000
         (,int256 price ,,,) = priceFeed.latestRoundData();

         //NB value in solidity is wei = 1*10`18, 
         return uint256 (price * 1e10);

     }

    function getVersion() public view returns (uint256){
         //this means have contract address and call the fucntion version.
       AggregatorV3Interface priceFeed = AggregatorV3Interface(0x9326BFA02ADD2366b30bacB125260Af641031331);
        return priceFeed.version();
    }

    function getConversionRate(uint256 ethAmount) public view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }
    //function withdraw(){}
    
}


    modifier onlyOwner {
        // require(msg.sender == owner);
        if (msg.sender != i_owner) revert NotOwner();
        _;
    }
    
    function withdraw() payable onlyOwner public {
        require(msg.sender == owner, 'sender is not owner');
        for (uint256 funderIndex=0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);

        //THREE WAYS OF SENDING NATIVE ETH
        // // transfer
        // payable(msg.sender).transfer(address(this).balance);

        // // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed");

        // call
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }
    // Explainer from: https://solidity-by-example.org/fallback/
    // Ether is sent to contract
    //      is msg.data empty?
    //          /   \ 
    //         yes  no
    //         /     \
    //    receive()?  fallback() 
    //     /   \ 
    //   yes   no
    //  /        \
    //receive()  fallback()

    fallback() external payable {
        fund();
    }

    receive() external payable {
        fund();
    }

}

// Concepts we didn't cover yet (will cover in later sections)
// 1. Enum
// 2. Events
// 3. Try / Catch
// 4. Function Selector
// 5. abi.encode / decode
// 6. Hash with keccak256
// 7. Yul / Assembly


