#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh) && printLogo
#-----------------------------------------------------------------------------------------#


#-----------------------------Шапка скрипта-----------------------------------------#
echo " $(printCyanBlink '                 =====================')"
echo " $(printRed  '================')$(printCyanBlink ' = ')$(printBMagenta 'Добро пожаловать!')$(printCyanBlink ' = ')$(printRed  '================')"
echo " $(printCyanBlink '                 =====================')"
#-----------------------------------------------------------------------------------#

#-----------------------------Основное меню-----------------------------------------#
	mainmenu() { 
		echo
		echo "$(printBCyan '              -->') $(printBYellow    '1)')  Ноды"
		echo "$(printBCyan '              -->') $(printBYellow    '2)')  Смартконтракты"
		echo
		echo "$(printBCyan '              -->') $(printBYellow    '3)')  Системный монитор"
		echo
		echo "$(printBCyan '              -->') $(printBYellow    '4)')  Система"
		echo
		echo "$(printBRed        '                  0)  Выход')"
		echo
		echo -ne "$(printBGreen ' Введите цифру:') $(printYellowBlink '-->') "
	#-------------------------Свойства меню-------------------------#
		read -r ans
			case $ans in
			#-------------------#
				1)
				node
				;;
			#-------------------#
				2)
				smartcontract
				;;
			#-------------------#
				3)
				systemmonitor
				;;
			#-------------------#
				4)
				system
				;;
			#-------------------#
				0)
				echo $(printBCyan '	"Bye bye."') && exit
				;;
			#-------------------#
				*)
				clear && printLogo
				echo " $(printCyanBlink '                 =====================')"
				echo " $(printRed  '================')$(printCyanBlink ' = ')$(printBRed 'Неверный запрос! ')$(printCyanBlink ' = ')$(printRed  '================')"
				echo " $(printCyanBlink '                 =====================')"
				mainmenu
				;;
			#-------------------#
		esac
		}
	#---------------------------------------------------------------#

#-----------------------------------------------------------------------------------------#

#-------------------------------------Функции меню----------------------------------------#
	node(){
		source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/menu/menunodes.sh)
	}

	smartcontract(){
		source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/menu/menusmart.sh)
	}

	systemmonitor(){
		source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/menu/menusmart.sh)
	}

mainmenu

