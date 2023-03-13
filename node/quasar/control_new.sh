#!/bin/bash

#X-l1bra  
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)
printLogo
printquasar
echo
mainmenu() {
	echo -ne "
		
	    $(printBCyan ' -->') $(printBYellow    '1)') Проверить баланс
	    $(printBCyan ' -->') $(printBYellow    '2)') Отправить монеты
	    $(printBCyan ' -->') $(printBYellow    '3)') Показать адрес кошелька
	    $(printBCyan ' -->') $(printBYellow    '4)') Добавить кошелек wallet
	    $(printBCyan ' -->') $(printBYellow    '5)') Восстановить кошелек
		
	    $(printBCyan ' -->') $(printBYellow    '6)') Делегировать
	    $(printBCyan ' -->') $(printBYellow    '7)') Делегировать самому себе
	    $(printBCyan ' -->') $(printBYellow    '8)') Создать валидатора
	    $(printBCyan ' -->') $(printBYellow    '9)') Узнать информацию о валидаторе
	    $(printBCyan ' -->') $(printBYellow    '10)') Проголосовать за валидатора
	    
	    $(printBCyan ' -->') $(printBYellow    '11)') Загрузить последний снапшот
	    $(printBCyan ' -->') $(printBYellow    '12)') Проверить синхронизацию
	    $(printBCyan ' -->') $(printBYellow    '13)') Просмотреть логи
	
	    $(printBBlue ' <--') $(printBBlue    '14) Вернутся назад')
		 $(printBRed    ' 0) Выйти')
		 
	$(printCyan 'Введите цифру:')  "
	read -r ans
	case $ans in
		1)
		WalletBalance
		;;
		
		2)
		Send
		;;
		
		3)
		ShowWallet
		;;
		
		4)
		AddWallet
		
		;;
		
		5)
		RecoveryWallet
		;;
		
		6)
		Delegate
		;;
		
		7)
		DelegateYourself
		;;
		
		8)
		CreateValidator
		;;
		
		9)
		InfoValidator
		;;

		10)
		
		
		11)
		snapshot
		;;

		12)
		synced
		;;
		
		13)
		logs
		;;
		
		14)
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
		printquasar
		echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		mainmenu
		;;
	esac
}

WalletBalance(){
	clear && printLogo && printquasar
	echo
	quasard q bank balances $(quasard keys show wallet -a)
	mainmenu
}

ShowWallet(){
	clear && printLogo && printquasar
	echo
	quasard keys list
	mainmenu
}

AddWallet(){
	clear && printLogo && printquasar
	echo
	quasard keys add wallet
	echo
	echo -ne "$(printCyanBlink '       ============================================')
	$(printCyanBlink '       = ')$(printBRed 'ОБЯЗАТЕЛЬНО СОХРАНИТЕ МНЕМОНИК ФРАЗУ !!!')$(printCyanBlink ' = ')
	$(printCyanBlink '       ============================================')"
	mainmenu
}

Send(){
	read -r -p "  Введите адрес кошелька:  " VAR1
	echo
	echo -ne "(printBRed ' 1uqs = 1000000uqsr')"
	read -r -p "  Введите количество монет uqsr:  " VAR2
	quasard tx bank send wallet "$VAR1" "$VAR2"uqsr --from wallet --chain-id qsr-questnet-04
	mainmenu
}

RecoveryWallet(){
	clear && printLogo && printquasar
	echo
	quasard keys add wallet --recover
	mainmenu
}

Delegate(){
	clear && printLogo && printquasar
	echo
	read -r -p " Введите валопер адрес:  " VAR1
	echo -ne "$(printBRed ' 1uqs = 1000000uqsr')"
	echo
	read -r -p "  Введите количество монет uqsr:  " VAR2
	quasard tx staking delegate "$VAR1" "$VAR2"uqsr --from wallet --chain-id qsr-questnet-04 --gas-adjustment 1.4 --gas auto --gas-prices 0uqsr -y
	echo
	mainmenu
}

DelegateYourself(){
	clear && printLogo && printquasar
	echo
	echo -ne "$(printBRed ' 1uqs = 1000000uqsr')"
	echo
	read -r -p "  Введите количество монет uqsr:  " VAR2
	quasard tx staking delegate $(quasard keys show wallet --bech val -a) "$VAR2"uqsr --from wallet --chain-id qsr-questnet-04 --gas-adjustment 1.4 --gas auto --gas-prices 0uqsr -y
	echo
	mainmenu
}


CreateValidator(){
	clear && printLogo && printquasar
	echo
	read -r -p "  Введите имя валидатора:  " VAR1
	quasard tx staking create-validator --amount=1000000uqsr --pubkey=$(quasard tendermint show-validator) --moniker="$VAR1" --identity=8F3C23EC3306B513 --chain-id=qsr-questnet-04 --commission-rate=0.05 --commission-max-rate=0.20 --commission-max-change-rate=0.01 --min-self-delegation=1 --from=wallet --gas-adjustment=1.4 --gas=auto --gas-prices=0uqsr 
	echo
	echo -ne "$(printBRed 'Вы должны позаботится забэкапить priv_validator_key.json.
	Без него вы не сможете восстановить валидатора.')"
	echo
	mainmenu
}

InfoValidator(){
	clear && printLogo && printquasar
	quasard q staking validator $(quasard keys show wallet --bech val -a)
	mainmenu
}

voit(){
		clear && printLogo && printquasar
	echo -ne "
	Ваш голос учтен!"
	quasard tx gov vote 1 yes --from wallet --chain-id qsr-questnet-04 --gas-adjustment 1.4 --gas auto --gas-prices 0uqsr -y
	echo
	mainmenu
}

snapshot(){
	clear && printLogo && printquasar
	echo
	subsubmenu
}

synced(){
	clear && printLogo && printquasar
	quasard status 2>&1 | jq .SyncInfo
	mainmenu
}

logs(){
	submenu
}

back(){
	source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/quasar/main.sh)
}

submenu(){
    echo -ne "
	$(printYellow    'Для того что бы остановить журнал логов надо нажать') $(printBCyan 'CTRL+Z') $(printYellow '!!!')

	Для продолжения нажмите Enter:  "
	read -r ans
	case $ans in
		*)
		sudo journalctl -u quasard -f --no-hostname -o cat
		mainmenu
		;;
	esac
}

subsubmenu() {
	echo -ne "
	Снимки позволяют новому узлу присоединиться к сети, восстанавливая состояние приложения из файла резервной копии.  
	Снапшот содержит сжатую копию каталога данных цепочки.  
	Чтобы файлы резервных копий были как можно меньше, сервер моментальных снимков периодически синхронизируется.
	$(printCyan	'Вы действительно хотите обновить каталог данных цепочки') $(printCyanBlink '???')
	$(printGreen	' 1) Да')
	$(printRed	' 2) Нет')
	$(printCyan	'Введите цифру:') "
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
		printquasar
		echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		mainmenu
        ;;
    esac
}


no(){
	source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/quasar/control.sh)
}

yes(){
	clear
	printLogo
	printquasar
	echo
	echo
	sudo systemctl stop quasard
	cp $HOME/.quasarnode/data/priv_validator_state.json $HOME/.quasarnode/priv_validator_state.json.backup
	rm -rf $HOME/.quasarnode/data
	curl -L https://snapshots.kjnodes.com/quasar-testnet/snapshot_latest.tar.lz4 | tar -Ilz4 -xf - -C $HOME/.quasarnode
	mv $HOME/.quasarnode/priv_validator_state.json.backup $HOME/.quasarnode/data/priv_validator_state.json
	sudo systemctl start quasard
	mainmenu
}

mainmenu