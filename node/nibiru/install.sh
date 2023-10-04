#!/bin/bash

#X-l1bra
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)
printLogo
printnibiru
echo -ne "
	$(printGreen  '-----------------------------------------')
	  $(printYellow 'Минимальные требования к оборудованию.')
		     $(printBCyan '4CPU 16RAM 1000GB')
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
		printLogo && printnibiru && echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		mainmenu
        	;;
    esac
}


no(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/nibiru/main.sh)
}
yes(){
clear
printLogo
printnibiru
echo
echo
read -r -p "  Введите имя ноды:  " MONIKER


printBCyan "Пожалуйста подождите........" && sleep 1
printYellow "1. Oбновляем наш сервер........" && sleep 1
	sudo apt update && sudo apt upgrade --yes > /dev/null 2>&1
printGreen "Готово!" && sleep 1


printYellow "2. Устанавливаем дополнительные пакеты........" && sleep 1
	sudo apt install curl git jq lz4 build-essential -y
printGreen "Готово!" && sleep 1


# printYellow "3. Задаем переменные........" && sleep 1
# #	MONIKER=X-l1bra
 	CHAIN_ID="nibiru-itn-1"
# 	CHAIN_DENOM="unibi"
# 	BINARY_NAME="nibid"
# 	BINARY_VERSION_TAG="v0.16.3"
# 	IDENTITY="8F3C23EC3306B513"
# 	source $HOME/.bash_profile > /dev/null 2>&1
 	echo -e "Node moniker:       ${CYAN}$MONIKER${NC}"
 	echo -e "Chain id:           ${CYAN}$CHAIN_ID${NC}"
# 	echo -e "Chain demon:        ${CYAN}$CHAIN_DENOM${NC}"
# 	echo -e "Binary version tag: ${CYAN}$BINARY_VERSION_TAG${NC}"
 	echo -e "IDENTITY:           ${CYAN}$IDENTITY${NC}"
# printGreen "Готово!" && sleep 1


printYellow "4. Устанавливаем go........" && sleep 1
	sudo rm -rf /usr/local/go
	curl -Ls https://go.dev/dl/go1.19.6.linux-amd64.tar.gz | sudo tar -xzf - -C /usr/local
	eval $(echo 'export PATH=$PATH:/usr/local/go/bin' | sudo tee /etc/profile.d/golang.sh)
	eval $(echo 'export PATH=$PATH:$HOME/go/bin' | tee -a $HOME/.profile)
printGreen "Готово!" && sleep 1


printYellow "5. Скачиваем и устанавливаем бинарник........"
cd $HOME
rm -rf nibiru
git clone https://github.com/NibiruChain/nibiru.git
cd nibiru
git checkout v0.19.2
make build
mkdir -p $HOME/.nibid/cosmovisor/genesis/bin
mv build/nibid $HOME/.nibid/cosmovisor/genesis/bin/
rm -rf build
ln -s $HOME/.nibid/cosmovisor/genesis $HOME/.nibid/cosmovisor/current
sudo ln -s $HOME/.nibid/cosmovisor/current/bin/nibid /usr/local/bin/nibid
printGreen "Готово!" && sleep 1

printYellow "Устанавливаем cosmovisor и создаем сервис........"
go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@v1.4.0
sudo tee /etc/systemd/system/nibid.service > /dev/null << EOF
[Unit]
Description=nibiru-testnet node service
After=network-online.target

[Service]
User=$USER
ExecStart=$(which cosmovisor) run start
Restart=on-failure
RestartSec=10
LimitNOFILE=65535
Environment="DAEMON_HOME=$HOME/.nibid"
Environment="DAEMON_NAME=nibid"
Environment="UNSAFE_SKIP_BACKUP=true"
Environment="PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$HOME/.nibid/cosmovisor/current/bin"

[Install]
WantedBy=multi-user.target
EOF
sudo systemctl daemon-reload
sudo systemctl enable nibid
printGreen "Готово!" && sleep 1


printYellow "6. Инициализируем ноду........" && sleep 1
nibid config chain-id nibiru-itn-1
nibid config keyring-backend test
nibid config node tcp://localhost:39657
nibid init $MONIKER --chain-id nibiru-itn-1

printGreen "Готово!" && sleep 1


printYellow "7. Добавляем сиды и пиры........" && sleep 1
curl -Ls https://snapshots.kjnodes.com/nibiru-testnet/genesis.json > $HOME/.nibid/config/genesis.json
curl -Ls https://snapshots.kjnodes.com/nibiru-testnet/addrbook.json > $HOME/.nibid/config/addrbook.json
sed -i -e "s|^seeds *=.*|seeds = \"3f472746f46493309650e5a033076689996c8881@nibiru-testnet.rpc.kjnodes.com:39659\"|" $HOME/.nibid/config/config.toml

printGreen "Готово!" && sleep 1


printYellow "8. Настраиваем прунинг........" && sleep 1
sed -i \
  -e 's|^pruning *=.*|pruning = "custom"|' \
  -e 's|^pruning-keep-recent *=.*|pruning-keep-recent = "100"|' \
  -e 's|^pruning-keep-every *=.*|pruning-keep-every = "0"|' \
  -e 's|^pruning-interval *=.*|pruning-interval = "19"|' \
  $HOME/.nibid/config/app.toml
printGreen "Готово!" && sleep 1


printYellow "9. Задаем минимальную цену за gas........" && sleep 1
sed -i -e "s|^minimum-gas-prices *=.*|minimum-gas-prices = \"0.025unibi\"|" $HOME/.nibid/config/app.toml
printGreen "Готово!" && sleep 1



printYellow "10. Устанавливаем кастомные порты........"
sed -i -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:39658\"%; s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://127.0.0.1:39657\"%; s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:39060\"%; s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:39656\"%; s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":39660\"%" $HOME/.nibid/config/config.toml
sed -i -e "s%^address = \"tcp://0.0.0.0:1317\"%address = \"tcp://0.0.0.0:39317\"%; s%^address = \":8080\"%address = \":39080\"%; s%^address = \"0.0.0.0:9090\"%address = \"0.0.0.0:39090\"%; s%^address = \"0.0.0.0:9091\"%address = \"0.0.0.0:39091\"%; s%^address = \"0.0.0.0:8545\"%address = \"0.0.0.0:39545\"%; s%^ws-address = \"0.0.0.0:8546\"%ws-address = \"0.0.0.0:39546\"%" $HOME/.nibid/config/app.toml

printGreen "Готово." && sleep 1


printYellow "11. Подгружаем последний снапшот........"
curl -L https://snapshots.kjnodes.com/nibiru-testnet/snapshot_latest.tar.lz4 | tar -Ilz4 -xf - -C $HOME/.nibid
[[ -f $HOME/.nibid/data/upgrade-info.json ]] && cp $HOME/.nibid/data/upgrade-info.json $HOME/.nibid/cosmovisor/genesis/upgrade-info.json
printGreen "Готово."


printYellow "11. Запускаем ноду........" && sleep 2
	sudo systemctl start nibid
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
		nibid status 2>&1 | jq .SyncInfo
		submenu
		;;
		3)
		source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/nibiru/main.sh)
		;;
		*)
		printLogo
		printnibiru
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
			sudo journalctl -u nibid -f --no-hostname -o cat
			submenu
			;;
	esac
}

mainmenu