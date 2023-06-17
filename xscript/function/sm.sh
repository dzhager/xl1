#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/common.sh) && printlogo
#-----------------------------------------------------------------------------------------#

    if [ $(dpkg-query -W -f='${Status}' snapd 2>/dev/null | grep -c "ok installed") -eq 0 ];
    then
        echo "$(printBYellow    '     Подождите, идет первоначальная установка!')"
        sudo apt update  > /dev/null 2>&1
		sudo apt install snapd -y > /dev/null 2>&1
		snap install btop > /dev/null 2>&1
		btop
    else
        btop
    fi
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/menu/homemenu.sh)

