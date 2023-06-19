#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/common.sh) && printlogo && printSui
#-----------------------------------------------------------------------------------------#


mainmenu() {
    echo -ne "
    
	  $(printBRed    'Вы действительно хотите удалить SUI ') $(printBRedBlink '!!!')
	  
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
		printSui
		echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		mainmenu
		;;
	esac
}

no(){
	source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/archive/sui/main.sh)
}

yes(){
clear
printlogo
printSui
echo -ne "	

$(printBYellow 'Удаляем.....!')"
echo
sudo systemctl stop suid && sudo systemctl disable suid && rm -rf $HOME/.sui && rm -rf $HOME/sui && rm -rf /var/sui && sudo rm -f /usr/bin/{sui,sui-node,sui-faucet} && sudo rm -f /usr/local/bin/{sui,sui-node,sui-faucet} && sudo rm /etc/systemd/system/suid.service && systemctl daemon-reload
submenu
}

submenu(){
	echo -ne "
	$(printBGreen    'SUI полностью удалена с вашего сервера ')$(printBGreenBlink '!!!')
	
	Нажмите Enter:  "
	read -r ans
	case $ans in
		*)
		source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/archive/sui/main.sh)
		;;
	esac
}


mainmenu
