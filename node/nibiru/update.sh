#! /bin/bash
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/function/common.sh)
printLogo
printnibiru
echo
var3=v0.19.2
var4=`nibid version | cut -d ' ' -f 3`

if [[ "$var3" == "$var4" ]]; then
 echo -ne "$(printBGreen '	У вас уже установлена последняя версия!')"
 mainmenu
else
 	update
fi


update(){
cd $HOME
rm -rf nibiru
git clone https://github.com/NibiruChain/nibiru.git
cd nibiru
git checkout v0.19.2
make build
mkdir -p $HOME/.nibid/cosmovisor/genesis/bin
mv build/nibid $HOME/.nibid/cosmovisor/genesis/bin/
rm -rf build
sudo systemctl restart nibid
submenu
}

mainmenu(){
	echo -ne "
	$(printBCyan '	Для возврата нажмите Enter:')  "
		read -r ans
		case $ans in
			*)
			source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/nibiru/main.sh)
			;;
	esac
}

submenu(){
	echo -ne "
	$(printBGreen '	Обновление завершено!')
	$(printBCyan '	Для возврата нажмите Enter:')  "
		read -r ans
		case $ans in
			*)
			source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/node/nibiru/main.sh)
			;;
	esac
}