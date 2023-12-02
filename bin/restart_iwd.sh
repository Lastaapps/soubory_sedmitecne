#!/bin/bash

sudo systemctl restart systemd-networkd
sudo systemctl stop iwd

dir=/var/lib/iwd/
sudo cp "${dir}"SiliconHill.8021x.backup "${dir}"SiliconHill.8021x
sudo cp "${dir}"eduroam.8021x.backup "${dir}"eduroam.8021x

sudo systemctl start iwd
