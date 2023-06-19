#!/bin/bash

#X-l1bra  
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)
printLogo
printnibiru
echo

mainmenu(){
	echo -ne "
	    $(printBCyan ' -->') $(printBYellow    '1)') Сохранить валидатора
	    $(printBCyan ' -->') $(printBYellow    '2)') Восстановить валидатора
	
	    $(printBBlue ' <--') $(printBBlue    '3) Вернутся назад')
		 $(printBRed    ' 0) Выйти')
		 
	$(printCyan 'Введите цифру:')  "

read -r ans
	case $ans in
		1)
		backup
		;;
		
		2)
		again
		;;
		
		3)
		back
		;;

		0)
		echo $(printBCyan '	"Bye bye."')
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

backup(){
	mkdir $HOME/backups_nibiru
	cp $HOME/.nibid/data/priv_validator_state.json $HOME/backups_nibiru/priv_validator_state.json.backup
	cp $HOME/.nibid/config/priv_validator_key.json $HOME/backups_nibiru/priv_validator_key.json.backup
	clear && printLogo && printnibiru
	echo -ne "
		Валидатор сохранен!
		Резервная копия находится в папке backups_defund "
	echo
	mainmenu 
}

again(){
	systemctl stop nibid.service
	cp $HOME/backups_nibiru/priv_validator_state.json.backup $HOME/.nibid/data/priv_validator_state.json
	cp $HOME/backups_nibiru/priv_validator_key.json.backup $HOME/.nibid/config/priv_validator_key.json
	systemctl start nibid.service
	clear && printLogo && printnibiru
	echo -ne "
		Валидатор востановлен! 
	"
	echo
	mainmenu
}

back(){
	source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/nibiru/control.sh)
}


mainmenu