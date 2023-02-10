#!/bin/bash
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)
printLogo
echo

if exists btop; then
	btop
else
  sudo apt update && sudo apt install snapd -y < "/dev/null"
  snap install btop
  btop

fi

