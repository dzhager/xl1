#!/bin/bash

#Script written by DZHAGERR for X-libra
#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/common.sh) && printlogo #&& print5ireChain
#-----------------------------------------------------------------------------------------#





echo "$(printBCyan ' -->') $(printBMagenta    '1) Просмотр логов')"

mainmenu() { echo -ne "


		$(printBCyan ' -->') $(printBGreen    '2) Установить')

		$(printBCyan ' -->') $(printBRed    '3) Удалить')

		$(printBBlue ' <-- 4) Назад')

		$(printBRed        '     0) Выход')

	$(printCyan 'Введите цифру:')  "

read -r ans
	case $ans in
		1)
		logs
		;;

		2)
		install
		;;

		3)
		delet
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
		clear
		printLogo
		printstarknet
		echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		mainmenu
		;;
	esac
}

logs(){
	docker logs happy_gauss -f -n 100
	mainmenu
}

install(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/5ireChain/install.sh)
}


delet(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/5ireChain/delet.sh)
}

back(){
./x-l1bra
}

mainmenu