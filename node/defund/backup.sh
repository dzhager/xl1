#!/bin/bash

#X-l1bra  
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)
printLogo
printdefund
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

backup(){
	mkdir $HOME/backups_defund
	cp $HOME.defund/data/priv_validator_state.json $HOME/backups_defund/priv_validator_state.json.backup
	cp $HOME.defund/config/priv_validator_key.json $HOME/backups_defund/priv_validator_key.json.backup
	clear && printLogo && printdefund
	echo -ne "
		Валидатор сохранен!
		Резервная копия находится в папке backups_defund 
	"
	mainmenu 
}

again(){
	systemctl stop defundd.service
	cp $HOME/backups_defund/priv_validator_state.json.backup $HOME.defund/data/priv_validator_state.json
	cp $HOME/backups_defund/priv_validator_key.json.backup $HOME.defund/config/priv_validator_key.json
	systemctl start defundd.service
	clear && printLogo && printdefund
	echo -ne "
		Валидатор востановлен! 
	"
	mainmenu
}

back(){
	source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/defund/control.sh)
}