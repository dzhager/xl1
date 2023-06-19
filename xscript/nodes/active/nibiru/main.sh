#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/common.sh) && printlogo && printnibiru
#-----------------------------------------------------------------------------------------#
mainmenu() { echo -ne "

		$(printBCyan ' -->') $(printBCyan    '1) Управление')

		$(printBCyan ' -->') $(printBGreen    '2) Установить')
		$(printBCyan ' -->') $(printBYellow    '3) Обновить')
		$(printBCyan ' -->') $(printBRed    '4) Удалить')

		$(printBBlue ' <-- 5) Назад')
		$(printBRed        '     0) Выход')

	$(printCyan 'Введите цифру:')  "

read -r ans
	case $ans in
		1)
		control
		;;
		3)
		update
		;;
		2)
		install
		;;
		4)
		delet
		;;
		5)
		back
		;;
		0)
		echo $(printBCyan '	"Bye bye."')
		rm x-l1bra
		exit
		;;
		*)
		clear
		printlogo
		printnibiru
		echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		mainmenu
		;;
	esac
}

install(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/active/nibiru/install.sh)
}

control(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/active/nibiru/control.sh)
}

update(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/active/nibiru/update.sh)
}

delet(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/active/nibiru/delet.sh)
}

back(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/menu/menunodes.sh)
}

mainmenu