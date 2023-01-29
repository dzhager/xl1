#!/bin/bash

#X-l1bra  
	clear && source <(curl -s https://raw.githubusercontent.com/dzhager/xl1/main/function/common.sh)
printLogo
printnibiru
echo

mainmenu() {
	echo -ne "
	    $(printBCyan ' -->') $(printBYellow    '1)') Проверить баланс
	    $(printBCyan ' -->') $(printBYellow    '2)') Показать адрес кошелька
	    $(printBCyan ' -->') $(printBYellow    '3)') Добавить кошелек wallet
	    $(printBCyan ' -->') $(printBYellow    '4)') Восстановить кошелек
	    $(printBCyan ' -->') $(printBYellow    '10)') Send
	
	    $(printBCyan ' -->') $(printBYellow    '5)') Создать валидатора
	    $(printBCyan ' -->') $(printBYellow    '6)') Узнать информацию о валидаторе
	    
	    $(printBCyan ' -->') $(printBYellow    '7)') Проверить синхронизацию
	    $(printBCyan ' -->') $(printBYellow    '8)') Просмотреть логи
	
	    $(printBBlue ' <--') $(printBBlue    '9) Вернутся назад')
		 $(printBRed    '0) Выйти')
		 
	$(printCyan 'Введите цифру:')  "
	read -r ans
	case $ans in
		1)
		WalletBalance
		;;
		
		2)
		ShowWallet
		;;
		
		3)
		AddWallet
		;;
		
		4)
		RecoveryWallet
		
		;;
		
		5)
		CreateValidator
		;;
		
		6)
		InfoValidator
		;;
		
		7)
		synced
		;;
		
		8)
		logs
		;;
		
		9)
		back
		;;
		
		10)
		clear
		printLogo
		printnibiru
		Send
		;;
		
		0)
		echo $(printBCyan '"Bye bye."')
		exit 
		;;
		
		*)
		clear
		printLogo
		printnibiru
		echo $(printRed 'Неверный запрос !')
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
nibid keys list
mainmenu
}

AddWallet(){
clear && printLogo && printnibiru
nibid keys add wallet
printRed         ============================================
echo $(printBRed '== ОБЯЗАТЕЛЬНО СОХРАНИТЕ МНЕМОНИК ФРАЗУ ==') $(printBRedBlink '!!!')
printRed         ============================================
mainmenu
}

Send(){
read -r -p "  Введите адресс кошелька:  " VAR1
echo "1nibi = 1000000unibi"
read -r -p "  Введите колличество монет unibi:  " VAR2
nibid tx bank send wallet "$VAR1" "$VAR2"unibi --from wallet --chain-id nibiru-testnet-2 --gas-prices 0.1unibi --gas-adjustment 1.5 --gas auto -y
mainmenu
}

RecoveryWallet(){
clear && printLogo && printnibiru
nibid keys add wallet --recover
mainmenu
}

CreateValidator(){

clear && printLogo && printnibiru
nibid tx staking create-validator --amount 1000000unibi --commission-max-change-rate "0.1" --commission-max-rate "0.20" --commission-rate "0.1" --min-self-delegation "1" --pubkey=$(nibid tendermint show-validator) --moniker="$MONIKER" --chain-id nibiru-testnet-2 --gas-prices 0.025unibi --from wallet
echo
echo -ne "$(printBRed 'Вы должны позаботится забэкапить priv_validator_key.json.
Без него вы не сможете востановить валидатора.
Он находится в папке .nibid/config ') $(printBRedBlink '!!!') "
echo
mainmenu
}

InfoValidator(){
clear && printLogo && printnibiru
nibid q staking validator $(nibid keys show wallet --bech val -a)
mainmenu
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
source <(curl -s https://raw.githubusercontent.com/plnine/x-l1bra/main/nodes/nibiru/main.sh)
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