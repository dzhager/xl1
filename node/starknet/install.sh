#!/bin/bash

#X-l1bra
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)
printLogo
printstarknet
#СИСТЕМНЫЕ ТРЕБОВАНИЯ
echo -ne "
	$(printGreen  '-----------------------------------------')
	  $(printYellow 'Минимальные требования к оборудованию.')
		     $(printBCyan '4CPU 4RAM 200GB')
	$(printGreen  '-----------------------------------------')
	  $(printYellow 'Рекомендуемые требования к оборудованию.')
		     $(printBCyan '4CPU 4RAM 500GB+')
	$(printGreen  '-----------------------------------------')"

echo

