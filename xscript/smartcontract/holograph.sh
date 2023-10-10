#!/bin/bash


#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/common.sh) && printlogo && printholograph
#-----------------------------------------------------------------------------------------#

#-------------------------------------Основное меню---------------------------------------#
	mainmenu() {
    echo
		echo "$(printBCyan '            -->') $(printBCyan    '1) Deploying a Collection')"
		echo "$(printBCyan '            -->') $(printBCyan    '2) Minting an NFT')"
		echo "$(printBCyan '            -->') $(printBGreen   '3) Bridging an NFT)"
		echo
		echo "$(printBBlue '            <-- 4) Назад')"
		echo "$(printBRed        '                0) Выход')" 
    echo
 		echo -ne "$(printBGreen ' Введите цифру:') $(printYellowBlink '-->') "
	#-------------------------Свойства меню-------------------------#
		read -r ans
			case $ans in
		#---------------------------------------#
			1)
			Deploying
			;;
		#---------------------------------------#
			2)
			Minting
			;;
		#---------------------------------------#
			3)
			Bridging
			;;
		#---------------------------------------#	
			4)
			source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/menu/menusmart.sh)
			;;
		#---------------------------------------#
			0)
			echo $(printBCyan '	"Bye bye."')
			exit
			;;
		#---------------------------------------#	
			*)
			clear && printlogo
			echo " $(printCyanBlink '                 =====================')"
			echo " $(printRed  '================')$(printCyanBlink ' = ')$(printBRed 'Неверный запрос! ')$(printCyanBlink ' = ')$(printRed  '================')"
			echo " $(printCyanBlink '                 =====================')"
			mainmenu
			;;
		#---------------------------------------#
			esac
}

Deploying(){
	clear && printlogo && printholograph && echo
  holograph create:contract
mainmenu
}

Minting(){
	clear && printlogo && printholograph
	echo
  holograph create:nft
	mainmenu
}

Bridging(){
  echo
  holograph bridge:nft
	mainmenu
}


back(){
  source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/menu/menusmart.sh)
}

mainmenu
