#! /bin/bash

#X-l1bra  
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)
printLogo
printshardium

mainmenu() { echo -ne "

		$(printBCyan ' -->') $(printBGreen    '1) Установить')
		$(printBCyan ' -->') $(printBYellow    '2) Обновить на 1.1.7')
		$(printBCyan ' -->') $(printBRed    '3) Удалить')

		$(printBBlue ' <-- 4) Назад')
		$(printBRed        '     0) Выход')

 	Введите цифру: "

read -r ans
	case $ans in
		1)
		install
		;;
		2)
		update
		;;
		3)
		delet
		;;
		4)
		back
		;;
		0)
		echo $(printBCyan '"Bye bye."')
		rm x-l1bra
		exit
		;;
		*)
		clear
		printLogo
		printshardium
		echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		mainmenu
		;;
	esac
}

install(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/shardeum/install.sh)
}


delet(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/shardeum/delet.sh)
}

back(){
./x-l1bra
}

#--------------ОБНОВЛЕНИЕ 1.1.6
update(){
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)
	printLogo
	printshardium
	cd $HOME
	curl -O https://gitlab.com/shardeum/validator/dashboard/-/raw/main/installer.sh && chmod +x installer.sh && ./installer.sh
	echo -ne "
			    $(printBGreen    'Обновление завершено!')
			    Далее нужно выйти из скрипта и выполнить команды по очереди:
			    
			    $(printBYellow 'cd .shardeum && ./shell.sh')
			    
			    $(printBYellow 'operator-cli gui start')
			    
			    $(printBYellow 'operator-cli start')

			    Проверить работу ноды можно командой:
			    $(printBYellow 'pm2 list')"

	mainmenu

}


mainmenu