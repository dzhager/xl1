#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/common.sh) && printlogo && printholograph
#-----------------------------------------------------------------------------------------#
mainmenu() { echo -ne "

		$(printBCyan ' -->') $(printBGreen    '1) Установить')

		$(printBBlue ' <-- 2) Назад')
		$(printBRed        '     0) Выход')

	$(printCyan 'Введите цифру:')  "

read -r ans
	case $ans in
		1)
		install
		;;
		2)
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

install(){
	source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/active/holograph/install.sh)
}

back(){
	source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/menu/menunodes.sh)
}

mainmenu