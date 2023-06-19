#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/common.sh) && printlogo && printshardium
#-----------------------------------------------------------------------------------------#

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
		printlogo
		printshardium
		echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		mainmenu
		;;
	esac
}


stake(){
	clear && printlogo && printshardium
	echo
	read -r -p "  
$(printCyan 'Введите количество монет SHM :')  " VAR2
	echo
	docker exec -i shardeum-dashboard /bin/bash -c "export PRIV_KEY="$PRIV_KEY" && operator-cli stake "$VAR2""
	echo
	mainmenu
}

unstake(){
	clear && printlogo && printshardium
	echo
	read -r -p " 
$(printBYellow 'Вы можете вывести все монеты со стейка просто нажав Enter или
		 введите нужное количество монет SHM:')  " VAR1
	echo
	docker exec -i shardeum-dashboard /bin/bash -c "export PRIV_KEY="$PRIV_KEY" && operator-cli unstake "$VAR1""
	echo
	mainmenu
}
stakeinfo(){
	clear && printlogo && printshardium
	echo
	docker exec -i shardeum-dashboard /bin/bash -c "operator-cli stake_info "$METAMASK""
	echo
	mainmenu
}

status(){
	clear && printlogo && printshardium
	echo
	docker exec -i shardeum-dashboard /bin/bash -c "operator-cli status"
	echo
	mainmenu
}

pm2(){
	clear && printlogo && printshardium
	echo
	docker exec -i shardeum-dashboard /bin/bash -c "pm2 ls"
	echo
	mainmenu
}

version(){
	clear && printlogo && printshardium
	echo
	docker exec -i shardeum-dashboard /bin/bash -c "operator-cli version"
	echo
	mainmenu
}

privkey(){
	clear && printlogo && printshardium
	echo -ne "
$(printCyan 'Вставте приватный ключ Metamask') "
	read -r PRIV_KEY
	echo "export PRIV_KEY="$PRIV_KEY"" >> ~/.bash_profile && source ~/.bash_profile
	echo
	mainmenu
}

metamask(){
	clear && printlogo && printshardium
	echo -ne "
$(printCyan 'Вставте адрес Metamask') "
	read -r METAMASK
	echo "export METAMASK="$METAMASK"" >> ~/.bash_profile && source ~/.bash_profile
	echo
	mainmenu
}

guistart(){
	clear && printlogo && printshardium
	echo
	docker exec -i shardeum-dashboard /bin/bash -c "operator-cli gui start"
	echo
	mainmenu
}

clistart(){
	clear && printlogo && printshardium
	echo
	docker exec -i shardeum-dashboard /bin/bash -c "operator-cli start"
	echo
	mainmenu
}

back(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/active/shardeum/main.sh)
}

mainmenu