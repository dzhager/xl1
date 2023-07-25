#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/common.sh) && printlogo && printstarknet
#-----------------------------------------------------------------------------------------#

mainmenu() {
    echo -ne "
    
	  $(printBRed    'Вы действительно хотите удалить Starknet ') $(printBRedBlink '!!!')
	  
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
		printstarknet
		echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		mainmenu
		;;
	esac
}

no(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/active/starknet/main.sh)
}

yes(){
clear
printlogo
printstarknet
echo -ne "	

$(printBYellow 'Удаляем.....!')"
echo
cd $HOME
echo
sudo systemctl stop starknetd.service
sudo systemctl disable starknetd.service
sudo rm /etc/systemd/system/starknetd.service
rm -rf /usr/local/bin/pathfinder
rm -rf .cargo pathfinder .rustup
sudo apt remove python3 -y
submenu
}

submenu(){
	echo -ne "
	$(printBGreen    'Starknet полностью удален с вашего сервера ')$(printBGreenBlink '!!!')
	
	Нажмите Enter:  "
	read -r ans
	case $ans in
		*)
		source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/active/starknet/main.sh)
		;;
	esac
}


mainmenu