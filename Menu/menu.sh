#! /bin/bash

#X-l1bra  
clear && source <(curl -s https://raw.githubusercontent.com/dzhager/xl1/main/function/common.sh)
printLogo
mainmenu() { echo -ne "
$(printCyanBlink '                  =====================')
$(printRed  ' ================')$(printCyanBlink ' = ')$(printBMagenta 'Добро пожаловать!')$(printCyanBlink ' = ')$(printRed  '================') 
$(printCyanBlink '                  =====================')

 		     $(printBCyan 'Выберите ноду !')

		$(printBCyan ' -->') $(printBYellow    '1)') Celestia $(printBTYellow '*****')
		$(printBCyan ' -->') $(printBYellow     '2)') Nibiru $(printBTYellow '****')
		$(printBCyan ' -->') $(printBYellow    '3)') DeFund $(printBTYellow '***')
		$(printBCyan ' -->') $(printBYellow     '4)') Shardeum $(printBTYellow '*****')

		$(printBRed        '     0) Выход')

	Введите цифру:  "
	read -r ans
	case $ans in
	
		1)
		celestia
		;;
		
		2)
		nibiru
		;;
		
		3)
		defund
		;;
		
		4)
		shardeum
		;;
		
		0)
		echo $(printBCyan '"Bye bye."')
		exit
		;;
		
		*)
		printLogo
		printRed  ======================================================================= 
		mainmenu
		;;
	esac
}

celestia(){
source <(curl -s https://raw.githubusercontent.com/plnine/x-l1bra/main/nodes/celestia/main.sh)
}

nibiru(){
source <(curl -s https://raw.githubusercontent.com/dzhager/xl1/main/Menu/menu.sh)
}

defund(){
#source <(curl -s  )
clear
printLogo
               echo "        $(printBYellow '             Coming soon !!!')"
mainmenu
}

shardeum(){
#source <(curl -s  )
clear
printLogo
               echo "        $(printBYellow '             Coming soon !!!')"
mainmenu
}

mainmenu