#!/bin/bash

#ШАПКА
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh) && printLogo && print5ireChain
#СИСТЕМНЫЕ ТРЕБОВАНИЯ
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
		print5ireChain
		echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		mainmenu
        	;;
    esac
}


no(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/starknet/main.sh)
}
yes(){
	clear && printLogo && 5ireChain && echo

printBCyan "Пожалуйста подождите........" && sleep 1
printYellow "1. Oбновляем наш сервер........" && sleep 1
	sudo apt update && sudo apt upgrade --yes > /dev/null 2>&1
printGreen "Готово!" && sleep 1


printYellow "2. Устанавливаем дополнительные пакеты........" && sleep 1
	sudo apt install curl git python3-pip build-essential libssl-dev libffi-dev python3-dev libgmp-dev  pkg-config -y
printGreen "Готово!" && sleep 1


printYellow "3. Устанавливаем docker-compose........" && sleep 1
	sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose && docker-compose -v
printGreen "Готово!" && sleep 1

printYellow "4. Устанавливаем валидатор........" && sleep 1
docker pull 5irechain/5ire-thunder-node:0.12


printYellow "4. Запускаем 5ireChain........" && sleep 1
docker run -d -p 30333:30333 5irechain/5ire-thunder-node:0.12 --port 30333 --no-telemetry --name 5ire-thunder-validator --base-path /5ire/data --keystore-path /5ire/data --node-key-file /5ire/secrets/node.key --chain /5ire/thunder-chain-spec.json --bootnodes /ip4/3.128.99.18/tcp/30333/p2p/12D3KooWSTawLxMkCoRMyzALFegVwp7YsNVJqh8D2p7pVJDqQLhm --validator
printGreen "Готово!" && sleep 1


printRed  =============================================================================== 
	echo -e "X-l1bra:                   ${CYAN} https://t.me/xl1bra ${NC}"
printRed  =============================================================================== 

submenu

}



submenu(){
echo -ne "
	$(printBGreen    'УСТАНОВКА ЗАВЕРШЕНА........') $(printBGreenBlink '!!!')

 		
	$(printBCyan 'Нажмите Enter:')  "
	read -r ans
	case $ans in
		
		*)
		source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/5ireChain/main.sh)
		;;
		

	esac
}



mainmenu