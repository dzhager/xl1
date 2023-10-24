#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/common.sh) && printlogo && printfleek
#-----------------------------------------------------------------------------------------#
mainmenu() { echo -ne "

		$(printBCyan ' -->') $(printBGreen    '1) Установить')
		$(printBCyan ' -->') $(printBGreen    '2) Проверка ноды')
		$(printBCyan ' -->') $(printBGreen    '3) Просмотр деталей ')
		$(printBCyan ' -->') $(printBGreen    '4) Информация о стейке ')
		
		$(printBBlue ' <-- 5) Назад')
		$(printBRed        '     0) Выход')

	$(printCyan 'Введите цифру:')  "

read -r ans
	case $ans in
		1)
		install
		;;
		
		2)
		healthcheck
		;;

		3)
		node_details
		;;

		4)
		health
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
		clear && printlogo && printfleek
		echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		mainmenu
		;;
	esac
}



install(){
	curl -s https://registry.axiomdev.co/bash/lightning/deploy.sh | bash
	mainmenu
}

healthcheck(){
	clear && printlogo && printfleek
	docker exec lightning-cli bash healthcheck.sh
	mainmenu
}

node_details(){
	clear && printlogo && printfleek
	docker exec lightning-cli bash node_details.sh
	mainmenu
}

health(){
	clear && printlogo && printfleek
	curl -w "\n" localhost:4230/health
	mainmenu
}


back(){
	source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/menu/menunodes.sh)
}




mainmenu