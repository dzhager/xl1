#!/bin/bash
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)
printLogo
echo

# if exists btop; then
# 	btop
# else
#   sudo apt update && sudo apt install snapd -y < "/dev/null"
#   snap install btop
#   btop

# fi

# if ! [ -x "$(command -v btop)" ]; then
#   btop
# else
#   sudo apt update && sudo apt install snapd -y < "/dev/null"
#   snap install btop
#   btop
# fi


 # if [[ -n ""btop -v | grep $arg"" ]] #если строка не пуста,
 #        then
 #        btop #то пакет установлен,
 #        else
 #        sudo apt update && sudo apt install snapd -y < "/dev/null"
 #  		snap install btop
 #  		btop
 #    fi

# var5=v0.11.0
# var6=`btop version | cut -d ' ' -f 3`

# if [[ "$var3" == "$var4" ]]; then
#  echo -ne "$(printBGreen '	У вас уже установлена последняя версия!')"
#  mainmenu
# else
#  	update
#  	submenu
# fi

if ! [ -x "$(command -v btop)" ]; then
  sudo apt update && sudo apt install snapd -y < "/dev/null"
  snap install btop
fi

btop