﻿#!/bin/bash


if (( $EUID != 0 )); then
    echo "Please run as root"
    exit
fi


clear


backupwd(){
    cd /var/www/pterodactyl
    php artisan down
    cd /var/www/
    tar -czvf backup.tar.gz /var/www/pterodactyl
    cd /var/www/pterodactyl
    php artisan up
     cd /var/www/pterodactyl/../../..
}


restorewd(){
    cd /var/www/pterodactyl && php artisan down && cd /var/www/ && tar -xzvf backup.tar.gz -C /var/www && cd /var/www/../.. && cd /var/www/pterodactyl && php artisan up && cd /var/www/pterodactyl/../../..
}




backupwod(){
    cd /var/www/pterodactyl && cd /var/www/ && tar -czvf backup.tar.gz /var/www/pterodactyl && cd /var/www/pterodactyl && cd /var/www/pterodactyl/../../..
}


restorewod(){
    cd /var/www/pterodactyl && cd /var/www/ && tar -xzvf backup.tar.gz -C /var/www && cd /var/www/../.. && cd /var/www/pterodactyl && cd /var/www/pterodactyl/../../..
}


backuplocal(){
    cd /var/www/pterodactyl
    php artisan down
    read -p "Please enter the IP address: " ip_address
    read -p "Please enter the download location: " download_location
    scp -r root@$ip_address:/var/www/pterodactyl $download_location
    php artisan up
}


backuptargzlocal(){
    cd /var/www/pterodactyl
    php artisan down
    read -p "Please enter the IP address: " ip_address
    read -p "Please enter the download location: " download_location
    tar -czvf backuplocal.tar.gz ./*
    scp -r backuplocal.tar.gz root@$ip_address:$download_location
    rm backuplocal.tar.gz
    php artisan up
}






echo "[1] Backup with panel down"
echo "[2] Restore with panel down"
echo "[3] Backup without panel down"
echo "[4] Restore without panel down"
echo "[5] Backup local in computer (download)"
echo "[6] Backup local in computer (zip and download)"
echo "[7] Exit"


read -p "Please enter a number: " choice


if [ $choice == "1" ]
then
    backupwd
fi


if [ $choice == "2" ]
then
    restorewd
fi


if [ $choice == "3" ]
then
    backupwod
fi


if [ $choice == "4" ]
then
    restorewod
fi


if [ $choice == "5" ]
then
    backuplocal
fi


if [ $choice == "6" ]
then
    backuptargzlocal
fi


if [ $choice == "7" ]
then
    exit
fi
