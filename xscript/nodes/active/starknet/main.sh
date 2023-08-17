#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/common.sh) && printlogo && printstarknet
#-----------------------------------------------------------------------------------------#
mainmenu() { echo -ne "

		$(printBCyan ' -->') $(printBMagenta    '1) Просмотр логов')

		$(printBCyan ' -->') $(printBGreen    '2) Установить')
		$(printBCyan ' -->') $(printBYellow    '3) Обновить')

		$(printBCyan ' -->') $(printBRed    '4) Удалить')

		$(printBBlue ' <-- 5) Назад')

		$(printBRed        '     0) Выход')

	$(printCyan 'Введите цифру:')  "

read -r ans
	case $ans in
		1)
		logs
		;;

		2)
		install
		;;

		3)
		update
		;;

		4)
		delet
		;;

		5)
		back
		;;

		0)
		echo $(printBCyan '	"Bye bye."')
		rm x-l1bra
		exit
		;;

		*)
		clear
		printlogo
		printstarknet
		echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		mainmenu
		;;
	esac
}

logs(){
	journalctl -u starknetd -f -o cat
	mainmenu
}

install(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/active/starknet/install.sh)
}

update(){
rustup update stable
sudo systemctl stop starknetd
cd pathfinder
git fetch
git checkout v0.7.2

cargo build --release --bin pathfinder
cd py
source .venv/bin/activate
PIP_REQUIRE_VIRTUALENV=true pip install --upgrade pip
PIP_REQUIRE_VIRTUALENV=true pip install -e .[dev]
cd
sudo systemctl start starknetd

echo -ne "$(printBCyan ' Обновление завершено, идет сборка файлов и синхронизация ноды.
	Процесс может занимать около 35 мин. ') "

mainmenu

}

delet(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/active/starknet/delet.sh)
}

back(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/menu/menunodes.sh)
}

mainmenu