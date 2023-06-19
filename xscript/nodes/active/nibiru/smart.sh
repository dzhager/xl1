#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/common.sh) && printlogo && printnibiru
#-----------------------------------------------------------------------------------------#


git clone https://github.com/NibiruChain/cw-nibiru

nibid tx wasm store $HOME/cw-nibiru/artifacts-cw-plus/cw20_base.wasm --from wallet --gas-adjustment 1.2 --gas auto  --fees 80000unibi  -y &&

read -r -p "  Введите ваш txhash:  " txhash

nibid q tx $txhash -o json |  jq -r '.raw_log' &&

read -r -p "  Введите ваш code_id:  " id

read -r -p "  Введите ваше имя токена:  " var1

read -r -p "  Введите имя символа:  " var2

nibid keys list

read -r -p "  Введите адрес вашего кошелька:  " var3

INIT={"name":"$var1","symbol":"$var2","decimals":6,"initial_balances":[{"address":"$var3","amount":"2000000"}],"mint":{"minter":"$var3"},"marketing":{}}

nibid tx wasm instantiate $id $INIT --from wallet --label "my cw20_base" --gas-adjustment 1.2 --gas auto  --fees 73794unibi --no-admin -y &&

CONTRACT=$(nibid query wasm list-contract-by-code $id --output json | jq -r '.contracts[-1]')

read -r -p "  Введите адрес кошелька для отправки токенов:  " var4

TRANSFER={"transfer":{"recipient":"$var4","amount":"50"}}

nibid tx wasm execute $CONTRACT $TRANSFER --gas-adjustment 1.2 --gas auto --fees 4000unibi --from wallet -y

BALANCE_QUERY={"balance": {"address": "$var4"}}

nibid query wasm contract-state smart $CONTRACT "$BALANCE_QUERY" --output json