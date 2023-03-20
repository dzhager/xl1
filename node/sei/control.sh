#!/bin/bash

#X-l1bra  
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)
printLogo
printsei
echo
mainmenu() {
	echo -ne "
	    $(printBCyan ' -->') $(printBYellow    '1)') Проверить баланс
	    $(printBCyan ' -->') $(printBYellow    '2)') Отправить монеты
	    $(printBCyan ' -->') $(printBYellow    '3)') Показать адрес кошелька
	    $(printBCyan ' -->') $(printBYellow    '4)') Добавить кошелек wallet
	    $(printBCyan ' -->') $(printBYellow    '5)') Восстановить кошелек
	
	    $(printBCyan ' -->') $(printBYellow    '6)') Делегировать кому-то
	    $(printBCyan ' -->') $(printBYellow    '7)') Делегировать самому себе
	    $(printBCyan ' -->') $(printBYellow    '8)') Создать валидатора
	    $(printBCyan ' -->') $(printBYellow    '9)') Узнать информацию о валидаторе
	    
	    $(printBCyan ' -->') $(printBYellow    '10)') Загрузить последний снапшот
	    $(printBCyan ' -->') $(printBYellow    '11)') Проверить синхронизацию
	    $(printBCyan ' -->') $(printBYellow    '12)') Просмотреть логи
	
	    $(printBBlue ' <--') $(printBBlue    '13) Вернутся назад')
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
		snapshot
		;;

		11)
		synced
		;;
		
		12)
		logs
		;;
		
		13)
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
		printsei
		echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		mainmenu
		;;
	esac
}

WalletBalance(){
clear && printLogo && printsei
echo
seid q bank balances $(seid keys show wallet -a)
mainmenu
}

ShowWallet(){
clear && printLogo && printsei
echo
seid keys list
mainmenu
}

AddWallet(){
clear && printLogo && printsei
echo
seid keys add wallet
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
seid tx bank send wallet "$VAR1" "$VAR2"usei --from wallet --chain-id atlantic-2 --gas-adjustment 1.4 --gas auto --gas-prices 0.0001usei -y
mainmenu
}

RecoveryWallet(){
clear && printLogo && printsei
echo
seid keys add wallet --recover
mainmenu
}

Delegate(){
clear && printLogo && printsei
echo
read -r -p " Введите валопер адрес:  " VAR1
echo -ne "$(printBRed ' 1sei = 1000000usei')"
echo
read -r -p "  Введите количество монет usei:  " VAR2
seid tx staking delegate "$VAR1" "$VAR2"usei --from wallet --chain-id atlantic-2 --gas-adjustment 1.4 --gas auto --gas-prices 0.0001usei -y
echo
mainmenu
}

DelegateYourself(){
clear && printLogo && printsei
echo
echo -ne "$(printBRed ' 1sei = 1000000usei')"
echo
read -r -p "  Введите количество монет uqsr:  " VAR2
seid tx staking delegate $(seid keys show wallet --bech val -a) "$VAR2"usei --from wallet --chain-id atlantic-2 --gas-adjustment 1.4 --gas auto --gas-prices 0.0001usei -y
echo
mainmenu
}


CreateValidator(){
clear && printLogo && printsei
echo
read -r -p "  Введите имя валидатора:  " VAR1
seid tx staking create-validator --amount 1000000usei --pubkey $(seid tendermint show-validator) --moniker="$VAR1" --chain-id atlantic-2 --commission-rate 0.05 --commission-max-rate 0.20 --commission-max-change-rate 0.01 --min-self-delegation 1 --from wallet --gas-adjustment 1.4 --gas auto --gas-prices 0.0001usei
echo
echo -ne "$(printBRed 'Вы должны позаботится забэкапить priv_validator_key.json.
Без него вы не сможете восстановить валидатора.')"
echo
mainmenu
}

InfoValidator(){
clear && printLogo && printsei
seid q staking validator $(seid keys show wallet --bech val -a)
mainmenu
}


snapshot(){
	clear && printLogo && printsei
	echo
	subsubmenu
}


synced(){
clear && printLogo && printsei
seid status 2>&1 | jq .ValidatorInfo
mainmenu
}

logs(){
submenu
}

back(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/sei/main.sh)
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
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/quasar/control.sh)
}
yes(){
clear
printLogo
printsei
echo
echo
sudo systemctl stop seid
cp $HOME/.sei/data/priv_validator_state.json $HOME/.sei/priv_validator_state.json.backup
rm -rf $HOME/.sei/data
curl -L https://snapshots.kjnodes.com/sei-testnet/snapshot_latest.tar.lz4 | tar -Ilz4 -xf - -C $HOME/.sei
mv $HOME/.sei/priv_validator_state.json.backup $HOME/.sei/data/priv_validator_state.json
sudo systemctl start seid
mainmenu
}

mainmenu