#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/common.sh) && printlogo
#-----------------------------------------------------------------------------------------#

#-------------------------------------Основное меню---------------------------------------#
	mainmenu() {
		echo "$(printBCyan '            -->') $(printBCyan    '1) Создать смартконтракт')"
		echo "$(printBCyan '            -->') $(printBCyan    '2) Сделать деплой контракта')"
		echo "$(printBCyan '            -->') $(printBGreen   '3) Обновить закрытый ключ Metamask')"
		echo
		echo "$(printBCyan '            -->') $(printBRed     '4) Удалить')"
		echo 
		echo "$(printBBlue '            <-- 5) Назад')"
    echo
		echo "$(printBRed        '                0) Выход')" 
	

	#-------------------------Свойства меню-------------------------#
		read -r ans
			case $ans in
		#---------------------------------------#
			1)
			createSmart
			;;
		#---------------------------------------#
			2)
			deploy
			;;
		#---------------------------------------#
			3)
			updateSmart
			;;
		#---------------------------------------#
			4)
			delet
			;;
		#---------------------------------------#	
			5)
			back
			;;
		#---------------------------------------#
			0)
			echo $(printBCyan '	"Bye bye."')
			exit
			;;
		#---------------------------------------#	
			*)
			clear && printlogo && printzcsync
			echo
			echo
			echo    -ne "$(printBRed '		   Неверный запрос !')"
			echo
			mainmenu
			;;
		#---------------------------------------#
			esac
}


updateSmart(){
	clear && printlogo && printZcsync
	echo
	rm -rf \$HOME/greeter-example/artifacts-zk && rm -rf \$HOME/greeter-example/cache-zk
	cd $HOME/greeter-example/greeter/deploy/ && rm deploy.ts
read -r -p "  Введите закрытый ключ Metamask: " VAR1

cat << EOF  > $HOME/greeter-example/greeter/deploy/deploy.ts
import { Wallet, utils } from "zksync-web3";
import * as ethers from "ethers";
import { HardhatRuntimeEnvironment } from "hardhat/types";
import { Deployer } from "@matterlabs/hardhat-zksync-deploy";

// An example of a deploy script that will deploy and call a simple contract.
export default async function (hre: HardhatRuntimeEnvironment) {
  console.log(`Running deploy script for the Greeter contract`);

  // Initialize the wallet.
  const wallet = new Wallet("$VAR1");

  // Create deployer object and load the artifact of the contract you want to deploy.
  const deployer = new Deployer(hre, wallet);
  const artifact = await deployer.loadArtifact("Greeter");

  // Estimate contract deployment fee
  const greeting = "Hi there!";
  const deploymentFee = await deployer.estimateDeployFee(artifact, [greeting]);

  // OPTIONAL: Deposit funds to L2
  // Comment this block if you already have funds on zkSync.
  const depositHandle = await deployer.zkWallet.deposit({
    to: deployer.zkWallet.address,
    token: utils.ETH_ADDRESS,
    amount: deploymentFee.mul(2),
  });
  // Wait until the deposit is processed on zkSync
  await depositHandle.wait();

  // Deploy this contract. The returned object will be of a `Contract` type, similarly to ones in `ethers`.
  // `greeting` is an argument for contract constructor.
  const parsedFee = ethers.utils.formatEther(deploymentFee.toString());
  console.log(`The deployment is estimated to cost ${parsedFee} ETH`);

  const greeterContract = await deployer.deploy(artifact, [greeting]);

  //obtain the Constructor Arguments
  console.log("constructor args:" + greeterContract.interface.encodeDeploy([greeting]));

  // Show the contract info.
  const contractAddress = greeterContract.address;
  console.log(`${artifact.contractName} was deployed to ${contractAddress}`);

  // Verify contract programmatically 
  //
  // Contract MUST be fully qualified name (e.g. path/sourceName:contractName)
  const contractFullyQualifedName = "contracts/Greeter.sol:Greeter";
  const verificationId = await hre.run("verify:verify", {
    address: contractAddress,
    contract: contractFullyQualifedName,
    constructorArguments: [greeting],
    bytecode: artifact.bytecode,
  });
  console.log(`${contractFullyQualifedName} verified! VerificationId: ${verificationId}`)
}
EOF
}
deploy(){
	clear && printlogo && printZcsync
	echo
	echo 
	cd $HOME/greeter-example/greeter/deploy/
	npx hardhat deploy-zksync
	cd $HOME
	echo
	mainmenu
}

back(){
 source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/menu/menusmart.sh)
}

delet(){
	clear && printlogo && printZcsync
		echo
		rm -rf $HOME/greeter-example
		echo
		echo -ne "		$(printBRed	'	  zcSync удален!')"
		echo
		mainmenu
}

