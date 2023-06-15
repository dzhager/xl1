#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh) && printLogo
#-----------------------------------------------------------------------------------------#

#-------------------------------------Основное меню---------------------------------------#


    mainmenu() {
        echo
        echo "$(printBCyan '            -->') $(printBYellow '1)') $(printBGreen    'Установить')"
        echo
        echo "$(printBCyan '            -->') $(printBYellow '2)') Просмотреть адрес прокси"
        echo "$(printBCyan '            -->') $(printBYellow '3)') Просмотреть статус"
        echo "$(printBCyan '            -->') $(printBYellow '4)') Изменить логин-пароль"
        echo
        echo "$(printBCyan '            -->') $(printBYellow '5)') Помощь"
        echo
        echo "$(printBCyan '            -->') $(printBRed     '6) Удалить')"
        echo 
        echo "$(printBBlue '            <-- 7) Назад')"
        echo
        echo "$(printBRed        '                0) Выход')"
        echo
        echo -ne "$(printBGreen ' Введите цифру:') $(printYellowBlink '-->') "
	#-------------------------Свойства меню-------------------------#
		read -r ans
			case $ans in
		#---------------------------------------#
			1)
			install
			;;
		#---------------------------------------#
            2)
			adress
			;;
        #---------------------------------------#    
			3)
			status
			;;
		#---------------------------------------#
			4)
			passwd
			;;
        #---------------------------------------#
            5)
			help
			;;
		#---------------------------------------#
			6)
			delet
			;;
		#---------------------------------------#	
			7)
			back
			;;
		#---------------------------------------#
			0)
			echo $(printBCyan '	"Bye bye."')
			exit
			;;
		#---------------------------------------#	
			*)
			clear && printLogo && echo
            echo "$(printBYellow ' ============================================================')"
			echo    "$(printBRed '		           Неверный запрос !')"
            echo "$(printBYellow ' ============================================================')"
			echo
			mainmenu
			;;
		#---------------------------------------#
			esac
}

adress(){
    IP=$(curl ifconfig.co)
    clear && printLogo
    echo
    echo "$(printBYellow ' ============================================================')"
	echo " $(printBYellow              "                   $IP":1080)"
    echo "$(printBYellow ' ============================================================')"
	mainmenu
}

delet(){
	sudo apt
}


status(){
    clear && printLogo && systemctl status danted.service && mainmenu
}

passwd(){

echo "$(printBGreen ' Введите имя пользователя для подключения к прокси')"
echo -ne "$(printBGreen ' Ввод:') $(printYellowBlink '-->') "
read -r USERNAME
sudo useradd -r -s /bin/false $USERNAME
echo "$(printBGreen ' Введите пароль для подключения к прокси')"
sudo passwd $USERNAME
sudo systemctl restart danted

}


install(){

echo "$(printBYellow 'Идет установка Dante...')"

sudo apt update && sudo apt install dante-server
sudo rm /etc/danted.conf
cat << EOF  > /etc/danted.conf
logoutput: syslog
user.privileged: root
user.unprivileged: nobody

# The listening network interface or address.
internal: 0.0.0.0 port=1080

# The proxying network interface or address.
external: eth0

# socks-rules determine what is proxied through the external interface.
socksmethod: username

# client-rules determine who can connect to the internal interface.
clientmethod: none

client pass {
    from: 0.0.0.0/0 to: 0.0.0.0/0
}

socks pass {
    from: 0.0.0.0/0 to: 0.0.0.0/0
}
EOF

sudo ufw allow 1080

echo "$(printBGreen ' Введите имя пользователя для подключения к прокси')"
echo -ne "$(printBGreen ' Ввод:') $(printYellowBlink '-->') "
read -r USERNAME
sudo useradd -r -s /bin/false $USERNAME
echo "$(printBGreen ' Введите пароль для подключения к прокси')"
sudo passwd $USERNAME

sudo systemctl restart danted.service
echo
echo "$(printBGreen ' Ваш прокси настроен!')"
mainmenu
}

help(){
clear && printLogo
    echo "$(printBYellow ' =============================================================')"
    echo "  Dante - прокси-сервер SOCKS5 с открытым исходным кодом."
    echo "  SOCKS - менее распространенный протокол, но он более эффект"
    echo "  ивен для некоторых одноранговых приложений и предпочтительн"
    echo "  ее HTTP для некоторых видов трафика."
    echo "$(printBYellow '  По умолчанию используется порт') $(printBCyan '1080')"
    echo "$(printBYellow ' =============================================================')"
	echo -ne " 
Для того, чтобы изменить порт, откройте файл конфигурации danted. 
Выполните комнаду: $(printBCyan 'sudo nano /etc/danted.conf')
Вы увидите содержимое файла danted.conf 
Найдите строку, содержащую $(printBMagenta 'internal: 0.0.0.0 port=1080') 
Обычно она находится на 6-й строке файла. Измените значение порта 
на необходимое вам, например: $(printBMagenta 'port=8888.') 

После внесения изменений нажмите Ctrl + O, подтвердите сохранение
файла, нажав Enter. Затем нажмите Ctrl + X, чтобы выйти из редактора Nano.

Перезапустите службу Dante: $(printBCyan 'sudo systemctl restart danted')

После перезапуска службы Dante будет работать на новом порту, 
указанном в конфигурационном файле.
$(printBYellow '----------------------------------------------------------------')
"

	mainmenu
}


mainmenu