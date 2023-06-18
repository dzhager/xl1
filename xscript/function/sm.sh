#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/common.sh) && printlogo
#-----------------------------------------------------------------------------------------#

#!/bin/bash

# Проверка наличия установленного пакета btop через snap
if ! snap list | grep -q btop; then
    echo "Установка пакета btop..."
    sudo apt install snapd
    sudo snap install btop
    echo "Пакет btop установлен."
fi

# Запуск btop
echo "Запуск btop..."
snap run btop

source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/menu/homemenu.sh)
#-----------------------------Основное меню-----------------------------------------#
# mainmenu() {
# 	echo -ne "
# 	$(printYellow    'Для того что бы выйти из системного монитора нажмите') $(printBRed 'q') $(printYellow '!!!')
# 	$(printBCyan ' -->') $(printBGreen    'Нажмите') $(printBCyan 'Enter') $(printBGreen 'для запуска')
# 	$(printBCyan ' -->') $(printBYellow   'Для установки введите цифру') $(printBCyan '2') $(printBYellow 'и нажмите') $(printBCyan 'Enter')
# 	$(printCyan	'Введите цифру:') "
# 	read -r ans
# 	case $ans in

# 		2)
# 		echo -ne "
# 		$(printBCyan ' -->') $(printBYellow    'Установка.....') "
# 		sudo apt update  > /dev/null 2>&1
# 		sudo apt install snapd -y > /dev/null 2>&1
# 		snap install btop > /dev/null 2>&1
# 		btop
# 		;;

# 		*)
# 		btop
#         ;;

#     esac
# }
# mainmenu
# source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/menu/homemenu.sh)



    # if [ $(dpkg-query -W -f='${Status}' snapd 2>/dev/null | grep -c "ok installed") -eq 0 ];
    # then
    #     echo "$(printBYellow    '     Подождите, идет первоначальная установка!')"
    #     sudo apt update  > /dev/null 2>&1 && sudo apt install snapd -y && snap install btop 
	# 	btop
    # else
    #     btop
    # fi
