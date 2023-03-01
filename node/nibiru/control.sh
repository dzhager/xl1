#!/bin/bash

#X-l1bra  
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)
printLogo
printnibiru
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
		printnibiru
		echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		mainmenu
		;;
	esac
}

WalletBalance(){
clear && printLogo && printnibiru
echo
nibid q bank balances $(nibid keys show wallet -a)
mainmenu
}

ShowWallet(){
clear && printLogo && printnibiru
echo
nibid keys list
mainmenu
}

AddWallet(){
clear && printLogo && printnibiru
nibid keys add wallet
echo
echo -ne "$(printCyanBlink '       ============================================')
$(printCyanBlink '       = ')$(printBRed 'ОБЯЗАТЕЛЬНО СОХРАНИТЕ МНЕМОНИК ФРАЗУ !!!')$(printCyanBlink ' = ')
$(printCyanBlink '       ============================================')"
mainmenu
}

Send(){
read -r -p "  Введите адрес кошелька:  " VAR1
echo
echo -ne "(printBRed ' 1nibi = 1000000unibi')"
read -r -p "  Введите количество монет unibi:  " VAR2
nibid tx bank send wallet "$VAR1" "$VAR2"unibi --from wallet --chain-id nibiru-itn-1 --gas-prices 0.1unibi --gas-adjustment 1.5 --gas auto -y
mainmenu
}

RecoveryWallet(){
clear && printLogo && printnibiru
echo
nibid keys add wallet --recover
mainmenu
}

Delegate(){
clear && printLogo && printnibiru
echo
read -r -p " Введите валопер адрес:  " VAR1
echo -ne "$(printBRed ' 1nibi = 1000000unibi')"
echo
read -r -p "  Введите количество монет unibi:  " VAR2
nibid tx staking delegate "$VAR1" "$VAR2"unibi --from wallet --chain-id nibiru-itn-1 --gas-prices 0.1unibi --gas-adjustment 1.5 --gas auto -y
echo
mainmenu
}

DelegateYourself(){
clear && printLogo && printnibiru
echo
echo -ne "$(printBRed ' 1nibi = 1000000unibi')"
echo
read -r -p "  Введите количество монет unibi:  " VAR2
nibid tx staking delegate $(nibid keys show wallet --bech val -a) "$VAR2"unibi --from wallet --chain-id nibiru-itn-1 --gas-prices 0.1unibi --gas-adjustment 1.5 --gas auto -y 
echo
mainmenu
}


CreateValidator(){
clear && printLogo && printnibiru
echo
read -r -p "  Введите имя валидатора:  " VAR1
nibid tx staking create-validator --amount 1000000unibi --pubkey $(nibid tendermint show-validator) --moniker="$VAR1" --identity=8F3C23EC3306B513 --chain-id nibiru-itn-1 --commission-rate "0.05" --commission-max-rate "0.20" --commission-max-change-rate "0.01" --min-self-delegation "1" --from wallet --gas-adjustment "1.4" --gas auto --gas-prices 0.025unibi
echo
echo -ne "$(printBRed 'Вы должны позаботится забэкапить priv_validator_key.json.
Без него вы не сможете восстановить валидатора.
Он находится в папке .nibid/config ') $(printBRedBlink '!!!') "
echo
mainmenu
}

InfoValidator(){
clear && printLogo && printnibiru
nibid q staking validator $(nibid keys show wallet --bech val -a)
mainmenu
}


snapshot(){
	clear && printLogo && printnibiru
	echo
	subsubmenu
}


synced(){
clear && printLogo && printnibiru
nibid status 2>&1 | jq .SyncInfo
mainmenu
}

logs(){
submenu
}

back(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/nibiru/main.sh)
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
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/nibiru/control.sh)
}
yes(){
clear
printLogo
printnibiru
echo
echo
sudo systemctl stop nibid
cp $HOME/.nibid/data/priv_validator_state.json $HOME/.nibid/priv_validator_state.json.backup
rm -rf $HOME/.nibid/data
curl -L https://snapshots.kjnodes.com/nibiru-testnet/snapshot_latest.tar.lz4 | tar -Ilz4 -xf - -C $HOME/.nibid
mv $HOME/.nibid/priv_validator_state.json.backup $HOME/.nibid/data/priv_validator_state.json
sudo systemctl start nibid
mainmenu
}

mainmenu