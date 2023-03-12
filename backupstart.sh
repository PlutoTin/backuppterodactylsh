#!/bin/bash
if (( $EUID != 0 )); then
    echo "Please run as root"
    exit
fi
clear
helpingtools(){
bash <(curl https://raw.githubusercontent.com/PlutoTin/backuppterodactylsh/main/helpingtools/backuphelpingtoolsstart.sh)
}
varwww(){
bash <(curl https://raw.githubusercontent.com/PlutoTin/backuppterodactylsh/main/www/backupwwwstart.sh)
}
varlib(){
bash <(curl https://raw.githubusercontent.com/PlutoTin/backuppterodactylsh/main/lib/backuplibstart.sh)
}
echo "[0] Helping Tools"
echo "[1] Backup or restore /var/www/pterodactyl"
echo "[2] Backup or restore /var/lib/pterodactyl"
echo "[3] Exit"
read -p "Please enter a number: " choice
if [ "$choice" == "0" ]
then
    helpingtools
fi
if [ "$choice" == "1" ]
then
    varwww
fi
if [ "$choice" == "2" ]
then
    varlib
fi
if [ "$choice" == "3" ]
then
    exit
fi
