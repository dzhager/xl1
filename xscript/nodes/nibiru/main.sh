#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/common.sh) && printlogo && printNibiru
#-----------------------------------------------------------------------------------------#

#-------------------------------------Основное меню---------------------------------------#
	mainmenu() { 
		echo "$(printBCyan '                     -->') $(printBCyan    '1) Управление')"

		echo "$(printBCyan ' -->') $(printBGreen    '2) Установить')"
		echo "$(printBCyan ' -->') $(printBRed    '4) Удалить')"
		echo "$(printBCyan ' -->') $(printBYellow    '3) Обновить')"

		echo "$(printBBlue ' <-- 5) Назад')"
		echo "$(printBRed        '     0) Выход')"

		echo -ne "$(printBCyan ' Введите цифру: --> ')"
	#-------------------------Свойства меню-------------------------#	
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
				printLogo
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
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/nibiru/install.sh)
}

control(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/nibiru/control.sh)
}

update(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/nibiru/update.sh)
}

delet(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/nibiru/delet.sh)
}

back(){
./x-l1bra
}

mainmenu