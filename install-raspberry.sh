#!/bin/bash

sudo apt update
sudo apt upgrade

sudo apt install \
	transmission-daemon \
	cifs-utils

echo
sudo update-alternatives --config editor

sudo systemctl stop transmission-daemon.service

sudo sed -i 's/Download/download/g' /etc/transmission-daemon/settings.json

echo
echo "Edit transmission config. Check rpc-* keys."
echo "Refer to https://doc.ubuntu-fr.org/transmission#transmission-daemon_et_le_fichier_settingsjson for doc"
read

sudo vi /etc/transmission-daemon/settings.json

echo
echo "Enter SMB volume"
read smb_volume
echo "Enter SMB username"
read smb_username
echo "Enter SMB password"
read -s smb_password

sudo touch /etc/transmission-daemon/smbcredentials
sudo chmod 600 /etc/transmission-daemon/smbcredentials
sudo sh -c "echo \"username=$smb_username\npassword=$smb_password\" > /etc/transmission-daemon/smbcredentials"

sudo sh -c "echo \"\n\n$smb_volume /var/lib/transmission-daemon/downloads cifs cred=/etc/transmission-daemon/smbcredentials,iocharset=utf8,sec=ntlm,vers=1.0,uid=$(id -u debian-transmission) 0 0\" >> /etc/fstab"
sudo mount -a

sudo systemctl start transmission-daemon.service

echo
ssh-keygen

echo
read -p "Enter user@host where to copy you SSH key (empty to stop): " host
until [[ $host == '' ]]; do
  ssh -t $host "echo '$(cat ~/.ssh/id_rsa.pub)' >> .ssh/authorized_keys"
  read -p "Enter user@host where to copy you SSH key (empty to stop):" host
done

# source: https://www.cyberciti.biz/faq/howto-setup-openvpn-server-on-ubuntu-linux-14-04-or-16-04-lts/
wget https://git.io/vpn -O ~/openvpn-install.sh
chmod a+x ~/openvpn-install.sh
sudo ~/openvpn-install.sh