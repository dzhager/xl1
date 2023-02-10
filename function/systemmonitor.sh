#!/bin/bash
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)
printLogo
echo "Запуск"

sudo apt update > /dev/null 2>&1
sudo apt install snapd -y  > /dev/null 2>&1
nap install btop > /dev/null 2>&1


btop

./x-l1bra