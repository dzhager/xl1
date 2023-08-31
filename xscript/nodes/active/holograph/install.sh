#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/common.sh) && printlogo && printholograph
#-----------------------------------------------------------------------------------------#

echo -ne "
	$(printGreen  '-----------------------------------------')
	  $(printYellow 'Минимальные требования к оборудованию.')
		     $(printBCyan '4CPU 4RAM 40GB')
	$(printGreen  '-----------------------------------------')
	$(printYellow 'Рекомендуемые требования к оборудованию.')
		     $(printBCyan '8CPU 4RAM 200GB')
	$(printGreen  '-----------------------------------------')"
echo
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
		clear && printlogo && printholograph
		echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		mainmenu
        	;;
    esac
}


no(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/active/holograph/main.sh)
}
yes(){
clear && printlogo && printholograph
echo


printBCyan "Пожалуйста подождите........" && sleep 1
printYellow "1. Обновление менеджеров пакетов........" && sleep 1
	sudo apt update > /dev/null 2>&1
printGreen "Готово!" && sleep 1


printYellow "2. Устанавливаем дополнительные пакеты........" && sleep 1
	sudo apt install screen apt install make clang git pkg-config libssl-dev build-essential git gcc chrony curl jq ncdu bsdmainutils htop net-tools lsof fail2ban wget screen -y
	curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -
	apt install -y nodejs
printGreen "Готово!" && sleep 1

printYellow "3. Устанавка Holograph cli........" && sleep 1
npm install -g @holographxyz/cli
printGreen "Готово!" && sleep 1

printYellow "4. Запускаем config........" && sleep 1
holograph config
printGreen "Готово!" && sleep 1

subnmenu

}

subnmenu() {
	echo -ne "
	$(printCyan	'Установка завершена') $(printCyanBlink '!!!')
	$(printCyan	'Нажмите Enter:') "
	read -r ans
	case $ans in
		*)
		source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/active/holograph/main.sh)
       		;;
    esac
}

mainmenu