#! /bin/bash

#X-l1bra  
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)
printLogo
printsui
echo -ne "
	$(printGreen  '-----------------------------------------')
	$(printYellow 'Рекомендуемые требования к оборудованию.')
		     $(printBCyan 	'10CPU 32RAM 1TB SSD')
	$(printGreen  '-----------------------------------------')"
echo
mainmenu() {
	echo -ne "
	$(printCyan	'Вы действительно хотите начать установку') $(printCyanBlink '???')
	$(printGreen	' 1) Да')
	$(printRed	' 2) Нет')
	$(printCyan	'Введите цифру:') "
	read -r ans
	case $ans in
		1)
		yes
		;;
		2)
		no
		;;
		*)
		clear
		printLogo
		printsui
		echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		mainmenu
        	;;
    esac
}

no(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/sui/main.sh)
}

yes(){
clear
printLogo
printsui
echo
echo

printBCyan "Пожалуйста подождите........" && sleep 1
printYellow "1. Oбновляем наш сервер........" && sleep 1
	sudo apt update && sudo apt upgrade -y > /dev/null 2>&1
printGreen "Готово!" && sleep 1


printYellow "2. Устанавливаем дополнительные пакеты........" && sleep 1
sudo apt-get install -y --no-install-recommends \
tzdata \
ca-certificates \
build-essential \
libssl-dev \
libclang-dev \
pkg-config \
openssl \
protobuf-compiler \
cmake \
curl \
tar \
wget \
jq \
git \
libpq-dev 
printGreen "Готово!" && sleep 1


printYellow "3. Устанавливаем Rust........" && sleep 1
	echo
	sudo curl https://sh.rustup.rs -sSf | sh -s -- -y
	source $HOME/.cargo/env
	rustc --version
printGreen "Готово!" && sleep 1


printYellow "4. Клонируем GitHub SUI репозиторий........" && sleep 1
	cd $HOME
	git clone https://github.com/MystenLabs/sui.git
	cd sui
	git remote add upstream https://github.com/MystenLabs/sui
	git fetch upstream
	git checkout -B testnet --track upstream/testnet
printGreen "Готово!" && sleep 1


printYellow "5. Создаём каталог для базы данных SUI и генезиса........"
mkdir $HOME/.sui
wget -O $HOME/.sui/genesis.blob  https://github.com/MystenLabs/sui-genesis/raw/main/testnet/genesis.blob
cp $HOME/sui/crates/sui-config/data/fullnode-template.yaml $HOME/.sui/fullnode.yaml
sed -i.bak "s|db-path:.*|db-path: \"$HOME\/.sui\/db\"| ; s|genesis-file-location:.*|genesis-file-location: \"$HOME\/.sui\/genesis.blob\"| ; s|127.0.0.1|0.0.0.0|" $HOME/.sui/fullnode.yaml
printGreen "Готово!" && sleep 1


printYellow "7. Добавляем сиды........" && sleep 1
sudo tee -a $HOME/.sui/fullnode.yaml  >/dev/null <<EOF

p2p-config:
  seed-peers:
   - address: "/ip4/65.109.32.171/udp/8084"
   - address: "/ip4/65.108.44.149/udp/8084"
   - address: "/ip4/95.214.54.28/udp/8080"
   - address: "/ip4/136.243.40.38/udp/8080"
   - address: "/ip4/84.46.255.11/udp/8084"
   - address: "/ip4/135.181.6.243/udp/8088"
EOF

printGreen "Готово!" && sleep 1

printYellow "5. Создаём двоичные файлы SUI........."
cargo build --release --bin sui-node
mv ~/sui/target/release/sui-node /usr/local/bin/
sui-node -V
cd $HOME/sui
git fetch upstream
git checkout -B testnet --track upstream/testnet
cargo build  -p sui --release
mv ~/sui/target/release/sui /usr/local/bin/
printGreen "Готово!" && sleep 1




printYellow "Cоздаем сервис файл........"

echo "[Unit]
Description=Sui Node
After=network.target

[Service]
User=$USER
Type=simple
ExecStart=/usr/local/bin/sui-node --config-path $HOME/.sui/fullnode.yaml
Restart=on-failure
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target" > $HOME/suid.service

mv $HOME/suid.service /etc/systemd/system/

sudo tee <<EOF >/dev/null /etc/systemd/journald.conf
Storage=persistent
EOF

printGreen "Готово!" && sleep 1





printYellow "11. Запускаем ноду........" && sleep 2
sudo systemctl restart systemd-journald
sudo systemctl daemon-reload
sudo systemctl enable suid
sudo systemctl restart suid

printGreen "Готово!"

printBCyan "УСТАНОВКА ЗАВЕРШЕНА"

printRed  =============================================================================== 
	echo -e "X-l1bra:                   ${CYAN} https://t.me/xl1bra ${NC}"
printRed  =============================================================================== 

submenu

}


submenu(){
echo -ne "
$(printGreen    'Установка завершена.')
		1) Просмотреть логи
		2) В меню
Нажмите Enter:  "
	read -r ans
	case $ans in
		1) 
		subsubmenu
		;;
		2) 
		source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/sui/main.sh)
		;;
		*)
		clear
		printLogo
		printsui
		echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		mainmenu
		;;
	esac
}

subsubmenu(){
	echo -ne "
	$(printYellow    'Для того что бы остановить журнал логов надо нажать') $(printBCyan 'CTRL+Z') $(printYellow '!!!')
	$(printBCyan 'Для продолжения нажмите Enter:')  "
		read -r ans
		case $ans in
			*)
		journalctl -u suid -f
		submenu
		;;
	esac
}


mainmenu