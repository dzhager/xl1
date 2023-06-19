#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/common.sh) && printlogo
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
		echo 	"$(printBCyan '              -->') $(printBYellow    '4)') Показать IP сервера"
		echo "$(printBCyan '              -->') $(printBYellow    '5)') Системный монитор"
		echo
		echo "$(printBCyan '              -->') $(printBYellow    '6)') Прокси"
		echo
		echo "$(printBRed        '                  0) Выход')"
		echo
		echo -ne "$(printBGreen ' Введите цифру:') $(printYellowBlink '-->') "
	#-------------------------Свойства меню-------------------------#
		read -r ans
			case $ans in
			#---------Ноды----------#
				1)
				source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/menu/menunodes.sh)
				;;
			#--------Смартконтракты-----------#
				2)
				source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/menu/menusmart.sh)
				;;
			#---------Новости----------#
				3)
				source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/updates.sh)
				;;
			#---------Показать IP сервера----------#
				4)
				ip_address=$(curl -s https://api.ipify.org)
				clear && printlogo
				echo " $(printCyanBlink '                 =====================')"
				echo " $(printRed  '================')$(printCyanBlink ' = ')$(printBMagenta 'Добро пожаловать!')$(printCyanBlink ' = ')$(printRed  '================')"
				echo " $(printCyanBlink '                 =====================')"
				echo
				echo " $(printBYellow              "                     $ip_address")"
				mainmenu
				;;
			#--------Системный монитор-----------#
				5)
				source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/sm.sh)
				;;
			#--------Прокси-----------#	
				6)
				source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/proxy.sh)
				;;
			#--------Выход-----------#
				0)
				echo $(printBCyan '	"Bye bye."') && exit
				;;
			#--------Неверный запрос!-----------#
				*)
				clear && printlogo
				echo " $(printCyanBlink '                 =====================')"
				echo " $(printRed  '================')$(printCyanBlink ' = ')$(printBRed 'Неверный запрос! ')$(printCyanBlink ' = ')$(printRed  '================')"
				echo " $(printCyanBlink '                 =====================')"
				mainmenu
				;;
			#-------------------#
			esac
			}
#-----------------------------------------------------------------------------------------#
mainmenu

