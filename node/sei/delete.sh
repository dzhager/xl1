#! /bin/bash

#X-l1bra  
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)
printLogo
printsei

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
		printsei
		echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		mainmenu
		;;
	esac
}

no(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/quasar/main.sh)
}

yes(){
clear
printLogo
printsei
echo -ne "	

$(printBYellow 'Удаляем.....!')"
cd $HOME
sudo systemctl stop seid
sudo systemctl disable seid
sudo rm /etc/systemd/system/seid.service
sudo systemctl daemon-reload
rm -f $(which seid)
rm -rf $HOME/.sei
rm -rf $HOME/sei-chain
submenu
}

submenu(){
	echo -ne "
	$(printBGreen    'Sei полностью удален с вашего сервера ')$(printBGreenBlink '!!!')
	
	Нажмите Enter:  "
	read -r ans
	case $ans in
		*)
		source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/sei/main.sh)
		;;
	esac
}


mainmenu