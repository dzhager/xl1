#! /bin/bash

#X-l1bra  
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)
printLogo
printsui

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
		printLogo
		printsui
		echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		mainmenu
		;;
	esac
}

no(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/sui/main.sh)
}

yes(){
clear
printLogo
printsui
echo -ne "	

$(printBYellow 'Удаляем.....!')"
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
		source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/sui/main.sh)
		;;
	esac
}


mainmenu
