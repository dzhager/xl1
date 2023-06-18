#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/common.sh) && printlogo && printQuasar
#-----------------------------------------------------------------------------------------#

mainmenu() {
    echo -ne "
    
	  $(printBRed    'Вы действительно хотите удалить Quasar ') $(printBRedBlink '!!!')
	  
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
		printLogo
		printQuasar
		echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		mainmenu
		;;
	esac
}

no(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/archive/quasar/main.sh)
}

yes(){
clear
printLogo
printQuasar
echo -ne "	

$(printBYellow 'Удаляем.....!')"
cd $HOME
sudo systemctl stop quasard
sudo systemctl disable quasard
sudo rm /etc/systemd/system/quasard.service
sudo systemctl daemon-reload
rm -f $(which quasard)
rm -rf $HOME/.quasarnode
submenu
}

submenu(){
	echo -ne "
	$(printBGreen    'Quasar полностью удален с вашего сервера ')$(printBGreenBlink '!!!')
	
	Нажмите Enter:  "
	read -r ans
	case $ans in
		*)
		source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/archive/quasar/main.sh)
		;;
	esac
}


mainmenu