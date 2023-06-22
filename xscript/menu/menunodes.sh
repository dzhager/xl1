#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/common.sh) && printlogo
#-----------------------------------------------------------------------------------------#

#-----------------------------Шапка скрипта-----------------------------------------#
echo " $(printBCyan '                 =====================')"
echo " $(printRed  '================')$(printBCyan ' = ')$(printBGreen '      Ноды       ')$(printBCyan ' = ')$(printRed  '================')"
echo " $(printBCyan '                 =====================')"
#-----------------------------------------------------------------------------------#

#-----------------------------Основное меню-----------------------------------------#
	mainmenu() { 
		echo
		echo "$(printBCyan '		-->') $(printBYellow    ' 1)') Nibiru $(printBTYellow '****')"
		echo "$(printBCyan '		-->') $(printBYellow    ' 2)') Shardeum $(printBTYellow '*****')"
		echo "$(printBCyan '		-->') $(printBYellow    ' 3)') Starknet $(printBTYellow '****')"
		echo "$(printBCyan '		-->') $(printBYellow    ' 4)') 5ireChain $(printBTYellow '*****')"
		echo "$(printBCyan '		-->') $(printBYellow    ' 5)') Elixir $(printBTYellow '****')"
		echo
		echo "$(printBCyan '		-->') $(printBYellow    ' 6)') $(printBYellow 'Архив')"
		echo
		echo "$(printBCyan '		<--') $(printBBlue    ' 7)') $(printBYellow 'Назад')"
		echo "$(printBRed        '                     0) Выход')"
		echo
		echo -ne "$(printBGreen ' Введите цифру:') $(printYellowBlink '-->') "
	#-------------------------Свойства меню-------------------------#
			read -r ans
				case $ans in
		#-------------------#
			1)
			source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/active/nibiru/main.sh)
			;;
		#-------------------#
			2)
			source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/active/shardeum/main.sh)
			;;
		#-------------------#
			3)
			source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/active/starknet/main.sh)
			;;
		#-------------------#
			4)
			clear && printlogo && printComing && mainmenu
			;;
		#-------------------#
			5)
			source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/active/elixir/main.sh)
			;;
		#-------------------#
			6)
			source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/menu/archivenodes.sh)
			;;
		#-------------------#
			7)
			back
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

	back(){
	./x-l1bra
	}
#-----------------------------------------------------------------------------------#
mainmenu