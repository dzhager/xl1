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
		echo
		echo "$(printBCyan '		-->') $(printBYellow    ' 1)') Nibiru $(printBTYellow '****')"
		echo "$(printBCyan '		-->') $(printBYellow    ' 2)') DeFund $(printBTYellow '***')"
		echo "$(printBCyan '		-->') $(printBYellow    ' 3)') Shardeum $(printBTYellow '*****')"
		echo "$(printBCyan '		-->') $(printBYellow    ' 4)') Starknet $(printBTYellow '****')"
		echo "$(printBCyan '		-->') $(printBYellow    ' 5)') 5ireChain $(printBTYellow '*****')"
		echo "$(printBCyan '		-->') $(printBYellow    ' 6)') Elixir $(printBTYellow '****')"
		echo
		echo "$(printBCyan '		-->') $(printBYellow    ' 7)') $(printBYellow 'Архив')"
		echo
		echo "$(printBCyan '		<--') $(printBBlue    ' 8)') $(printBYellow 'Назад')"
		echo
		echo "$(printBRed        '                     0) Выход')"
		echo
		echo -ne "$(printBGreen ' Введите цифру:') $(printYellowBlink '-->') "
			
			read -r ans
				case $ans in
		#-------------------#
			1)
			source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/nibiru/main.sh)
			;;
		#-------------------#
			2)
			source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/defund/main.sh)
			;;
		#-------------------#
			3)
			source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/shardeum/main.sh)
			;;
		#-------------------#
			4)
			source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/starknet/main.sh)
			;;
		#-------------------#
			5)
			clear && printLogo && printComing && mainmenu
			;;
		#-------------------#
			6)
			source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/elixir/main.sh)
			;;
		#-------------------#
			7)
			archive
			;;
		#-------------------#
			8)
			source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/menu/homemenu.sh)
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

########################################
#  		    	Архив нод	 		   #
########################################
	

mainmenu