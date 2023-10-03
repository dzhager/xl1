#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/common.sh) && printlogo && printholograph
#-----------------------------------------------------------------------------------------#

echo
mainmenu() {
	echo -ne "
		$(printBCyan ' -->') $(printBYellow    '1)') Просмотр текущей конфигурации сети.
		$(printBCyan ' -->') $(printBYellow    '2)') Просмотр текущей информации о пользователе.
		$(printBCyan ' -->') $(printBYellow    '3)') Просмотр конфигурации Holograph CLI. 
		$(printBCyan ' -->') $(printBYellow    '4)') Обновить конфиг Holograph CLI. 

		$(printBBlue ' <--') $(printBBlue    '5) Вернутся назад')
		 $(printBRed    ' 0) Выйти')
		 
	$(printCyan 'Введите цифру:')  "
	read -r ans
	case $ans in
		1)
		clear && printlogo && printholograph
		echo
		holograph config:networks
		echo
		mainmenu
		;;
		
		2)
		clear && printlogo && printholograph
		echo
		holograph config:user
		echo
		mainmenu
		;;

		3)
		clear && printlogo && printholograph
		echo
		holograph config:view
		echo
		mainmenu
		;;
		
		4)
		clear && printlogo && printholograph
		echo
		holograph config
		echo
		mainmenu
		;;

		5)
		back
		;;
		
		0)
		echo $(printBCyan '"Bye bye."')
		rm x-l1bra
		exit 
		;;
		
		*)
		clear && printlogo && printholograph
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		mainmenu
		;;
	esac
}

back(){
	source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/active/holograph/main.sh)
}

mainmenu