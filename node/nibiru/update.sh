#! /bin/bash
	clear && source <(curl -s https://raw.githubusercontent.com/dzhager/xl1/main/function/common.sh)
printLogo
printnibiru
echo

# example command:
#git --version
# output:
#git version 2.30.2

# version to compare
var3=v0.16.3

# get version from application output
var4=`nibid version | cut -d ' ' -f 3`

if [[ "$var3" == "$var4" ]]; then
 echo -ne "$(printBGreen '	У вас уже установлена последняя версия!')"
 mainmenu
else
 	uptade
fi


uptade(){
cd $HOME
rm -rf nibiru
git clone https://github.com/NibiruChain/nibiru.git
cd nibiru
git checkout v0.16.3
make build
mkdir -p $HOME/.nibid/cosmovisor/genesis/bin
mv build/nibid $HOME/.nibid/cosmovisor/genesis/bin/
rm -rf build
sudo systemctl restart nibid
}

mainmenu(){
	echo -ne "
	$(printBCyan '	Для возврата нажмите Enter:')  "
		read -r ans
		case $ans in
			*)
			source <(curl -s https://raw.githubusercontent.com/dzhager/xl1/main/node/nibiru/main.sh)
			;;
	esac
}