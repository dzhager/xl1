#!/bin/bash

#X-l1bra
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)
printLogo
printsei
echo -ne "
	$(printGreen  '-----------------------------------------')
	  $(printYellow 'Минимальные требования к оборудованию.')
		     $(printBCyan '4CPU 16RAM 200GB')
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
		printsei
		echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		mainmenu
        	;;
    esac
}


no(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/sei/main.sh)
}
yes(){
clear
printLogo
printsei
echo
echo
read -r -p "  Введите имя ноды:  " MONIKER


printBCyan "Пожалуйста подождите........" && sleep 1
printYellow "1. Oбновляем наш сервер........" && sleep 1
	sudo apt -q update
	sudo apt -qy upgrade
printGreen "Готово!" && sleep 1


printYellow "2. Устанавливаем дополнительные пакеты........" && sleep 1
	sudo apt -qy install curl git jq lz4 build-essential
printGreen "Готово!" && sleep 1

 	echo -e "Node moniker:       ${CYAN}$MONIKER${NC}"

printYellow "3. Устанавливаем go........" && sleep 1
	sudo rm -rf /usr/local/go
	curl -Ls https://go.dev/dl/go1.19.7.linux-amd64.tar.gz | sudo tar -xzf - -C /usr/local
	eval $(echo 'export PATH=$PATH:/usr/local/go/bin' | sudo tee /etc/profile.d/golang.sh)
	eval $(echo 'export PATH=$PATH:$HOME/go/bin' | tee -a $HOME/.profile)
printGreen "Готово!" && sleep 1


printYellow "5. Скачиваем и устанавливаем бинарник........"
	cd $HOME
	rm -rf sei-chain
	git clone https://github.com/sei-protocol/sei-chain.git
	cd sei-chain
	git checkout 1.2.2beta-postfix
	make build
	mkdir -p $HOME/.sei/cosmovisor/genesis/bin
	mv build/seid $HOME/.sei/cosmovisor/genesis/bin/
	rm -rf build
	ln -s $HOME/.sei/cosmovisor/genesis $HOME/.sei/cosmovisor/current
	sudo ln -s $HOME/.sei/cosmovisor/current/bin/seid /usr/local/bin/seid
printGreen "Готово!" && sleep 1

printYellow "Устанавливаем cosmovisor и создаем сервис........"
go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@v1.4.0
sudo tee /etc/systemd/system/seid.service > /dev/null << EOF
[Unit]
Description=sei-testnet node service
After=network-online.target

[Service]
User=$USER
ExecStart=$(which cosmovisor) run start
Restart=on-failure
RestartSec=10
LimitNOFILE=65535
Environment="DAEMON_HOME=$HOME/.sei"
Environment="DAEMON_NAME=seid"
Environment="UNSAFE_SKIP_BACKUP=true"
Environment="PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$HOME/.sei/cosmovisor/current/bin"

[Install]
WantedBy=multi-user.target
EOF
sudo systemctl daemon-reload
sudo systemctl enable seid
printGreen "Готово!" && sleep 1


printYellow "6. Инициализируем ноду........" && sleep 1
# Set node configuration
seid config chain-id atlantic-1
seid config keyring-backend test
seid config node tcp://localhost:12657

# Initialize the node
seid init $MONIKER --chain-id atlantic-1

# Download genesis and addrbook
curl -Ls https://snapshots.kjnodes.com/sei-testnet/genesis.json > $HOME/.sei/config/genesis.json
curl -Ls https://snapshots.kjnodes.com/sei-testnet/addrbook.json > $HOME/.sei/config/addrbook.json
printGreen "Готово!" && sleep 1


printYellow "7. Добавляем сиды и пиры........" && sleep 1
	sed -i -e "s|^seeds *=.*|seeds = \"3f472746f46493309650e5a033076689996c8881@sei-testnet.rpc.kjnodes.com:12659\"|" $HOME/.sei/config/config.toml
printGreen "Готово!" && sleep 1


printYellow "8. Настраиваем прунинг........" && sleep 1
sed -i \
  -e 's|^pruning *=.*|pruning = "custom"|' \
  -e 's|^pruning-keep-recent *=.*|pruning-keep-recent = "100"|' \
  -e 's|^pruning-keep-every *=.*|pruning-keep-every = "0"|' \
  -e 's|^pruning-interval *=.*|pruning-interval = "19"|' \
  $HOME/.sei/config/app.toml
printGreen "Готово!" && sleep 1


printYellow "9. Задаем минимальную цену за gas........" && sleep 1
sed -i -e "s|^minimum-gas-prices *=.*|minimum-gas-prices = \"0usei\"|" $HOME/.sei/config/app.toml
printGreen "Готово!" && sleep 1



printYellow "10. Устанавливаем кастомные порты........"
sed -i -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:12658\"%; s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://127.0.0.1:12657\"%; s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:12060\"%; s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:12656\"%; s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":12660\"%" $HOME/.sei/config/config.toml
sed -i -e "s%^address = \"tcp://0.0.0.0:1317\"%address = \"tcp://0.0.0.0:12317\"%; s%^address = \":8080\"%address = \":12080\"%; s%^address = \"0.0.0.0:9090\"%address = \"0.0.0.0:12090\"%; s%^address = \"0.0.0.0:9091\"%address = \"0.0.0.0:12091\"%; s%^address = \"0.0.0.0:8545\"%address = \"0.0.0.0:12545\"%; s%^ws-address = \"0.0.0.0:8546\"%ws-address = \"0.0.0.0:12546\"%" $HOME/.sei/config/app.toml
printGreen "Готово." && sleep 1


printYellow "11. Подгружаем последний снапшот........"
curl -L https://snapshots.kjnodes.com/sei-testnet/snapshot_latest.tar.lz4 | tar -Ilz4 -xf - -C $HOME/.sei
[[ -f $HOME/.sei/data/upgrade-info.json ]] && cp $HOME/.sei/data/upgrade-info.json $HOME/.sei/cosmovisor/genesis/upgrade-info.json
printGreen "Готово."


printYellow "11. Запускаем ноду........" && sleep 2
sudo systemctl start seid
printGreen "Готово!"

printRed  =============================================================================== 
	echo -e "X-l1bra:                   ${CYAN} https://t.me/xl1bra ${NC}"
printRed  =============================================================================== 

submenu

}



submenu(){
echo -ne "
	$(printBGreen    'УСТАНОВКА ЗАВЕРШЕНА........') $(printBGreenBlink '!!!')
	
 		1) Просмотреть логи
 		2) Проверить синхронизацию
 		3) В меню
 		
	$(printBCyan 'Нажмите Enter:')  "
	read -r ans
	case $ans in
		1)
		subsubmenu
		;;
		2)
		echo
		seid status 2>&1 | jq .SyncInfo
		submenu
		;;
		3)
		source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/sei/main.sh)
		;;
		*)
		printLogo
		printsei
		echo
		echo $(printBRed '	Неверный запрос !!!')
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
			sudo journalctl -u seid -f --no-hostname -o cat
			submenu
			;;
	esac
}

mainmenu