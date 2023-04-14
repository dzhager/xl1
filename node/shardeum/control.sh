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
		$(printBCyan ' -->') $(printBYellow    '4)') Validator status
		$(printBCyan ' -->') $(printBYellow    '5)') pm2 list
		$(printBCyan ' -->') $(printBYellow    '6)') Version info

		$(printBGreen 'Connect Wallet')
		$(printBCyan ' -->') $(printBYellow    '7)') Ввести адрес Metamask		
		$(printBCyan ' -->') $(printBYellow    '8)') Ввести закрытый ключ Metamask

		$(printBGreen 'System')
		$(printBCyan ' -->') $(printBYellow    '9)') Operator GUI start
		$(printBCyan ' -->') $(printBYellow    '10)') Operator CLI start

		$(printBBlue ' <--') $(printBBlue    '11) Вернутся назад')
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
		status
		;;

		5)
		pm2
		;;

		6)
		version
		;;

		7)
		metamask
		;;

		8)
		privkey
		;;

		9)
		guistart
		;;

		10)
		clistart
		;;

		11)
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
	read -r -p "  
$(printCyan 'Введите количество монет SHM :')  " VAR2
	echo
	docker exec -i shardeum-dashboard /bin/bash -c "export PRIV_KEY="$PRIV_KEY" && env && operator-cli stake "$VAR2""
	echo
	mainmenu
}

unstake(){
	clear && printLogo && printshardium
	echo
	read -r -p " 
$(printBYellow 'Вы можете вывести все монеты со стейка просто нажав Enter или
		 введите нужное количество монет SHM:')  " VAR1
	echo
	docker exec -i shardeum-dashboard /bin/bash -c "export PRIV_KEY="$PRIV_KEY" && env && operator-cli unstake "$VAR1""
	echo
	mainmenu
}
stakeinfo(){
	clear && printLogo && printshardium
	echo
	docker exec -i shardeum-dashboard /bin/bash -c "operator-cli stake_info "$METAMASK""
	echo
	mainmenu
}

status(){
	clear && printLogo && printshardium
	echo
	docker exec -i shardeum-dashboard /bin/bash -c "operator-cli status"
	echo
	mainmenu
}

pm2(){
	clear && printLogo && printshardium
	echo
	docker exec -i shardeum-dashboard /bin/bash -c "pm2 ls"
	echo
	mainmenu
}

version(){
	clear && printLogo && printshardium
	echo
	docker exec -i shardeum-dashboard /bin/bash -c "operator-cli version"
	echo
	mainmenu
}

privkey(){
	clear && printLogo && printshardium
	echo -ne "
$(printCyan 'Вставте приватный ключ Metamask') "
	read -r PRIV_KEY
	echo "export PRIV_KEY="$PRIV_KEY"" >> ~/.bash_profile && source ~/.bash_profile
	echo
	mainmenu
}

metamask(){
	clear && printLogo && printshardium
	echo -ne "
$(printCyan 'Вставте адрес Metamask') "
	read -r METAMASK
	echo "export METAMASK="$METAMASK"" >> ~/.bash_profile && source ~/.bash_profile
	echo
	mainmenu
}

guistart(){
	clear && printLogo && printshardium
	echo
	docker exec -i shardeum-dashboard /bin/bash -c "operator-cli gui start"
	echo
	mainmenu
}

clistart(){
	clear && printLogo && printshardium
	echo
	docker exec -i shardeum-dashboard /bin/bash -c "operator-cli start"
	echo
	mainmenu
}

back(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/shardeum/main.sh)
}

mainmenu