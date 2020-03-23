#!/bin/bash

sudo apt install \
	transmission-daemon \
	cifs-utils

sudo systemctl stop transmission-daemon.service

sudo sed -i 's/Download/download/g' /etc/transmission-daemon/settings.json

echo "Edit transmission config. Check rpc-* keys."
echo "Refer to https://doc.ubuntu-fr.org/transmission#transmission-daemon_et_le_fichier_settingsjson for doc"
read

sudo vi /etc/transmission-daemon/settings.json

echo "Enter SMB volume"
read smb_volume
echo "Enter SMB username"
read smb_username
echo "Enter SMB password"
read -s smb_password

sudo touch /etc/transmission-daemon/smbcredentials
sudo chmod 600 /etc/transmission-daemon/smbcredentials
sudo sh -c "echo \"username=$smb_username\npassword=$smb_password\" > /etc/transmission-daemon/smbcredentials"

sudo sh -c "echo \"\n\n//nas/Torrents /var/lib/transmission-daemon/downloads cifs cred=/etc/transmission-daemon/smbcredentials,iocharset=utf8,sec=ntlm,vers=1.0,uid=$(id -u debian-transmission) 0 0\" >> /etc/fstab"

sudo systemctl start transmission-daemon.service
