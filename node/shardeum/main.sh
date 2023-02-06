#! /bin/bash

#X-l1bra  
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)
printLogo
printshardium

mainmenu() { echo -ne "

		$(printBCyan ' -->') $(printBCyan    '1) Управление')

		$(printBCyan ' -->') $(printBGreen    '2) Установить')
		$(printBCyan ' -->') $(printBRed    '3) Удалить')

		$(printBBlue ' <-- 4) Назад')
		$(printBRed        '     0) Выход')

 	Введите цифру: "

read -r ans
	case $ans in
		1)
		control
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
		echo $(printBCyan '"Bye bye."')
		rm x-l1bra
		exit
		;;
		*)
		clear
		printLogo
		printshardium
		echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		mainmenu
		;;
	esac
}

install(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/shardeum/install.sh)
}

control(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/shardeum/control.sh)
}


delet(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/shardeum/delet.sh)
}

back(){
./x-l1bra
}

mainmenu