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

	    $(printBCyan ' -->') $(printBYellow    '4)') Создать кошелек wallet
	    $(printBCyan ' -->') $(printBYellow    '5)') Восстановить кошелек
	    $(printBCyan ' -->') $(printBYellow    '4)') Удалить кошелек wallet

	    $(printBBlue ' <--') $(printBBlue    '7) Вернутся назад')
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
		DeleteWallet
		;;
		
		7)
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
clear && printLogo && printquasar
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
quasard tx bank send wallet "$VAR1" "$VAR2"uqsr --from wallet --chain-id qsr-questnet-04
mainmenu
}

RecoveryWallet(){
clear && printLogo && printsei
echo
seid keys add wallet --recover
mainmenu
}

mainmenu