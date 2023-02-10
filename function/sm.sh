#!/bin/bash
echo "Запуск"

sudo apt install snapd -y > /dev/null 2>&1
snap install btop > /dev/null 2>&1


btop

./x-l1bra