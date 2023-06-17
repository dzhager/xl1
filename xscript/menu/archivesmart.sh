#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/common.sh) && printlogo
#-----------------------------------------------------------------------------------------#

#-----------------------------Шапка скрипта-----------------------------------------#
	echo " $(printBCyan '                 =====================')"
	echo " $(printRed  '================')$(printBCyan ' = ')$(printBYellow '      Архив      ')$(printBCyan ' = ')$(printRed  '================')"
	echo " $(printBCyan '                 =====================')"
#-----------------------------------------------------------------------------------#

#-----------------------------Основное меню-----------------------------------------#
	mainmenu() { 
		echo
		echo "$(printBCyan '		<--') $(printBYellow    ' 1)') $(printBBlue 'Назад')"
		echo "$(printBRed        '                     0) Выход')"
		echo
		echo -ne "$(printBGreen ' Введите цифру:') $(printYellowBlink '-->') "
	#-------------------------Свойства меню-------------------------#
		read -r ans
			case $ans in
		#-------------------#
			1)
			source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/menu/menusmart.sh)
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
#-----------------------------------------------------------------------------------#
mainmenu