#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/common.sh) && printlogo && printholograph
#-----------------------------------------------------------------------------------------#
mainmenu() { echo -ne "

		$(printBCyan ' -->') $(printBGreen    '1) Faucet')

		$(printBCyan ' -->') $(printBGreen    '2) Bonding')
		
		$(printBCyan ' -->') $(printBGreen    '3) Управление')

		$(printBCyan ' -->') $(printBGreen    '4) Установить ноду')
		$(printBCyan ' -->') $(printBGreen    '5) Удалить ноду')

		$(printBBlue ' <-- 6) Назад')
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
		install
		;;
		
		5)
		delet
		;;
		
		6)
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