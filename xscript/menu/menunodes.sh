#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh) && printLogo
#-----------------------------------------------------------------------------------------#


#-----------------------------Шапка скрипта-----------------------------------------#
echo -ne "$(printCyanBlink '                  =====================')
$(printRed  ' ================')$(printCyanBlink ' = ')$(printBMagenta 'Добро пожаловать!')$(printCyanBlink ' = ')$(printRed  '================') 
$(printCyanBlink '                  =====================')"
#-----------------------------------------------------------------------------------#



#-----------------------------Основное меню-----------------------------------------#

mainmenu() { 
	echo
	echo "$(printBCyan '		    Выберите ноду !')"
	echo
	echo "$(printBCyan '		-->') $(printBYellow    '1)') Nibiru $(printBTYellow '****')"
	echo "$(printBCyan '		-->') $(printBYellow    '2)') DeFund $(printBTYellow '***')"
	echo "$(printBCyan '		-->') $(printBYellow    '3)') Shardeum $(printBTYellow '*****')"
	echo "$(printBCyan '		-->') $(printBYellow    '4)') Starknet $(printBTYellow '****')"
	echo "$(printBCyan '		-->') $(printBYellow    '5)') 5ireChain $(printBTYellow '*****')"
	echo "$(printBCyan '		-->') $(printBYellow    '6)') Elixir $(printBTYellow '****')"
		
	echo "$(printBCyan '		-->') $(printBYellow    '7)') $(printBYellow 'Архив')"
	echo "$(printBCyan '		-->') $(printBYellow    '8)') $(printBCyan 'Системный монитор')"

	echo "$(printBRed        '     0) Выход')"

	echo -ne "Введите цифру:  "
		
		read -r ans
			case $ans in
	#-------------------#
		1)
		nibiru
		;;
	#-------------------#
		2)
		defund
		;;
	#-------------------#
		3)
		shardeum
		;;
	#-------------------#
		4)
		clear
		starknet
		;;
	#-------------------#
		5)
		clear && printLogo && printComing && mainmenu
		;;
	#-------------------#
		6)
		elixir
		;;
	#-------------------#
		7)
		archive
		;;
	#-------------------#
		8)
		system
		;;
	#-------------------#
		0)
		echo $(printBCyan '	"Bye bye."') && exit
		;;
	#-------------------#
		*)
		clear && printLogo
echo -ne "$(printCyanBlink '                  =====================')
$(printRed  ' ================')$(printCyanBlink ' = ')$(printBMagenta 'Добро пожаловать!')$(printCyanBlink ' = ')$(printRed  '================') 
$(printCyanBlink '                  =====================')"
		mainmenu
		;;
	#-------------------#

	esac
}
#-----------------------------------------------------------------------------------#

########################################
#--------------------------Ссылки на меню управления нодой	   #
########################################
	elixir(){
		
	}

	starknet(){
		source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/starknet/main.sh)
	}

	celestia(){
		source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/celestia/main.sh)
	}

	nibiru(){
		source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/nibiru/main.sh)
	}

	defund(){
		source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/defund/main.sh)
	}

	shardeum(){
		source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/shardeum/main.sh)
	}

	sui(){
		source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/sui/main.sh)
	}

	quasar() {
		source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/quasar/main.sh)
	}
########################################
#  			Системный монитор	 	   #
########################################
	system(){
		source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/sm.sh)
	}
########################################
#  		    	Архив нод	 		   #
########################################
	archive(){
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh) && printLogo

	echo -ne "$(printCyanBlink '                  =====================')
$(printRed  ' ================')$(printCyanBlink ' = ')$(printBYellow '      Архив')$(printCyanBlink '       = ')$(printRed  '================') 
$(printCyanBlink '                  =====================')"
########################################
#  		    Меню  Архив нод	 		   #
########################################
echo -ne "

		$(printBCyan ' -->') $(printBYellow    '1)') Celestia $(printBTYellow '*****')
		$(printBCyan ' -->') $(printBYellow    '2)') Quasar $(printBTYellow '*****')
		$(printBCyan ' -->') $(printBYellow    '3)') SUI $(printBTYellow '*****')
		
		$(printBBlue ' <-- 4) Назад')
		
	Введите цифру:  "
	read -r ans
	case $ans in

		1)
		celestia
		;;

		2)
		quasar
		;;

		3)
		sui
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


mainmenu