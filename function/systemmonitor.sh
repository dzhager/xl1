#!/bin/bash
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)
printLogo
echo

sudo apt update && sudo apt install snapd -y snap install btop > /dev/null 2>&1


btop

./x-l1bra