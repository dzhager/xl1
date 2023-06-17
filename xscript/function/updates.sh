#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/common.sh) && printlogo
#-----------------------------------------------------------------------------------------#

#-----------------------------Шапка скрипта-----------------------------------------#
echo " $(printBMagenta '=|    Дата    |========================================')"
#-----------------------------------------------------------------------------------#

#-----------------------------Лента новостей-----------------------------------------#
	echo " $(printBMagenta '=')""$(printBYellow '| 18.06.2023 |') Добавлена установка ноды Sei"
	echo " $(printBMagenta '=')""$(printBYellow '| 17.06.2023 |') Обновлено меню скрипта"
	echo " $(printBMagenta '=')""$(printBYellow '| 17.06.2023 |') Добалена нода 5ireChain"
	echo " $(printBMagenta '=')""$(printBYellow '|            |')"
	echo " $(printBMagenta '=')""$(printBYellow '|            |')"
	echo " $(printBMagenta '=')""$(printBYellow '|            |')$(printBMagenta '========================================')"
#-----------------------------------------------------------------------------------#

#-----------------------------Основное меню-----------------------------------------#
	mainmenu() { 
		echo
		echo "$(printBCyan '              <--') $(printBGreen    '1)')  Назад"

		echo "$(printBRed        '                  0)  Выход')"
		echo
		echo -ne "$(printBGreen ' Введите цифру:') $(printYellowBlink '-->') "
	#-------------------------Свойства меню-------------------------#
		read -r ans
			case $ans in
			#----------Назад---------#
				1)
				source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/menu/homemenu.sh)
				;;
			#----------Выход---------#
				0)
				echo $(printBCyan '	"Bye bye."') && exit
				;;
			#----------Неверный запрос---------#
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
#-----------------------------------------------------------------------------------------#
mainmenu
