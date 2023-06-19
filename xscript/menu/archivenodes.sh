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
    mainmenu(){
		echo
        echo "$(printBCyan '                --> ') $(printBYellow    '1)') Celestia $(printBTYellow '****')"
        echo "$(printBCyan '                --> ') $(printBYellow    '2)') Quasar $(printBTYellow '****')"
        echo "$(printBCyan '                --> ') $(printBYellow    '3)') SUI $(printBTYellow '*****')"
				echo "$(printBCyan '		-->') $(printBYellow    ' 4)') DeFund $(printBTYellow '***')"
        echo
	    echo "$(printBCyan '                <--') $(printBYellow    ' 5)') $(printBBlue 'Назад')"
		echo "$(printBRed        '                     0) Выход')"
		echo
    	echo -ne "$(printBGreen ' Введите цифру:') $(printYellowBlink '-->') "
		
	#-------------------------Свойства меню-------------------------#
	read -r ans
		case $ans in
			1)
			source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/archive/celestia/main.sh)
			;;

			2)
			source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/archive/quasar/main.sh)
			;;

			3)
			source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/archive/sui/main.sh)
			;;

			4)
			source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/archive/defund/main.sh)
			;;

			5)
			source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/menu/menunodes.sh)
			;;

			*)
			clear && printLogo
			echo " $(printCyanBlink '                 =====================')"
			echo " $(printRed  '================')$(printCyanBlink ' = ')$(printBRed 'Неверный запрос! ')$(printCyanBlink ' = ')$(printRed  '================')"
			echo " $(printCyanBlink '                 =====================')"
			mainmenu
			;;
		esac
		}
#-----------------------------------------------------------------------------------#
mainmenu
