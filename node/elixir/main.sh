#! /bin/bash

#X-l1bra  
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)
printLogo
printelixir
mainmenu() { echo -ne "

		$(printBCyan ' -->') $(printBGreen    '1) Установить')
		$(printBCyan ' -->') $(printBYellow    '2) Обновить')
		$(printBCyan ' -->') $(printBRed    '3) Удалить')

		$(printBBlue ' <-- 4) Назад')
		$(printBRed        '     0) Выход')

	$(printCyan 'Введите цифру:')  "

read -r ans
	case $ans in
		1)
		install
		;;
		2)
		update
		;;
		3)
		delet
		;;
		4)
		back
		;;
		0)
		echo $(printBCyan '	"Bye bye."')
		rm x-l1bra
		exit
		;;
		*)
		clear
		printLogo
		printelixir
		echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		mainmenu
		;;
	esac
}

install(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/elixir/install.sh)
}

# control(){
# source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/elixir/control.sh)
# }

update(){
	mainmenu
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/elixir/update.sh)
}

delet(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/elixir/delet.sh)
}

back(){
./x-l1bra
}

mainmenu