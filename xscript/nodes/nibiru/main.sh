#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/common.sh) && printlogo && printNibiru
#-----------------------------------------------------------------------------------------#

#-------------------------------------Основное меню---------------------------------------#
	mainmenu() { 
		echo
		echo "$(printBCyan '               --> ') $(printBCyan    '1) Управление')"
		echo
		echo "$(printBCyan '               --> ') $(printBGreen    '2) Установить')"
		echo "$(printBCyan '               --> ') $(printBYellow    '3) Обновить')"
		echo "$(printBCyan '               --> ') $(printBRed    '4) Удалить')"
		echo
		echo "$(printBBlue '               <--  5) Назад')"
		echo
		echo "$(printBRed       '                    0) Выход')"
		echo
		echo -ne "$(printBCyan ' Введите цифру: --> ')"
	#-------------------------Свойства меню-------------------------#	
		read -r ans
			case $ans in
				1)
				source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/nibiru/control.sh)
				;;
				3)
				source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/nibiru/update.sh)
				;;
				2)
				source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/nibiru/install.sh)
				;;
				4)
				source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/nibiru/delet.sh)
				;;
				5)
				./x-l1bra
				;;
				0)
				echo $(printBCyan '	"Bye bye."')
				rm x-l1bra
				exit
				;;
				*)
				clear
				printLogo
				printnibiru
				echo
				echo
				echo    -ne "$(printRed '		   Неверный запрос !')"
				echo
				mainmenu
				;;
			esac
				}
				
mainmenu