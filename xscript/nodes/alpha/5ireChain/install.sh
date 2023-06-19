#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/common.sh) && printlogo && print5ireChain
#-----------------------------------------------------------------------------------------#

    echo "$(printGreen  '        -----------------------------------------')"
    echo "$(printYellow '          Минимальные требования к оборудованию.')"
    echo "$(printBCyan  '                     4CPU 8RAM 200GB')"
    echo "$(printGreen  '        -----------------------------------------')"
    echo "$(printYellow '         Рекомендуемые требования к оборудованию.')"
    echo "$(printBCyan  '                    8CPU 16RAM 400GB')"
    echo "$(printGreen  '        -----------------------------------------')"
    echo
    echo "$(printBCyan	'        Вы действительно хотите начать установку') $(printRedBlink '???')"

#-------------------------------------Основное меню---------------------------------------#
	mainmenu() {
		echo
		echo "$(printBCyan '		-->') $(printBGreen '1) Да')"
		echo "$(printBCyan '		-->') $(printBRed '2) Нет')"
		echo
		echo "$(printBYellow '		<-- 3) Назад')"
		echo
		echo "$(printBRed '	            0)') $(printBRed 'Выход')"
		echo
		echo -ne "$(printBCyan ' Введите цифру: --> ')"

	#-------------------------Свойства меню-------------------------#
		read -r ans
			case $ans in
			#------------------------------#
				1)
				yes
				;;
			#------------------------------#
				3)
				no
				;;
			#------------------------------#
				3)
				back
				;;
			#------------------------------#
				0)
				echo $(printBCyan '	"Bye bye."') && exit
				;;
			#------------------------------#
				*)
				clear && printlogo && print5ireChain && echo && echo "$(printRedBlink '		   Неверный запрос !')"	 && mainmenu
				;;
			#------------------------------#	
			esac
	}
#-----------------------------------------------------------------------------------------#


#---------------------------------------Установка-----------------------------------------#
    #-------------------------------Запись переменных-------------------------------------#
        NAME=YOUR_NODE_NAME
        IMAGE=5irechain/5ire-thunder-node:0.12
        DOCKER_NAME=5ire-thunder-node
        BIN=5irechain 
        BIN_DIR=$HOME/bin
        DATA_DIR=$HOME/.5irechain
        BACKUP_DIR=$HOME/backup
        DAEMON=fired                
        DESCRIPTION="5irechain validator node"
    #-------------------------------------------------------------------------------------#

    #--------------------Обновление системы и установка доп. пакетов----------------------#
        sudo apt update && sudo apt upgrade -y && sudo apt install -y curl jq
    #-------------------------------------------------------------------------------------#

    #-------------------------------Установка DOCKER--------------------------------------#
        sudo apt install -y docker.io && sudo usermod -aG docker $USER && newgrp docker && docker --version
    #-------------------------------------------------------------------------------------#

mainmenu