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

echo " $(printBBlue '=======================================================')"
echo "$(printBYellow '  16.06.2023  Добавлена установка ноды Sei     ')"
echo
echo
echo
echo " $(printBBlue '=======================================================')"

#-----------------------------Основное меню-----------------------------------------#
	mainmenu() { 
		echo
		echo "$(printBCyan '              -->') $(printBGreen    '1)')  Ноды"
		echo "$(printBCyan '              -->') $(printBGreen    '2)')  Смартконтракты"
		echo
		echo "$(printBCyan '              -->') $(printBYellow    '3)')  Показать IP сервера"
		echo "$(printBCyan '              -->') $(printBYellow    '4)')  Системный монитор"
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
				clear && printLogo && echo && curl ifconfig.co && mainmenu
				;;
			#-------------------#
				4)
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
