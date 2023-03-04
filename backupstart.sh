#!/bin/bash

if (( $EUID != 0 )); then
    echo "Please run as root"
    exit
fi

clear

installTheme(){
    echo "backup..."
    cd /var/www/
    tar -czvf backup.tar.gz pterodactyl
    cd /var/www/../..
    
    
}

installThemeQuestion(){
    while true; do
        read -p "Are you sure that you want to install the theme [y/n]? " yn
        case $yn in
            [Yy]* ) installTheme; break;;
            [Nn]* ) exit;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

restoreBackUp(){
    echo "Restoring backup..."
    cd /var/www/
    tar -xzvf MinecraftPurpleThemebackup.tar.gz
    cd /var/www/../..

    cd /var/www/pterodactyl
    yarn build:production
    sudo php artisan optimize:clear
}

echo "This program is modify from https://github.com/Angelillo15/MinecraftPurpleTheme"
echo "[1] Install theme"
echo "[2] Restore backup
echo "[4] Exit"

read -p "Please enter a number: " choice
if [ $choice == "1" ]
    then
    installThemeQuestion
fi
if [ $choice == "2" ]
    then
    restoreBackUp
fi
if [ $choice == "3" ]
    then
    repair
fi
if [ $choice == "4" ]
    then
    exit
fi