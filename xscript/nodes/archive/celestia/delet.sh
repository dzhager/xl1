#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/common.sh) && printlogo && printCelestia
#-----------------------------------------------------------------------------------------#

mainmenu() {
    echo -ne "
    
	  $(printBRed    'Вы действительно хотите удалить Celestia ') $(printBRedBlink '!!!')
	  
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
		printCelestia
		echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		mainmenu
		;;
	esac
}

no(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/archive/celestia/main.sh)
}

yes(){
clear
printLogo
printCelestia
echo -ne "	

$(printBYellow 'Удаляем.....!')"
cd $HOME
sudo systemctl stop celestia-appd
sudo systemctl disable celestia-appd
sudo rm /etc/systemd/system/celestia-appd.service
sudo systemctl daemon-reload
rm -f $(which celestia-appd)
rm -rf $HOME/.celestia-app
rm -rf $HOME/celestia-app
submenu
}

submenu(){
	echo -ne "
	$(printBGreen    'Celestia полностью удалена с вашего сервера ')$(printBGreenBlink '!!!')
	
	Нажмите Enter:  "
	read -r ans
	case $ans in
		*)
		source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/archive/celestia/main.sh)
		;;
	esac
}


mainmenu
