#!/bin/bash
clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)

function printaleo {
echo -ne "$(printCyan '                  =====================')
$(printRed  ' ================')$(printCyan ' = ')$(printBGreen 'Aleo Testnet III')$(printCyan '  = ')$(printRed  '================') 
$(printCyan '                  =====================') "
}
echo
printaleo