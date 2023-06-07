#! /bin/bash

#X-l1bra  
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)
printLogo
printstarknet
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
		printLogo
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
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/starknet/install.sh)
}

update(){
rustup update stable
sudo systemctl stop starknetd
cd pathfinder
git fetch
git checkout v0.5.6
cargo build --release --bin pathfinder
cd py
source .venv/bin/activate
PIP_REQUIRE_VIRTUALENV=true pip install --upgrade pip
PIP_REQUIRE_VIRTUALENV=true pip install -e .[dev]
cd
sudo systemctl start starknetd

echo -ne "$(printBCyan ' Обновление завершено, идет сборка файлов и синхронизация ноды.
	Процесс может занимать около 15 мин. ') "

mainmenu

}

delet(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/starknet/delet.sh)
}

back(){
./x-l1bra
}

mainmenu