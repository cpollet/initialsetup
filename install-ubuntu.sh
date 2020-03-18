mkdir ~/{Admin,Development}

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list

wget -q -O - https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
echo 	"deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker-ce.list

sudo apt-get update

sudo apt-get install \
  openssh-server \
  kdiff3 \
  zsh \
  git \
  curl \
  google-chrome-stable \
  docker \
  htop \
  npm \
  docker-ce \
  vim \
  terminator \
  keepass2

sudo groupadd docker
sudo usermod -aG docker ${USER}

sudo groupadd docker
sudo usermod -aG docker $USER

sh -c "$(curl -fsSL https://raw.githubusercontent.com/cpollet/dotfiles/master/install.sh)"

mkdir -p ~/.fonts
echo "Download SourceCodeVariable-Roman.otf from https://github.com/adobe-fonts/source-code-pro/releases/latest"
echo "Put it in ~/.fonts"
echo "Press enter to continue"
read

D=`pwd`
cd ~
fc-cache -f -v
cd "$D"

mkdir -p /opt
echo "Download Jetbrains toolbox from https://www.jetbrains.com/toolbox-app/download/download-thanks.html"
echo "Untar in in /opt and create a symlink /opt/jetbrains-toolbox to it"
echo "Press enter to continue"
read
if [ ! -f "/opt/jetbrains-toolbox/jetbrains-toolbox" ]; then
	echo "/opt/jetbrains-toolbox/jetbrains-toolbox does not exist!"
else
	sudo chomd a+x /opt/pcloud	
	sudo ln -s /opt/jetbrains-toolbox/jetbrains-toolbox /usr/local/bin/jetbrains-toolbox
	jetbrains-toolbox	
fi

echo "Download pCloud from https://www.pcloud.com/download-free-online-cloud-file-storage.html"
echo "Put it in /opt"
echo "Press enter to continue"
read
if [ ! -f "/opt/pcloud" ]; then
	echo "/opt/pcloud does not exist!"
else
	sudo chomd a+x /opt/pcloud
	sudo ln -s /opt/pcloud /usr/local/bin/pcloud
	pcloud
fi

# todo
# java, maven

echo "Finised. Press enter to reboot"
read
sudo reboot
