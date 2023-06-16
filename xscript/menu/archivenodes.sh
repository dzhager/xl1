#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/common.sh) && printlogo
#-----------------------------------------------------------------------------------------#

#-----------------------------Шапка скрипта-----------------------------------------#
echo " $(printCyanBlink '                 =====================')"
echo " $(printRed  '================')$(printCyanBlink ' = ')$(printBYellow '   Архив   ')$(printCyanBlink ' = ')$(printRed  '================')"
echo " $(printCyanBlink '                 =====================')"
#-----------------------------------------------------------------------------------#
    mainmenu(){
        echo "$(printBCyan '       -->') $(printBYellow    '1)') Celestia $(printBTYellow '****')"
        echo "$(printBCyan '       -->') $(printBYellow    '2)') Quasar $(printBTYellow '****')"
        echo "$(printBCyan '       -->') $(printBYellow    '3)') SUI $(printBTYellow '*****')"
        echo
	    echo "$(printBCyan '       <--') $(printBYellow    ' 4)') $(printBBlue 'Назад')"
        echo
       	echo -ne "$(printBGreen ' Введите цифру:') $(printYellowBlink '-->') "
}


	read -r ans
	case $ans in

		1)
		source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/celestia/main.sh)
		;;

		2)
		source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/quasar/main.sh)
		;;

		3)
		source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/sui/main.sh)
		;;

		4)
		clear && printLogo 
echo -ne "$(printCyanBlink '                  =====================')
$(printRed  ' ================')$(printCyanBlink ' = ')$(printBMagenta 'Добро пожаловать!')$(printCyanBlink ' = ')$(printRed  '================') 
$(printCyanBlink '                  =====================')"
		mainmenu
		;;

		*)
		clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)
		printLogo
echo -ne "$(printCyanBlink '                  =====================')
$(printRed  ' ================')$(printCyanBlink ' = ')$(printBYellow '      Архив')$(printCyanBlink '       = ')$(printRed  '================') 
$(printCyanBlink '                  =====================')"
		archive
		;;
	esac
}
