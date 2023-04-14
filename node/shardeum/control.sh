#!/bin/bash

#X-l1bra  
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)
printLogo
printshardium
echo
mainmenu() {
	echo -ne "
		$(printBGreen 'CLI')
		$(printBCyan ' -->') $(printBYellow    '1)') Stake
		$(printBCyan ' -->') $(printBYellow    '2)') Unstake
		$(printBCyan ' -->') $(printBYellow    '3)') Stake Info

		$(printBGreen 'Validator')
		$(printBCyan ' -->') $(printBYellow    '4)') Проверить статус
		$(printBCyan ' -->') $(printBYellow    '5)') pm2 list
		$(printBCyan ' -->') $(printBYellow    '6)') Просмотр версии

		$(printBGreen 'Connect Wallet')
		$(printBCyan ' -->') $(printBYellow    '7)') Ввести адрес Metamask		
		$(printBCyan ' -->') $(printBYellow    '8)') Ввести закрытый ключ Metamask

		$(printBBlue ' <--') $(printBBlue    '9) Вернутся назад')
		 $(printBRed    ' 0) Выйти')
		 
	$(printCyan 'Введите цифру:')  "
	read -r ans
	case $ans in
		1)
		stake
		;;
		
		2)
		unstake
		;;

		3)
		stakeinfo
		;;
		
		4)
		stakeinfo
		;;

		9)
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
		printnibiru
		echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		mainmenu
		;;
	esac
}


stake(){
	clear && printLogo && printshardium
	echo
	read -r -p "  Введите количество монет SHM:  " VAR2
	echo
	docker exec -i shardeum-dashboard /bin/bash -c "export PRIV_KEY="$PRIV_KEY" && env && operator-cli stake "$VAR2""
	echo
	mainmenu
}

unstake(){
	clear && printLogo && printshardium
	echo
	read -r -p " Вы можете вывести все монеты со стейка просто нажав Enter или
		 введите нужное количество монет SHM:  " VAR1
	echo
	docker exec -i shardeum-dashboard /bin/bash -c "export PRIV_KEY="$PRIV_KEY" && env && operator-cli unstake "$VAR1""
	echo
	mainmenu
}


privkey(){
	clear && printLogo && printshardium
	echo
	read -r PRIV_KEY
	source ~/.bashrc
	echo
	mainmenu
}

metamask(){
	clear && printLogo && printshardium
	echo
	read -r METAMASK
	source ~/.bashrc
	echo
	mainmenu
}



back(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/shardeum/main.sh)
}

submenu(){
    echo -ne "
$(printYellow    'Для того что бы остановить журнал логов надо нажать') $(printBCyan 'CTRL+Z') $(printYellow '!!!')

Для продолжения нажмите Enter:  "
	read -r ans
	case $ans in
		*)
		sudo journalctl -u nibid -f --no-hostname -o cat
		mainmenu
		;;
	esac
}

mainmenu