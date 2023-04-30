#!/bin/bash
###############          ШАПКА
    clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh) && printLogo && printelixir

###############         СИСТЕМНЫК ТРЕБОВОНИЯ
    echo -ne "
	$(printGreen  '-----------------------------------------')
	  $(printYellow 'Минимальные требования к оборудованию.')
		     $(printBCyan '4CPU 8RAM 200GB')
	$(printGreen  '-----------------------------------------')"
    echo
###############           МЕНЮ
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
		        clear && printLogo && printshardium
		        echo && echo 
		        echo    -ne "$(printRed '		   Неверный запрос !')"
		        echo
		        mainmenu
        	    ;;
                 esac
    }
###############     ВОЗВРАТ В МЕНЮ
    no(){
    source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/shardeum/main.sh)
    }
###############     НАЧАЛО УСТАНОВКИ
    yes(){
    clear && printLogo && printelixir && echo

    printBCyan "Пожалуйста подождите........" && sleep 1
    printYellow "1. Обновление менеджеров пакетов........" && sleep 1
	    sudo apt update > /dev/null 2>&1
    printGreen "Готово!" && sleep 1

    printYellow "2. Устанавливаем дополнительные пакеты........" && sleep 1
	    sudo apt install curl docker.io -y && docker --version &&
    printGreen "Готово!" && sleep 1

    printYellow "4. Устанавливаем докер-компоновку........" && sleep 1
	    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	    sudo chmod +x /usr/local/bin/docker-compose && docker-compose --version
    printGreen "Готово!" && sleep 1

    printYellow "5. Установка валидатора ........" && sleep 1
	    curl -O https://files.elixir.finance/Dockerfile && docker build . -f Dockerfile -t elixir-validator
    printGreen "Готово!" && sleep 1
mainmenu
    }