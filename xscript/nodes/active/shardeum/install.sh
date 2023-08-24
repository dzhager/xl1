#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/common.sh) && printlogo && printshardium
#-----------------------------------------------------------------------------------------#

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
		printlogo
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
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/active/shardeum/main.sh)
}
yes(){
clear
printlogo
printshardium
echo



printBCyan "Пожалуйста подождите........" && sleep 1
printYellow "1. Обновление менеджеров пакетов........" && sleep 1
	sudo apt update > /dev/null 2>&1
printGreen "Готово!" && sleep 1


printYellow "2. Устанавливаем дополнительные пакеты........" && sleep 1
	sudo apt install curl npm -y
printGreen "Готово!" && sleep 1

printYellow "3. Устанавливаем докер........" && sleep 1
	sudo apt install docker -y
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
echo
echo
	printBGreen "Установка завершена"
echo	
	source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/active/shardeum/main.sh)

}

mainmenu