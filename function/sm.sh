#!/bin/bash

clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)

mainmenu(){
    echo -ne "
$(printYellow    'Для того что бы остановить выйти из системного монитора') $(printBCyan 'q') $(printYellow '!!!')

	Для продолжения нажмите Enter:  "
	read -r ans
	case $ans in
		*)
		echo -ne "
	    $(printBCyan ' -->') $(printBYellow    'Запуск.....') "
		sudo apt install snapd -y > /dev/null 2>&1
		snap install btop > /dev/null 2>&1
		btop
		./x-l1bra
		;;
	esac
}

mainmenu


