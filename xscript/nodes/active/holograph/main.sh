#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/common.sh) && printlogo && printholograph
#-----------------------------------------------------------------------------------------#
mainmenu() { echo -ne "

		$(printBCyan ' -->') $(printBGreen    '1) Faucet')
		
		$(printBCyan ' -->') $(printBGreen    '2) Bonding')
		
		$(printBCyan ' -->') $(printBGreen    '3) Установить ноду')

		$(printBBlue ' <-- 4) Назад')
		$(printBRed        '     0) Выход')

	$(printCyan 'Введите цифру:')  "

read -r ans
	case $ans in
		1)
		faucet
		;;
		
		2)
		bonding
		;;
		
		3)
		install
		;;
		
		4)
		back
		;;
		
		0)
		echo $(printBCyan '	"Bye bye."')
		rm x-l1bra
		exit
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

faucet(){
	echo
	holograph faucet
	echo
	mainmenu
}

bonding(){
	holograph operator:bond
}

install(){
	source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/active/holograph/install.sh)
}

back(){
	source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/menu/menunodes.sh)
}

mainmenu