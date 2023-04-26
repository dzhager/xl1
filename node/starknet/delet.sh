

#! /bin/bash

#X-l1bra  
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)
printLogo
printstarknet

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
		printLogo
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
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/nibiru/main.sh)
}

yes(){
clear
printLogo
printstarknet
echo -ne "	

$(printBYellow 'Удаляем.....!')"
cd $HOME
sudo systemctl stop starknetd.service
sudo systemctl disable starknetd.service
sudo rm /etc/systemd/system/starknetd.service
rm -rf /usr/local/bin/pathfinder
rm -rf .cargo pathfinder .rustup
submenu
}

submenu(){
	echo -ne "
	$(printBGreen    'Starknet полностью удален с вашего сервера ')$(printBGreenBlink '!!!')
	
	Нажмите Enter:  "
	read -r ans
	case $ans in
		*)
		source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/starknet/main.sh)
		;;
	esac
}


mainmenu