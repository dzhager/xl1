#!/bin/bash

#! /bin/bash

#X-l1bra  
clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)
printLogo
printnibiru

apt install curl iptables build-essential git wget jq make gcc nano tmux htop nvme-cli pkg-config libssl-dev libleveldb-dev tar clang bsdmainutils ncdu unzip libleveldb-dev -y
curl -s https://get.nibiru.fi/! | bash
nibid version --long | grep -e version -e commit
nibid config node https://rpc.itn-1.nibiru.fi:443
nibid config chain-id nibiru-itn-1
nibid config broadcast-mode block
nibid config keyring-backend os
mkdir -p $HOME/wasm && cd $HOME/wasm
wget https://github.com/NibiruChain/cw-nibiru/raw/main/artifacts-cw-plus/cw20_base.wasm
nibid tx wasm store $HOME/wasm/cw20_base.wasm --from wallet --gas 8000000 --fees 200000unibi
