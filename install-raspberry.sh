#!/bin/bash

sudo apt update
sudo apt upgrade

sudo apt install \
  transmission-daemon \
  cifs-utils

sudo snap install docker

sudo groupadd docker
sudo usermod -aG docker $USER

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

#source: https://github.com/pi-hole/docker-pi-hole#running-pi-hole-docker
#source: https://github.com/pi-hole/docker-pi-hole#installing-on-ubuntu"

sudo sed -r -i.orig 's/#?DNSStubListener=yes/DNSStubListener=no/g' /etc/systemd/resolved.conf
sudo sh -c 'rm /etc/resolv.conf && ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf'
sudo systemctl restart systemd-resolved

echo "Installing Pi-hole."
echo -n "Enter you web UI password: "
read -s PASSWORD
echo -n "Enter the IP address: "
read IPADDR
echo -n "Enter the host: "
read HOST

PIHOLE_BASE=/etc/pihole
[[ -d "$PIHOLE_BASE" ]] || sudo mkdir -p "$PIHOLE_BASE" || { echo "Couldn't create storage directory: $PIHOLE_BASE"; exit 1; }
docker run -d \
    --name pihole \
    -p 53:53/tcp \
    -p 53:53/udp \
    -p 80:80 \
    --network=host \
    -v "${PIHOLE_BASE}/pihole:/etc/pihole" \
    -v "${PIHOLE_BASE}/dnsmasq.d:/etc/dnsmasq.d" \
    --dns=127.0.0.1 --dns=1.1.1.1 \
    --restart=unless-stopped \
    -e WEBPASSWORD=$PASSWORD \
    -e VIRTUAL_HOST=$HOST \
    -e FTLCONF_REPLY_ADDR4=$IPADDR \
    pihole/pihole:latest

docker logs -f pihole

echo
echo "Finised. Press enter to reboot"
read
sudo reboot
