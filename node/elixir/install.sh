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
    source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/elixir/main.sh)
    }
###############     ПРОЦЕС УСТАНОВКИ
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

read -r -p " Введите имя валидатора:  " VALIDATOR_NAME
read -r -p " Введите адрес Metamask:  " METAMASK_ADDRESS
read -r -p " Введите приватный ключ Metamask:  " PRIVATE_KEY_ELIXIR

cat << EOF > $HOME/Dockerfile
FROM elixirprotocol/validator:testnet-2

ENV ADDRESS=$METAMASK_ADDRESS
ENV PRIVATE_KEY=$PRIVATE_KEY_ELIXIR
ENV VALIDATOR_NAME=$VALIDATOR_NAME
EOF
    printGreen "Готово!" && sleep 1
    printYellow "6. Запуск валидатора ........" && sleep 1
        docker run -d --restart unless-stopped --name ev elixir-validator
    printGreen "Готово!" && sleep 1
      
    submenu
    }


submenu(){
echo -ne "
	$(printBGreen    'УСТАНОВКА ЗАВЕРШЕНА........') $(printBGreenBlink '!!!')
	
	$(printBCyan 'Нажмите Enter:')  "
	read -r ans
	case $ans in
	    *)
		source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/elixir/main.sh)
		;;
	esac
}

mainmenu
