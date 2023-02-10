#!/bin/bash

clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)
printLogo
echo
echo
mainmenu() {
	echo -ne "
	$(printYellow    'Для того что бы выйти из системного монитора нажмите') $(printBRed 'q') $(printYellow '!!!')
	$(printBCyan ' -->') $(printBGreen    'Нажмите') $(printBCyan 'Enter') $(printBGreen 'для запуска')
	$(printBCyan ' -->') $(printBYellow   'Для установки введите цифру') $(printBCyan '2') $(printBYellow 'и нажмите') $(printBCyan 'Enter')
	$(printCyan	'Введите цифру:') "
	read -r ans
	case $ans in
		2)
		$(printBCyan ' -->') $(printBYellow    'Установка.....') "
		sudo apt update  > /dev/null 2>&1
		sudo apt install snapd -y > /dev/null 2>&1
		snap install btop > /dev/null 2>&1
		btop
		./x-l1bra
		;;
		*)
		btop
		./x-l1bra
        ;;
    esac
}

mainmenu



