#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/common.sh) && printlogo && printshardium
#-----------------------------------------------------------------------------------------#


mainmenu() {
    echo -ne "
    
	  $(printBRed    'Вы действительно хотите удалить Shardeum ') $(printBRedBlink '!!!')
	  
		$(printRed   '1) Да')
		$(printGreen '2) Нет')
		
	  $(printBCyan 'Введите цифру:') "
	read -r ans
	case $ans in
		1)
		yes
		;;
		2)
		no
		;;

		*)
		clear
		printlogo
		printshardium
		echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		mainmenu
		;;
	esac
}

no(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/active/shardeum/main.sh)
}

yes(){
clear
printlogo
printshardium
echo -ne "	

$(printBYellow 'Удаляем.....!')"
cd ~/.shardeum
./cleanup.sh
cd ~/
rm -rf .shardeum
rm installer.sh
submenu
}

submenu(){
	echo -ne "
	$(printBGreen    'Shardeum полностью удалена с вашего сервера ')$(printBGreenBlink '!!!')
	
	Нажмите Enter:  "
	read -r ans
	case $ans in
		*)
		source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/active/shardeum/main.sh)
		;;
	esac
}


mainmenu
