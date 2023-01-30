#!/bin/bash

#X-l1bra  
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)
printLogo
printcelestia
echo
mainmenu() {
	echo -ne "
	    $(printBCyan ' -->') $(printBYellow    '1)') Проверить баланс wallet
	    $(printBCyan ' -->') $(printBYellow    '2)') Проверить баланс orchestrator
	    $(printBCyan ' -->') $(printBYellow    '3)') Отправить монеты
	    $(printBCyan ' -->') $(printBYellow    '4)') Показать адрес кошелька
	    $(printBCyan ' -->') $(printBYellow    '5)') Добавить кошелек wallet
	    $(printBCyan ' -->') $(printBYellow    '6)') Добавить кошелек orchestrator
	    $(printBCyan ' -->') $(printBYellow    '7)') Восстановить кошелек
	
	    $(printBCyan ' -->') $(printBYellow    '8)') Делегировать
	    $(printBCyan ' -->') $(printBYellow    '9)') Делегировать самому себе
	    $(printBCyan ' -->') $(printBYellow    '10)') Создать валидатора
	    $(printBCyan ' -->') $(printBYellow    '11)') Узнать информацию о валидаторе
	    
	    $(printBCyan ' -->') $(printBYellow    '12)') Проверить синхронизацию
	    $(printBCyan ' -->') $(printBYellow    '13)') Просмотреть логи
	
	    $(printBBlue ' <--') $(printBBlue    '14) Вернутся назад')
		 $(printBRed    '0) Выйти')
		 
	$(printCyan 'Введите цифру:')  "
	read -r ans
	case $ans in
		1)
		WalletBalance
		;;
		
		2)
		OrchestratorWallet
		;;
		
		3)
		Send
		;;
		
		4)
		ShowWallet
		;;
		
		5)
		AddWallet
		;;
		
		6)
		AddWalletOrchestrator
		;;
		
		7)
		RecoveryWallet
		;;
		
		8)
		Delegate
		;;
		
		9)
		DelegateYourself
		;;
		
		10)
		CreateValidator
		;;
		
		11)
		InfoValidator
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
		exit 
		;;
		
		*)
		clear
		printLogo
		printcelestia
		echo $(printRed 'Неверный запрос !')
		mainmenu
		;;
	esac
}

WalletBalance(){
clear && printLogo && printcelestia
echo
celestia-appd q bank balances $(celestia-appd keys show wallet -a)
mainmenu
}

ShowWallet(){
clear && printLogo && printcelestia
echo
celestia-appd keys list
mainmenu
}

AddWallet(){
clear && printLogo && printcelestia
celestia-appd keys add wallet
echo
echo -ne "$(printCyanBlink '       ============================================')
$(printCyanBlink '       = ')$(printBRed 'ОБЯЗАТЕЛЬНО СОХРАНИТЕ МНЕМОНИК ФРАЗУ !!!')$(printCyanBlink ' = ')
$(printCyanBlink '       ============================================')"
mainmenu
}

Send(){
read -r -p "  Введите адрес кошелька:  " VAR1
echo
echo -ne "(printBRed ' 1tia = 1000000utia')"
read -r -p "  Введите количество монет utia:  " VAR2
celestia-appd tx bank send wallet "$VAR1" "$VAR2"utia --from wallet --chain-id mocha --gas-prices 0.1utia --gas-adjustment 1.5 --gas auto -y 
mainmenu
}

RecoveryWallet(){
clear && printLogo && printcelestia
echo
celestia-appd keys add wallet --recover
mainmenu
}

Delegate(){
clear && printLogo && printcelestia
echo
read -r -p " Введите валопер адрес:  " VAR1
echo -ne "$(printBRed ' 1tia = 1000000utia')"
echo
read -r -p "  Введите количество монет utia:  " VAR2
celestia-appd tx staking delegate "$VAR1" "$VAR2"utia --from wallet --chain-id mocha --gas-prices 0.1utia --gas-adjustment 1.5 --gas auto -y 
echo
mainmenu
}

DelegateYourself(){
clear && printLogo && printcelestia
echo
echo -ne "$(printBRed ' 1tia = 1000000utia')"
echo
read -r -p "  Введите количество монет utia:  " VAR2
celestia-appd tx staking delegate $(celestia-appd keys show wallet --bech val -a) "$VAR2"utia --from wallet --chain-id mocha --gas-prices 0.1utia --gas-adjustment 1.5 --gas auto -y 
echo
mainmenu
}


CreateValidator(){
clear && printLogo && printcelestia
echo
read -r -p "  Введите имя валидатора:  " VAR1
read -r -p "  Введите Orchestrator адрес:  " VAR3
read -r -p "  Введите eth адрес:  " VAR2
celestia-appd tx staking create-validator --amount=1000000utia --pubkey=$(celestia-appd tendermint show-validator) --moniker="$VAR1" --identity=8F3C23EC3306B513 --chain-id=mocha --commission-rate=0.1 --commission-max-rate=0.2 --commission-max-change-rate=0.05 --min-self-delegation=1 --from=wallet --evm-address="$VAR2" --orchestrator-address="$VAR3" --gas=auto --gas-adjustment=1.5 --fees=1500utia
echo
echo -ne "$(printBRed 'Вы должны позаботится забэкапить priv_validator_key.json.
Без него вы не сможете восстановить валидатора.
Он находится в папке .celestia-app/config ') $(printBRedBlink '!!!') "
echo
mainmenu
}

InfoValidator(){
clear && printLogo && printcelestia
celestia-appd q staking validator $(celestia-appd keys show wallet --bech val -a)
mainmenu
}

synced(){
clear && printLogo && printcelestia
curl -s localhost:26657/status
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
		sudo journalctl -u celestia-appd -f --no-hostname -o cat
		mainmenu
		;;
	esac
}

mainmenu