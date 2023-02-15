#! /bin/bash

#X-l1bra  
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)
printLogo
printcelestia
echo -ne "
	$(printGreen  '-----------------------------------------')
	  $(printYellow 'Минимальные требования к оборудованию.')
		     $(printBCyan '4CPU 8RAM 200GB')
	$(printGreen  '-----------------------------------------')
	$(printYellow 'Рекомендуемые требования к оборудованию.')
		     $(printBCyan '8CPU 16RAM 500GB')
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
		printcelestia
		echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		mainmenu
        	;;
    esac
}

no(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/celestia/main.sh)
}

yes(){
clear
printLogo
printcelestia
echo
echo
read -r -p "Enter node moniker:" MONIKER


printBCyan "Пожалуйста подождите........" && sleep 1
printYellow "1. Oбновляем наш сервер........" && sleep 1
	sudo apt update && sudo apt upgrade > /dev/null 2>&1
printGreen "Готово!" && sleep 1


printYellow "2. Устанавливаем дополнительные пакеты........" && sleep 1
	sudo apt install -y make clang pkg-config libssl-dev build-essential git gcc lz4 chrony unzip curl jq ncdu htop net-tools lsof fail2ban wget -y > /dev/null 2>&1
printGreen "Готово!" && sleep 1


printYellow "3. Задаем переменные........" && sleep 1
CHAIN_ID="mocha"
CHAIN_DENOM="utia"
BINARY_NAME="celestia-appd"
BINARY_VERSION_TAG="v0.11.0"
IDENTITY="8F3C23EC3306B513"
echo -e "Node moniker:       ${CYAN}$MONIKER${NC}"
echo -e "Chain id:           ${CYAN}$CHAIN_ID${NC}"
echo -e "Chain demon:        ${CYAN}$CHAIN_DENOM${NC}"
echo -e "Binary version tag: ${CYAN}$BINARY_VERSION_TAG${NC}"
echo -e "IDENTITY:           ${CYAN}$IDENTITY${NC}"
printGreen "Готово!" && sleep 1


printYellow "4. Устанавливаем go........" && sleep 1
sudo rm -rf /usr/local/go
curl -Ls https://go.dev/dl/go1.19.5.linux-amd64.tar.gz | sudo tar -xzf - -C /usr/local
eval $(echo 'export PATH=$PATH:/usr/local/go/bin' | sudo tee /etc/profile.d/golang.sh)
eval $(echo 'export PATH=$PATH:$HOME/go/bin' | tee -a $HOME/.profile)
printGreen "Готово!" && sleep 1


printYellow "5. Скачиваем и устанавливаем бинарник........"
	cd $HOME
	rm -rf celestia-app
	git clone https://github.com/celestiaorg/celestia-app.git
	cd celestia-app
	git checkout v0.11.0
	make build
	mkdir -p $HOME/.celestia-app/cosmovisor/genesis/bin
	mv build/celestia-appd $HOME/.celestia-app/cosmovisor/genesis/bin/
	rm -rf build
	ln -s $HOME/.celestia-app/cosmovisor/genesis $HOME/.celestia-app/cosmovisor/current
	sudo ln -s $HOME/.celestia-app/cosmovisor/current/bin/celestia-appd /usr/local/bin/celestia-appd
printGreen "Готово!" && sleep 1

printYellow "6. Устанавливаем cosmovisor и создаем сервис........"
	go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@v1.4.0
	sudo tee /etc/systemd/system/celestia-appd.service > /dev/null << EOF
	[Unit]
	Description=celestia-testnet node service
	After=network-online.target

	[Service]
	User=$USER
	ExecStart=$(which cosmovisor) run start
	Restart=on-failure
	RestartSec=10
	LimitNOFILE=65535
	Environment="DAEMON_HOME=$HOME/.celestia-app"
	Environment="DAEMON_NAME=celestia-appd"
	Environment="UNSAFE_SKIP_BACKUP=true"

	[Install]
	WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable celestia-appd

printGreen "Готово!" && sleep 1


printYellow "7. Инициализируем ноду........" && sleep 1
celestia-appd config chain-id mocha
celestia-appd config keyring-backend test
celestia-appd config node tcp://localhost:20657
celestia-appd init $MONIKER --chain-id mocha
curl -Ls https://snapshots.kjnodes.com/celestia-testnet/genesis.json > $HOME/.celestia-app/config/genesis.json
curl -Ls https://snapshots.kjnodes.com/celestia-testnet/addrbook.json > $HOME/.celestia-app/config/addrbook.json
printGreen "Готово!" && sleep 1


printYellow "8. Добавляем сиды и пиры........" && sleep 1
sed -i -e "s|^seeds *=.*|seeds = \"3f472746f46493309650e5a033076689996c8881@celestia-testnet.rpc.kjnodes.com:20659\"|" $HOME/.celestia-app/config/config.toml
sed -i -e "s|^minimum-gas-prices *=.*|minimum-gas-prices = \"0.005utia\"|" $HOME/.celestia-app/config/app.toml
printGreen "Готово!" && sleep 1

printYellow "9. Настраиваем прунинг........" && sleep 1
sed -i \
  -e 's|^pruning *=.*|pruning = "custom"|' \
  -e 's|^pruning-keep-recent *=.*|pruning-keep-recent = "100"|' \
  -e 's|^pruning-keep-every *=.*|pruning-keep-every = "0"|' \
  -e 's|^pruning-interval *=.*|pruning-interval = "19"|' \
  $HOME/.celestia-app/config/app.toml
printGreen "Готово!" && sleep 1


printYellow "10. Устанавливаем кастомные порты........"
sed -i -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:20658\"%; s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://127.0.0.1:20657\"%; s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:20060\"%; s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:20656\"%; s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":20660\"%" $HOME/.celestia-app/config/config.toml
sed -i -e "s%^address = \"tcp://0.0.0.0:1317\"%address = \"tcp://0.0.0.0:20317\"%; s%^address = \":8080\"%address = \":20080\"%; s%^address = \"0.0.0.0:9090\"%address = \"0.0.0.0:20090\"%; s%^address = \"0.0.0.0:9091\"%address = \"0.0.0.0:20091\"%; s%^address = \"0.0.0.0:8545\"%address = \"0.0.0.0:20545\"%; s%^ws-address = \"0.0.0.0:8546\"%ws-address = \"0.0.0.0:20546\"%" $HOME/.celestia-app/config/app.toml
printGreen "Готово." && sleep 1

printYellow "11. Подгружаем последний снапшот........"
curl -L https://snapshots.kjnodes.com/celestia-testnet/snapshot_latest.tar.lz4 | tar -Ilz4 -xf - -C $HOME/.celestia-app
[[ -f $HOME/.celestia-app/data/upgrade-info.json ]] && cp $HOME/.celestia-app/data/upgrade-info.json $HOME/.celestia-app/cosmovisor/genesis/upgrade-info.json
printGreen "Готово."



printYellow "12. Запускаем ноду........" && sleep 2
sudo systemctl daemon-reload
sudo systemctl enable celestia-appd
sudo systemctl start celestia-appd

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
		2) Проверить статус сервиса
		3) В меню
Нажмите Enter:  "
	read -r ans
	case $ans in
		1) 
		subsubmenu
		;;

		2)
		echo
		echo
		sudo systemctl status celestia-appd
		submenu
		;;

		3) 
		source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/celestia/main.sh)
		;;

		*)
		clear
		printLogo
		printcelestia
		echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		submenu
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
		sudo journalctl -u celestia-appd -f --no-hostname -o cat
		source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/celestia/main.sh)
		;;
	esac
}


mainmenu