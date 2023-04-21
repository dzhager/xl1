#!/bin/bash
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)

whiptail --title X-l1bra \
--ok-button "продолжить" \
--msgbox "Здесь должна быть важная информация." 20 60

OPTION=$(whiptail --title "Выбирете блокчейн проэкт" --menu "Выберите блюдо:" 15 60 5 \
--ok-button "продолжить" --cancel-button "отмена" \
"1" "Shardeum" \
"2" "Nibiru" \
"3" "DeFund" \
"4" "Celestia" \
"5" "ZcSync" \
"6" "Aleo" \
3>&1 1>&2 2>&3)

if [ $? = 0 ]; then
	echo "Пользователь выбрал пункт номер $OPTION"
	echo Пупер супер выбор
else
	echo "Отмена"
f