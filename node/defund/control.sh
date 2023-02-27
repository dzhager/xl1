#!/bin/bash

#X-l1bra  
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)
printLogo
printdefund
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
	    $(printBCyan ' -->') $(printBYellow    '10)') Статус валидатора
	    
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
		StatusValidator
		;;

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
		printdefund
		echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		mainmenu
		;;
	esac
}

WalletBalance(){
clear && printLogo && printdefund
echo
defundd q bank balances $(defundd keys show wallet -a)
mainmenu
}

ShowWallet(){
clear && printLogo && printdefund
echo
defundd keys list
mainmenu
}

AddWallet(){
clear && printLogo && printdefund
defundd keys add wallet
echo
echo -ne "$(printCyanBlink '       ============================================')
$(printCyanBlink '       = ')$(printBRed 'ОБЯЗАТЕЛЬНО СОХРАНИТЕ МНЕМОНИК ФРАЗУ !!!')$(printCyanBlink ' = ')
$(printCyanBlink '       ============================================')"
mainmenu
}

Send(){
read -r -p "  Введите адрес кошелька:  " VAR1
echo
echo -ne "(printBRed ' 1fetf = 1000000ufetf')"
read -r -p "  Введите количество монет ufetf:  " VAR2
defundd tx bank send wallet "$VAR1" "$VAR2"ufetf --from wallet --chain-id defund-private-4
mainmenu
}

RecoveryWallet(){
clear && printLogo && printdefund
echo
defundd keys add wallet --recover
mainmenu
}

Delegate(){
clear && printLogo && printdefund
echo
read -r -p " Введите валопер адрес:  " VAR1
echo -ne "$(printBRed ' 1fetf = 1000000ufetf')"
echo
read -r -p "  Введите количество монет ufetf:  " VAR2
defundd tx staking delegate "$VAR1" "$VAR2"ufetf --from wallet --chain-id defund-private-4 --gas-adjustment 1.4 --gas auto --gas-prices 0ufetf -y
echo
mainmenu
}

DelegateYourself(){
clear && printLogo && printdefund
echo
echo -ne "$(printBRed ' 1fetf = 1000000ufetf')"
echo
read -r -p "  Введите количество монет ufetf:  " VAR2
defundd tx staking delegate $(defundd keys show wallet --bech val -a) "$VAR2"ufetf --from wallet --chain-id defund-private-4 --gas-adjustment 1.4 --gas auto --gas-prices 0ufetf -y
echo
mainmenu
}


CreateValidator(){
clear && printLogo && printdefund
echo
read -r -p "  Введите имя валидатора:  " VAR1
nibid tx staking create-validator --amount 1000000unibi --commission-max-change-rate "0.1" --commission-max-rate "0.20" --commission-rate "0.1" --min-self-delegation "1" --pubkey=$(nibid tendermint show-validator) --moniker="$VAR1" --identity=8F3C23EC3306B513 --chain-id nibiru-testnet-2 --gas-prices 0.025unibi --from wallet
echo
echo -ne "$(printBRed 'Вы должны позаботится забэкапить priv_validator_key.json.
Без него вы не сможете восстановить валидатора.
Он находится в папке .nibid/config ') $(printBRedBlink '!!!') "
echo
mainmenu
}

StatusValidator(){
	clear && printLogo && printdefund
	echo
	echo
	defundd status 2>&1 | jq .ValidatorInfo
	echo
	mainmenu
}

InfoValidator(){
clear && printLogo && printdefund
echo
defundd q staking validator $(defundd keys show wallet --bech val -a)
mainmenu
}


snapshot(){
	clear && printLogo && printdefund
	echo
	subsubmenu
}


synced(){
clear && printLogo && printdefund
defundd status 2>&1 | jq .SyncInfo
mainmenu
}

logs(){
submenu
}

back(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/defund/main.sh)
}

submenu(){
    echo -ne "
$(printYellow    'Для того что бы остановить журнал логов надо нажать') $(printBCyan 'CTRL+Z') $(printYellow '!!!')

Для продолжения нажмите Enter:  "
	read -r ans
	case $ans in
		*)
		sudo journalctl -u defundd -f --no-hostname -o cat
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
		printdefund
		echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		mainmenu
        ;;
    esac
}


no(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/defund/control.sh)
}
yes(){
clear
printLogo
printdefund
echo
echo
sudo systemctl stop defundd
cp $HOME/.defund/data/priv_validator_state.json $HOME/.defund/priv_validator_state.json.backup
rm -rf $HOME/.defund/data
curl -L https://snapshots.kjnodes.com/defund-testnet/snapshot_latest.tar.lz4 | tar -Ilz4 -xf - -C $HOME/.defund
mv $HOME/.defund/priv_validator_state.json.backup $HOME/.defund/data/priv_validator_state.json
sudo systemctl start defundd
mainmenu
}

mainmenu


