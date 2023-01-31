#! /bin/bash

#X-l1bra  
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)
printLogo
printnibiru

mainmenu() {
    echo -ne "
    
	  $(printBRed    'Вы действительно хотите удалить Nibiru ') $(printBRedBlink '!!!')
	  
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
		printnibiru
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
printnibiru
echo -ne "	

$(printBYellow 'Удаляем.....!')"
systemctl stop nibid.service && rm -rf /etc/systemd/system/nibid.service && rm -rf /usr/bin/nibid && rm -rf nibiru && rm -rf .nibid
submenu
}

submenu(){
	echo -ne "
	$(printBGreen    'Nibiru полностью удалена с вашего сервера ')$(printBGreenBlink '!!!')
	
	Нажмите Enter:  "
	read -r ans
	case $ans in
		*)
		source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/nibiru/main.sh)
		;;
	esac
}


mainmenu
