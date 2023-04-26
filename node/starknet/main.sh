#! /bin/bash

#X-l1bra  
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)
printLogo
printstarknet
mainmenu() { echo -ne "

		$(printBCyan ' -->') $(printBGreen    '1) Просмотр логов')

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
	journalctl -u starknetd -f
	mainmenu
}

install(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/starknet/install.sh)
}


delet(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/starknet/delet.sh)
}

back(){
./x-l1bra
}

mainmenu