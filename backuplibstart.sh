#!/bin/bash

if (( $EUID != 0 )); then
    echo "Please run as root"
    exit
fi


clear


backupwd(){
    cd /var/lib/pterodactyl || exit
    php artisan down
    cd /var/lib/ || exit
    tar -czvf backup.tar.gz /var/lib/pterodactyl
    cd /var/lib/pterodactyl || exit
    php artisan up
     cd /var/lib/pterodactyl/../../.. || exit
}


restorewd(){
    cd /var/lib/pterodactyl || exit
    php artisan down 
    cd /var/lib/ || exit 
    tar -xzvf backup.tar.gz -C /var/lib
    cd /var/lib/../.. || exit 
    cd /var/lib/pterodactyl || exit 
    php artisan up
    cd /var/lib/pterodactyl/../../.. || exit
}


backupwod(){
    cd /var/lib/pterodactyl || exit 
    cd /var/lib/ || exit 
    tar -czvf backup.tar.gz /var/lib/pterodactyl 
    cd /var/lib/pterodactyl || exit 
    cd /var/lib/pterodactyl/../../.. || exit
}


restorewod(){
    cd /var/lib/pterodactyl && cd /var/lib/ || exit 
    tar -xzvf backup.tar.gz -C /var/lib 
    cd /var/lib/../.. || exit 
    cd /var/lib/pterodactyl || exit 
    cd /var/lib/pterodactyl/../../.. || exit
}


backuplocal(){
    cd /var/lib/pterodactyl || exit
    php artisan down
    read -p "Please enter the IP address: " ip_address
    read -p "Please enter the download location: " download_location
    scp -r root@"$ip_address":/var/lib/pterodactyl "$download_location"
    php artisan up
}


backuptargzlocal(){
    cd /var/lib/pterodactyl || exit
    php artisan down
    read -p "Please enter the IP address: " ip_address
    read -p "Please enter the download location: " download_location
    tar -czvf backuplocal.tar.gz /var/lib/pterodactyl/*
    scp -r backuplocal.tar.gz root@"$ip_address":"$download_location"
    rm backuplocal.tar.gz
    php artisan up
}




echo "Becareful this is a test project"
echo " "
echo "[1] Backup with panel down"
echo "[2] Restore with panel down"
echo "[3] Backup without panel down"
echo "[4] Restore without panel down"
echo "[5] Backup local in computer (download)"
echo "[6] Backup local in computer (zip and download)"
echo "[7] Exit"


read -p "Please enter a number: " choice


if [ "$choice" == "1" ]
then
    backupwd
fi


if [ "$choice" == "2" ]
then
    restorewd
fi


if [ "$choice" == "3" ]
then
    backupwod
fi


if [ "$choice" == "4" ]
then
    restorewod
fi


if [ "$choice" == "5" ]
then
    backuplocal
fi


if [ "$choice" == "6" ]
then
    backuptargzlocal
fi


if [ "$choice" == "7" ]
then
    exit
fi
