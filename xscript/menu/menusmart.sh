#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/common.sh) && printlogo
#-----------------------------------------------------------------------------------------#


#-----------------------------Шапка скрипта-----------------------------------------#
echo " $(printCyanBlink '                 =====================')"
echo " $(printRed  '================')$(printCyanBlink ' = ')$(printBGreen ' Смартконтракты ')$(printCyanBlink ' = ')$(printRed  '================')"
echo " $(printCyanBlink '                 =====================')"
#-----------------------------------------------------------------------------------#

#-----------------------------Основное меню-----------------------------------------#

mainmenu() { 
	echo
	echo
	echo "$(printBCyan '		-->') $(printBYellow    ' 1)') ZkSync $(printBTYellow '****')"
	echo
	echo "$(printBCyan '		-->') $(printBYellow    ' 7)') $(printBYellow 'Архив')"
	echo
	echo "$(printBRed        '                     0) Выход')"
	echo
	echo -ne "$(printBGreen ' Введите цифру:') $(printYellowBlink '-->') "
		
		read -r ans
			case $ans in
	#-------------------#
		1)
		ZkSync
		;;
		2)
		archive
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