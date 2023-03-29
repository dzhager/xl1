#!/bin/bash

clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh) && printLogo && printdefund && echo && printaleo


#-------------------Системные требовани
echo -ne "
	$(printGreen  '-----------------------------------------')
	  $(printYellow 'Минимальные требования к оборудованию.')
		     $(printBCyan '4CPU 16RAM 1000GB')
	$(printGreen  '-----------------------------------------')"
echo

#-------------------Вы действительно хотите начать установку
	mainmenu() {
	echo -ne "
	$(printCyan	'Вы действительно хотите начать установку') $(printCyanBlink '???')
	$(printGreen	' 1) Да')
	$(printRed	' 2) Нет')
	$(printCyan	'Введите цифру:') "
	read -r ans
	case $ans in
		1)
		yes
		;;
		2)
		no
		;;
		*)
		clear && printLogo && printaleo
		echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		mainmenu
        	;;
    esac
	}

#-------------------Функция меню
	#-------------------Нет
	no(){
	#source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/defund/main.sh)
	}
	#-------------------Да
	yes(){
	clear && printLogo && printaleo
	echo
	echo

#-------------------УСТАНОВКА
#-------------------ОБНОВЛЕНИЕ СИСТЕМЫ

	printBCyan "Пожалуйста подождите........" && sleep 1
	printYellow "1. Oбновляем наш сервер........" && sleep 1
		sudo apt update && sudo apt upgrade --yes > /dev/null 2>&1
	printGreen "Готово!" && sleep 1

#-------------------УСТАНОВКА ДОПОЛНИЦЕЛЬНЫХ ПАКЕТОВ
	
	printYellow "2. Устанавливаем дополнительные пакеты........" && sleep 1
		sudo apt install curl git jq lz4 build-essential screen -y &&
	printGreen "Готово!" && sleep 1

#-------------------ЗАПУСК СКРИТА С https://sh.rustup.rs
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh &&
	git clone https://github.com/AleoHQ/snarkOS.git --depth 1 &&
	cd snarkOS &&
	./build_ubuntu.sh &&
	source $HOME/.cargo/env &&
	cargo install --path . &&
#-------------------Настраиваем язык Leo
	cd &&
	git clone https://github.com/AleoHQ/leo &&
	cd leo &&
	cargo install --path . &&
	leo &&
	
#-------------------РАЗВОРАЧИВАЕМ ТЕСТОВОЕ ПРИЛОЖЕНИЕ

	cd $HOME && mkdir demo_deploy_Leo_app && cd demo_deploy_Leo_app &&
	
	read -r VAR1
	WALLETADDRESS="$VAR1"
	
	APPNAME=helloworld_"${WALLETADDRESS:4:6}" &&
	echo $APPNAME  &&
	leo new "${APPNAME}"  &&
	cd "${APPNAME}" && leo run && cd -  &&
	PATHTOAPP=$(realpath -q $APPNAME)  &&
	echo $PATHTOAPP  &&
	cd $PATHTOAPP && cd ..  &&

	read -r VAR2
	PRIVATEKEY="$VAR2"

	read -r VAR3
	RECORD="$VAR3"

	snarkos developer deploy "${APPNAME}.aleo" --private-key "${PRIVATEKEY}" --query "https://vm.aleo.org/api" --path "./${APPNAME}/build/" --broadcast "https://vm.aleo.org/api/testnet3/transaction/broadcast" --fee 600000 --record "${RECORD}" &&
	