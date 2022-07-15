// you know with remix, we just click on our deploy button
//but using javascript, will teach us what happens behind the sane.
//http://127.0.0.1:7545
//SimpleStorage_sol_SimpleStorage.bin
//SimpleStorage_sol_SimpleStorage.abi
const ethers = require("ethers");
const fs = require("fs-extra");

async function main() {
  //hey lets connect to this RPC url fake blockchain, in our case ganache
  const provider = new ethers.providers.JsonRpcProvider(
    "http://127.0.0.1:7545"
  );

  //lets get the primary key for the blockchain we are connecting to
  const wallet = new ethers.Wallet(
    "85a912220dfb17ebf840e6db8a9a74f20af495dffa85a5c93bfecade13360c99",
    provider
  );

  //now lets read those compiled files
  const abi = fs.readFileSync("./SimpleStorage_sol_SimpleStorage.abi", "utf8");
  const binary = fs.readFileSync(
    "./SimpleStorage_sol_SimpleStorage.bin",
    "utf8"
  );

  //lets call those defined values
  const contractFactory = new ethers.ContractFactory(abi, binary, wallet);
  console.log("deploying, pleas wait...");

  //stop here, wait for contract to be deployed and promise returned
  const contract = await contractFactory.deploy();

  console.log(contract);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
