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
var3=0.16.3

# get version from application output
var4=`nibid version | cut -d ' ' -f 3`

if [[ "$var3" == "$var4" ]]; then
 echo "OK"
else
 echo "update"
fi