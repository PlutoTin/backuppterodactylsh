#!/bin/bash

if (( $EUID != 0 )); then
    echo "Please run as root"
    exit
fi

clear

panelup(){
cd /var/www/pterodactyl
php artisan up
cd /var/www/pterodactyl/../../..
}

paneldown(){
cd /var/www/pterodactyl
php artisan down
cd /var/www/pterodactyl/../../..
}

back(){
bash <(curl https://raw.githubusercontent.com/PlutoTin/backuppterodactylsh/main/backupstart.sh)
}

echo "Becareful this is a test project (/var/www/pterodactyl)"
echo " "
echo "[1] Pterodactyl panel up"
echo "[2] Pterodactyl panel down"
echo "[3] Go back"
echo "[4] Exit"

read -p "Please enter a number: " choice

if [ "$choice" == "1" ]
then
    panelup
fi

if [ "$choice" == "2" ]
then
    paneldown
fi

if [ "$choice" == "3" ]
then
    back
fi

if [ "$choice" == "4" ]
then
    exit
fi
