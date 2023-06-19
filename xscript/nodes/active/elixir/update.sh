#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/common.sh) && printlogo && printelixir
#-----------------------------------------------------------------------------------------#

echo
docker kill ev
docker rm ev
docker pull elixirprotocol/validator:testnet-2
docker build . -f Dockerfile -t elixir-validator
docker run -d --restart unless-stopped --name ev elixir-validator




mainmenu(){
	echo -ne "
    $(printBCyan '	Обновление завершено!')  
	$(printBCyan '	Для возврата нажмите Enter:')  "
		read -r ans
			case $ans in
				*)
				source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/active/elixir/main.sh)
				;;
			esac
}

mainmenu