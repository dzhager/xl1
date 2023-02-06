#!/bin/bash

#X-l1bra

#ШАПКА
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)
printLogo
printshardium
echo -ne "
	$(printGreen  '-----------------------------------------')
	  $(printYellow 'Минимальные требования к оборудованию.')
		     $(printBCyan '4CPU 8RAM 200GB')
	$(printGreen  '-----------------------------------------')
	$(printYellow 'Рекомендуемые требования к оборудованию.')
		     $(printBCyan '8CPU 16RAM 400GB')
	$(printGreen  '-----------------------------------------')"
echo
mainmenu() {
	echo -ne "
	$(printCyan	'Вы действительно хотите начать установку') $(printCyanBlink '???')
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
		printshardium
		echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		mainmenu
        	;;
    esac
}


no(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/shardeum/main.sh)
}
yes(){
clear
printLogo
printshardium
echo



printBCyan "Пожалуйста подождите........" && sleep 1
printYellow "1. Обновление менеджеров пакетов........" && sleep 1
	sudo apt update > /dev/null 2>&1
printGreen "Готово!" && sleep 1


printYellow "2. Устанавливаем дополнительные пакеты........" && sleep 1
	sudo apt install curl  -y
printGreen "Готово!" && sleep 1

printYellow "3. Устанавливаем докер........" && sleep 1
	sudo apt install docker.io  -y
	docker --version
printGreen "Готово!" && sleep 1

printYellow "3. Устанавливаем докер-компоновку........" && sleep 1
	sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose
	docker-compose --version
printGreen "Готово!" && sleep 1

printYellow "3. Установка валидатора ........" && sleep 1
	curl -O https://gitlab.com/shardeum/validator/dashboard/-/raw/main/installer.sh && chmod +x installer.sh && ./installer.sh
printGreen "Готово!" && sleep 1


cd

cd .shardeum

./shell.sh

operator-cli gui start

operator-cli start

exit


printRed  =============================================================================== 
	echo -e "X-l1bra:                   ${CYAN} https://t.me/xl1bra ${NC}"
printRed  =============================================================================== 

submenu

}



submenu(){
echo -ne "
	$(printBGreen    'УСТАНОВКА ЗАВЕРШЕНА........') $(printBGreenBlink '!!!')
	
 		1) Просмотреть логи
 		2) Проверить синхронизацию
 		3) В меню
 		
	$(printBCyan 'Нажмите Enter:')  "
	read -r ans
	case $ans in
		1)
		subsubmenu
		;;
		2)
		echo
		nibid status 2>&1 | jq .SyncInfo
		submenu
		;;
		3)
		source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/shardeum/main.sh)
		;;
		*)
		printLogo
		printshardium
		echo
		echo $(printBRed '	Неверный запрос !!!')
		submenu
		;;
	esac
}

subsubmenu(){
	echo -ne "
	$(printYellow    'Для того что бы остановить журнал логов надо нажать') $(printBCyan 'CTRL+Z') $(printYellow '!!!')
	$(printBCyan 'Для продолжения нажмите Enter:')  "
		read -r ans
		case $ans in
			*)
			sudo journalctl -u nibid -f --no-hostname -o cat
			submenu
			;;
	esac
}

mainmenu