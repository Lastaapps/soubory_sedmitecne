#!/usr/bin/env bash

DIR="/mnt/fit"

#sudo apt install openvpn network-manager-openvpn-gnome
#sudo apt install cifs-utils

nmcli connection up fit-vpn

mkdir $DIR 2> /dev/null

sudo mount -t cifs //drive.fit.cvut.cz/home/${CTU_USERNAME} ${DIR} -o sec=ntlmv2i,fsc,file_mode=0755,dir_mode=0700,user=${CTU_USERNAME},dir_mode=0755

