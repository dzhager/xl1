#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/common.sh) && printlogo && printholograph
#-----------------------------------------------------------------------------------------#
mainmenu() { echo -ne "

		$(printBCyan ' -->') $(printBGreen    '1) Faucet')

		$(printBCyan ' -->') $(printBGreen    '2) Start operator')
		$(printBCyan ' -->') $(printBGreen    '3) Bonding')
		
		$(printBCyan ' -->') $(printBGreen    '4) Управление')

		$(printBCyan ' -->') $(printBGreen    '5) Установить ноду')
		$(printBCyan ' -->') $(printBGreen    '6) Удалить ноду')

		$(printBBlue ' <-- 7) Назад')
		$(printBRed        '     0) Выход')

	$(printCyan 'Введите цифру:')  "

read -r ans
	case $ans in
		1)
		faucet
		;;
		
		2)
		operator
		;;

		3)
		bonding
		;;
		
		4)
		control
		;;

		5)
		install
		;;
		
		6)
		delet
		;;
		
		7)
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

delet(){
	source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/active/holograph/delet.sh)
}

operator(){
	clear && printlogo && printholograph
	echo
	holograph operator
	echo
	mainmenu
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

control(){
	source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/active/holograph/control.sh)
}



mainmenu