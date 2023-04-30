#!/bin/bash
#           ШАПКА
    clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh) && printLogo && printelixir

#       СИСТЕМНЫК ТРЕБОВОНИЯ
    echo -ne "
	$(printGreen  '-----------------------------------------')
	  $(printYellow 'Минимальные требования к оборудованию.')
		     $(printBCyan '4CPU 8RAM 200GB')
	$(printGreen  '-----------------------------------------')"
    echo
#           МЕНЮ
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
		        clear && printLogo && printshardium
		        echo && echo 
		        echo    -ne "$(printRed '		   Неверный запрос !')"
		        echo
		        mainmenu
        	    ;;
                 esac
    }