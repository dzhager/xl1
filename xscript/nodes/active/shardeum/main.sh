#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/common.sh) && printlogo && printshardium
#-----------------------------------------------------------------------------------------#

#
mainmenu() { echo -ne "
		$(printBCyan ' -->') $(printBGreen    '1) Управление')

		$(printBCyan ' -->') $(printBGreen    '2) Установить')
		$(printBCyan ' -->') $(printBGreen    '3) Исправить ошибку') $(printBYellow 'Command not found error')
		$(printBCyan ' -->') $(printBYellow   '4) Обновить Validator')
		$(printBCyan ' -->') $(printBYellow   '5) Обновить CLI/GUI')

		$(printBCyan ' -->') $(printBRed    '6) Удалить')

		$(printBBlue ' <-- 7) Назад')
		$(printBRed        '     0) Выход')

 	Введите цифру: "

read -r ans
	case $ans in
		1)
		control
		;;

		2)
		install
		;;

		3)
		fixinstall
		;;

		4)
		update
		;;

		5)
		updatecli
		;;

		6)
		delet
		;;

		7)
		back
		;;
		
		0)
		echo $(printBCyan '"Bye bye."')
		rm x-l1bra
		exit
		;;

		*)
		clear
		printlogo
		printshardium
		echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		mainmenu
		;;
	esac
}

install(){
 source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/active/shardeum/install.sh)
}

control(){
	source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/active/shardeum/control.sh)
}

delet(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/active/shardeum/delet.sh)
}

back(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/menu/menunodes.sh)
}

updatecli(){
	
	docker exec -i shardeum-dashboard /bin/bash -c "operator-cli update"
	mainmenu
}


#--------------ОБНОВЛЕНИЕ 1.1.6
update(){
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/common.sh) && printlogo && printshardium
	cd $HOME
	docker exec -i shardeum-dashboard /bin/bash -c "operator-cli stop"
	curl -O https://gitlab.com/shardeum/validator/dashboard/-/raw/main/installer.sh && chmod +x installer.sh && ./installer.sh
	docker update --restart always shardeum-dashboard && docker start shardeum-dashboard && docker exec -i shardeum-dashboard /bin/bash -c "operator-cli gui start && operator-cli start" && docker exec -i shardeum-dashboard /bin/bash -c "pm2 list" && screen -ls
	echo -ne "
			    $(printBGreen    'Обновление завершено!')
			    
			    Проверить работу ноды можно командой:
			    $(printBYellow 'pm2 list')"

	mainmenu

}

fixinstall(){
	cd
	cd .shardeum
	docker exec -i shardeum-dashboard /bin/bash -c "rm -rf cli gui"
	docker exec -i shardeum-dashboard /bin/bash -c "sudo chown -R node /usr/local/bin /usr/local/lib /usr/local/include /usr/local/share"
	cat << EOF > $HOME/.shardeum/entrypoint.sh
#!/usr/bin/env bash
sudo chown -R node:node /home/node
sudo chown -R node:node /usr/src/app
sudo ln -s /usr/src/app /home/node/app/validator
sleep 10;

echo "Install PM2"

npm i -g pm2

echo "/home/node/.pm2/logs/*.log /home/node/app/cli/build/logs/*.log {
    daily
    rotate 7
    compress
    delaycompress
    missingok
    notifempty
    create 0640 user group
    sharedscripts
    postrotate
        pm2 reloadLogs
    endscript
}" | sudo tee /etc/logrotate.d/pm2

# Pull latest versions of the CLI and GUI

git clone https://gitlab.com/shardeum/validator/cli.git

echo "Install the CLI"
cd cli
npm i --silent && npm link
cd ..

git clone https://gitlab.com/shardeum/validator/gui.git

echo "Install the GUI"
cd gui
npm i --silent
npm run build
#openssl req -x509 -nodes -days 99999 -newkey rsa:2048 -keyout ./selfsigned.key -out selfsigned.crt -subj "/C=US/ST=Texas/L=Dallas/O=Shardeum/OU=Shardeum/CN=shardeum.org"

# if CA.cnf does not exist, create it
if [ ! -f "CA.cnf" ]; then
    echo "[ req ]
prompt = no
distinguished_name = req_distinguished_name

[ req_distinguished_name ]
C = XX
ST = Localzone
L = localhost
O = Certificate Authority Local Validator Node
OU = Develop
CN = mynode-sphinx.sharedum.local
emailAddress = community@.sharedum.local" > CA.cnf
fi

# if CA.key does not exist, create it
if [ ! -f "CA_key.pem" ]; then
    openssl req -nodes -new -x509 -keyout CA_key.pem -out CA_cert.pem -days 1825 -config CA.cnf
fi

# if selfsigned.cnf does not exist, create it
if [ ! -f "selfsigned.cnf" ]; then
    echo "[ req ]
default_bits  = 4096
distinguished_name = req_distinguished_name
req_extensions = req_ext
x509_extensions = v3_req
prompt = no

[req_distinguished_name]
countryName = XX
stateOrProvinceName = Localzone
localityName = Localhost
organizationName = Shardeum Sphinx 1.x Validator Cert.
commonName = localhost

[req_ext]
subjectAltName = @alt_names

[v3_req]
subjectAltName = @alt_names

[alt_names]
IP.1 = $SERVERIP
IP.2 = $LOCALLANIP
DNS.1 = localhost" > selfsigned.cnf
fi

# if csr file does not exist, create it
if [ ! -f "selfsigned.csr" ]; then
    openssl req -sha256 -nodes -newkey rsa:4096 -keyout selfsigned.key -out selfsigned.csr -config selfsigned.cnf
fi

# if selfsigned.crt does not exist, create it
if [ ! -f "selfsigned_node.crt" ]; then
    openssl x509 -req -days 398 -in selfsigned.csr -CA CA_cert.pem -CAkey CA_key.pem -CAcreateserial -out selfsigned_node.crt -extensions req_ext -extfile selfsigned.cnf
fi
# if selfsigned.crt does not exist, create it
if [ ! -f "selfsigned.crt" ]; then
  cat selfsigned_node.crt CA_cert.pem > selfsigned.crt
fi
cd ../..

# Start GUI if configured to in env file
echo $RUNDASHBOARD
if [ "$RUNDASHBOARD" == "y" ]
then
echo "Starting operator gui"
# Call the CLI command to set the GUI password
operator-cli gui set password -h $DASHPASS
# Call the CLI command to set the GUI port
operator-cli gui set port $DASHPORT
# Call the CLI command to start the GUI
operator-cli gui start
fi

# Deprecated
# operator-cli set external_port $SHMEXT
# operator-cli set internal_port $SHMINT

echo "done";
EOF
	./entrypoint.sh
	mainmenu
}



mainmenu