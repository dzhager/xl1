#!/bin/bash

#X-l1bra  
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)
printLogo
printdefund	

#-------------------МЕНЮ
	mainmenu() { echo -ne "

		$(printBCyan ' -->') $(printBGreen    '1) Установить')
		$(printBCyan ' -->') $(printBYellow   '2) Установить еще')
		
		$(printBCyan ' -->') $(printBRed    '3) Удалить')

		$(printBBlue ' <-- 4) Назад')
		$(printBRed        '     0) Выход')

	$(printCyan 'Введите цифру:')  "

	read -r ans
#-------------------ФУНКЦИИ МЕНЮ
	case $ans in
		
		1)
		install
		;;
		
		2)
		installMore
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
		printdefund
		echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		mainmenu
		;;
	esac
}

install(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/Aleo/install.sh)
}

installMore(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/defund/control.sh)
}

delet(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/defund/delet.sh)
}

back(){
./x-l1bra
}

mainmenu