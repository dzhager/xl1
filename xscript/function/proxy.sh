#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh) && printLogo
#-----------------------------------------------------------------------------------------#


sudo apt update && sudo apt upgrade -yuf

 sudo apt install -y --no-install-recommends gettext build-essential autoconf libtool libpcre3-dev \
 asciidoc xmlto libev-dev libudns-dev automake libmbedtls-dev \
 libsodium-dev git python-m2crypto libc-ares-dev

 cd /opt

 git clone https://github.com/shadowsocks/shadowsocks-libev.git

 cd shadowsocks-libev
 git submodule update --init --recursive \
 ./autogen.sh
 ./configure
  make && make install
  adduser --system --no-create-home --group shadowsocks
  mkdir -m 755 /etc/shadowsocks


read -r -p "  Введите новый пароль для подключения: " PSS

IP=$(curl ifconfig.co)

cat << EOF  > $HOME/etc/shadowsocks/shadowsocks.json
{
    "server":"$IP",
    "server_port":8388,
    "password":"$PSS",
    "timeout":300,
    "method":"aes-256-gcm",
    "fast_open": true
}
EOF

cat << EOF  > $HOME/etc/systemd/system/shadowsocks.service
[Unit]
Description=Shadowsocks proxy server

[Service]
User=root
Group=root
Type=simple
ExecStart=/usr/local/bin/ss-server -c /etc/shadowsocks/shadowsocks.json -a shadowsocks -v start
ExecStop=/usr/local/bin/ss-server -c /etc/shadowsocks/shadowsocks.json -a shadowsocks -v stop

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable shadowsocks
systemctl start shadowsocks

ufw allow proto tcp to 0.0.0.0/0 port 8388 comment "Shadowsocks server listen port"
