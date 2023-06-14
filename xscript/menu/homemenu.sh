#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh) && printLogo
#-----------------------------------------------------------------------------------------#


#-----------------------------Шапка скрипта-----------------------------------------#
echo " $(printCyanBlink '                 =====================')"
echo " $(printRed  '================')$(printCyanBlink ' = ')$(printBGreen 'Добро пожаловать!')$(printCyanBlink ' = ')$(printRed  '================')"
echo " $(printCyanBlink '                 =====================')"
#-----------------------------------------------------------------------------------#

#-----------------------------Основное меню-----------------------------------------#
	mainmenu() { 
		echo
		echo "$(printBCyan '              -->') $(printBYellow    '1)') Ноды"
		echo "$(printBCyan '              -->') $(printBYellow    '2)') Смартконтракты"
		echo
		echo "$(printBCyan '              -->') $(printBYellow   '3)') Новости"
		echo
		echo "$(printBCyan '              -->') $(printBYellow    '4)') Показать IP сервера"
		echo "$(printBCyan '              -->') $(printBYellow    '5)') Системный монитор"
		echo
		echo "$(printBRed        '                  0)  Выход')"
		echo
		echo -ne "$(printBGreen ' Введите цифру:') $(printYellowBlink '-->') "
	#-------------------------Свойства меню-------------------------#
		read -r ans
			case $ans in
			#-------------------#
				1)
				source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/menu/menunodes.sh)
				;;
			#-------------------#
				2)
				source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/menu/menusmart.sh)
				;;
			#-------------------#
				3)
				source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/updates.sh)
				;;
			#-------------------#
				4)
				IP=$(curl ifconfig.co)
				clear && printLogo
				echo " $(printCyanBlink '                 =====================')"
				echo " $(printRed  '================')$(printCyanBlink ' = ')$(printBMagenta 'Добро пожаловать!')$(printCyanBlink ' = ')$(printRed  '================')"
				echo " $(printCyanBlink '                 =====================')"
				echo
				echo " $(printBYellow              "                     $IP")"
				mainmenu
				;;
			#-------------------#
				5)
				source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/sm.sh)
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

mainmenu