createSmart(){
		echo && cd $HOME && sudo apt update && sudo apt upgrade -y && sudo apt install curl nodejs cmdtest nano -y
		curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
		mkdir $HOME/greeter-example && cd greeter-example
		npm init --y && npm install --save-dev hardhat && npm install -g npm@9.6.0 && npx hardhat
		mkdir $HOME/greeter-example/greeter && cd $HOME/greeter-example/greeter
		npm add -D typescript ts-node ethers@^5.7.2 zksync-web3 hardhat @matterlabs/hardhat-zksync-solc @matterlabs/hardhat-zksync-deploy @matterlabs/hardhat-zksync-verify @nomiclabs/hardhat-etherscan


cat << EOF  > $HOME/greeter-example/greeter/hardhat.config.ts
import "@matterlabs/hardhat-zksync-deploy";
import "@matterlabs/hardhat-zksync-solc";
import "@matterlabs/hardhat-zksync-verify";

module.exports = {
  zksolc: {
    version: "1.3.10",
    compilerSource: "binary",
    settings: {},
  },
  defaultNetwork: "zkSyncTestnet",

  networks: {
    zkSyncTestnet: {
      url: "https://testnet.era.zksync.dev",
      ethNetwork: "goerli", // RPC URL of the network (e.g. `https://goerli.infura.io/v3/<API_KEY>`)
      zksync: true,
      verifyURL: 'https://zksync2-testnet-explorer.zksync.dev/contract_verification'  // Verification endpoint
    },
  },
  solidity: {
    version: "0.8.8",
  },
};

EOF

mkdir $HOME/greeter-example/greeter/contracts && mkdir $HOME/greeter-example/greeter/deploy

cat << EOF  > $HOME/greeter-example/greeter/contracts/Greeter.sol
//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.8;

contract Greeter {
    string private greeting;

    constructor(string memory _greeting) {
        greeting = _greeting;
    }

    function greet() public view returns (string memory) {
        return greeting;
    }

    function setGreeting(string memory _greeting) public {
        greeting = _greeting;
    }
}

EOF

npx hardhat compile

read -r -p "  Введите закрытый ключ Metamask: " VAR1

cat << EOF  > $HOME/greeter-example/greeter/deploy/deploy.ts
import { Wallet, utils } from "zksync-web3";
import * as ethers from "ethers";
import { HardhatRuntimeEnvironment } from "hardhat/types";
import { Deployer } from "@matterlabs/hardhat-zksync-deploy";

// An example of a deploy script that will deploy and call a simple contract.
export default async function (hre: HardhatRuntimeEnvironment) {
  console.log(`Running deploy script for the Greeter contract`);

  // Initialize the wallet.
  const wallet = new Wallet("$VAR1");

  // Create deployer object and load the artifact of the contract you want to deploy.
  const deployer = new Deployer(hre, wallet);
  const artifact = await deployer.loadArtifact("Greeter");

  // Estimate contract deployment fee
  const greeting = "Hi there!";
  const deploymentFee = await deployer.estimateDeployFee(artifact, [greeting]);

  // OPTIONAL: Deposit funds to L2
  // Comment this block if you already have funds on zkSync.
  const depositHandle = await deployer.zkWallet.deposit({
    to: deployer.zkWallet.address,
    token: utils.ETH_ADDRESS,
    amount: deploymentFee.mul(2),
  });
  // Wait until the deposit is processed on zkSync
  await depositHandle.wait();

  // Deploy this contract. The returned object will be of a `Contract` type, similarly to ones in `ethers`.
  // `greeting` is an argument for contract constructor.
  const parsedFee = ethers.utils.formatEther(deploymentFee.toString());
  console.log(`The deployment is estimated to cost ${parsedFee} ETH`);

  const greeterContract = await deployer.deploy(artifact, [greeting]);

  //obtain the Constructor Arguments
  console.log("constructor args:" + greeterContract.interface.encodeDeploy([greeting]));

  // Show the contract info.
  const contractAddress = greeterContract.address;
  console.log(`${artifact.contractName} was deployed to ${contractAddress}`);

  // Verify contract programmatically 
  //
  // Contract MUST be fully qualified name (e.g. path/sourceName:contractName)
  const contractFullyQualifedName = "contracts/Greeter.sol:Greeter";
  const verificationId = await hre.run("verify:verify", {
    address: contractAddress,
    contract: contractFullyQualifedName,
    constructorArguments: [greeting],
    bytecode: artifact.bytecode,
  });
  console.log(`${contractFullyQualifedName} verified! VerificationId: ${verificationId}`)
}

EOF

cd $HOME
echo
echo -ne "
$(printBCyan	'		Смартконтракт готов!')

$(printBCyan	'		Далее необходимо сделать деплой контракта!')
"

mainmenu
}

mainmenu