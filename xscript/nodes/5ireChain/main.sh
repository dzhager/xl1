#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/common.sh) && printlogo && print5ireChain
#-----------------------------------------------------------------------------------------#

#-------------------------------------Основное меню---------------------------------------#
	mainmenu() {
		echo
		echo "$(printBCyan '		-->') $(printBGreen '1) Установить')"
		echo
		echo "$(printBCyan '		-->') $(printBRed '2) Удалить')"
		echo
		echo "$(printBYellow '		<-- 3) Назад')"
		echo
		echo "$(printBRed '	            0)') $(printBRed 'Выход')"
		echo
		echo -ne "$(printBCyan ' Введите цифру: --> ')"

	#-------------------------Свойства меню-------------------------№
		read -r ans
			case $ans in
			#------------------------------#
				1)
				install
				;;
			#------------------------------#
				3)
				delet
				;;
			#------------------------------#
				3)
				back
				;;
			#------------------------------#
				0)
				echo $(printBCyan '	"Bye bye."') && exit
				;;
			#------------------------------#
				*)
				clear && printlogo && print5ireChain && echo && echo "$(printRedBlink '		   Неверный запрос !')"	 && mainmenu
				;;
			#------------------------------#	
			esac
	}
#-----------------------------------------------------------------------------------------#


#-------------------------------------Функции меню----------------------------------------#

	install(){
		source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/5ireChain/install.sh)
	}


	delet(){
		source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/5ireChain/delet.sh)
	}

	back(){
		./x-l1bra
	}

	mainmenu
#-----------------------------------------------------------------------------------------#