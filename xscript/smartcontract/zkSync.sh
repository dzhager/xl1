#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh) && printLogo && printZksync
#-----------------------------------------------------------------------------------------#

#-------------------------------------Основное меню---------------------------------------#
	mainmenu() {
		echo "$(printBCyan ' -->') $(printBCyan    '1) Создать смартконтракт')"
		echo "$(printBCyan ' -->') $(printBCyan    '2) Сделать деплой контракта')"
		echo "$(printBCyan ' -->') $(printBGreen   '3) Обновить закрытый ключ Metamask')"
		echo
		echo "$(printBCyan ' -->') $(printBRed     '4) Удалить')"
		echo 
		echo "$(printBBlue ' <-- 5) Назад')"
		echo "$(printBRed        '     0) Выход')"
	

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
			clear
			printLogo
			printzcsync
			echo
			echo
			echo    -ne "$(printBRed '		   Неверный запрос !')"
			echo
			mainmenu
			;;
		#---------------------------------------#
			esac
}

	createSmart(){
		echo && cd $HOME && sudo apt update && sudo apt upgrade -y && sudo apt install curl nodejs cmdtest nano -y
		curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
		mkdir $HOME/greeter-example && cd greeter-example
		npm init --y && npm install --save-dev hardhat && npm install -g npm@9.6.0 && npx hardhat
		mkdir $HOME/greeter-example/greeter && cd $HOME/greeter-example/greeter
		npm add -D typescript ts-node @types/node ethers@^5.7.2 zksync-web3@^0.13.1 @ethersproject/hash @ethersproject/web hardhat @matterlabs/hardhat-zksync-solc @matterlabs/hardhat-zksync-deploy


cat << EOF  > $HOME/greeter-example/greeter/hardhat.config.ts
import "@matterlabs/hardhat-zksync-deploy";
import "@matterlabs/hardhat-zksync-solc";
const zkSyncTestnet =
  process.env.NODE_ENV == "test"
    ? {
        url: "http://localhost:3050",
        ethNetwork: "http://localhost:8545",
        zksync: true
      }
    : {
        url: "https://zksync2-testnet.zksync.dev",
        ethNetwork: "goerli",
        zksync: true
      };
zksolc: {
  version: "1.3.10",
  compilerSource: "binary",
  settings: {},
},
EOF

mkdir $HOME/greeter-example/greeter/contracts && mkdir $HOME/greeter-example/greeter/deploy

cat << EOF  > $HOME/greeter-example/greeter/contracts/Greeter.sol
//SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

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
import { utils, Wallet } from "zksync-web3";
import * as ethers from "ethers";
import { HardhatRuntimeEnvironment } from "hardhat/types";
import { Deployer } from "@matterlabs/hardhat-zksync-deploy";

// An example of a deploy script that will deploy and call a simple contract.
export default async function (hre: HardhatRuntimeEnvironment) {
  console.log(`Running deploy script for the Greeter contract`);

  // Initialize the wallet.
  const wallet = new Wallet("$VAR1");

  // Create deployer object and load the artifact of the contract we want to deploy.
  const deployer = new Deployer(hre, wallet);
  const artifact = await deployer.loadArtifact("Greeter");

  // Deploy this contract. The returned object will be of a `Contract` type, similarly to ones in `ethers`.
  // `greeting` is an argument for contract constructor.
  const greeting = "Hi there!";
  const greeterContract = await deployer.deploy(artifact, [greeting]);
  console.log(greeterContract.interface.encodeDeploy([greeting]));

  // Show the contract info.
  const contractAddress = greeterContract.address;
  console.log(`${artifact.contractName} was deployed to ${contractAddress}`);

  // Call the deployed contract.
  const greetingFromContract = await greeterContract.greet();
  if (greetingFromContract == greeting) {
    console.log(`Contract greets us with ${greeting}!`);
  } else {
    console.error(`Contract said something unexpected: ${greetingFromContract}`);
  }

  // Edit the greeting of the contract
  const newGreeting = "Hey guys";
  const setNewGreetingHandle = await greeterContract.setGreeting(newGreeting);
  await setNewGreetingHandle.wait();

  const newGreetingFromContract = await greeterContract.greet();
  if (newGreetingFromContract == newGreeting) {
    console.log(`Contract greets us with ${newGreeting}!`);
  } else {
    console.error(`Contract said something unexpected: ${newGreetingFromContract}`);
  }
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