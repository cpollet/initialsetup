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
  keepass2 \
  java-common \
  maven \
  vlc \
  libreoffice \
  remmina

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

# https://www.opsdash.com/blog/oracle-jdk-debian-ubuntu.html
# https://gist.github.com/olagache/a2eff8b2bbc95e03280b
sudo mkdir -p /usr/lib/jvm/
echo "Downlaod Java 8 from https://www.oracle.com/java/technologies/javase-downloads.html"
echo "Untar in in /usr/lib/jvm/"
echo "Press enter to continue"
echo "What's the JDK name?"
read JDK

if [ ! -f /usr/lib/jvm/$JDK/bin/javac ]; then
	echo "/usr/lib/jvm/$JDK/bin/javac does not exist!"
else
	echo "name=$JDK" > /tmp/$JDK.jinfo
	echo "alias=oracle-jdk1.8" >> /tmp/$JDK.jinfo
	echo "priority=180" >> /tmp/$JDK.jinfo
	echo "section=main" >> /tmp/$JDK.jinfo
	for file in $(find /usr/lib/jvm/$JDK/jre/bin/ -type f -executable); do
		executable=$(echo $file | rev | cut -d'/' -f1 | rev)
		echo "jre $executable /usr/lib/jvm/$JDK/jre/bin/$executable" >> /tmp/$JDK.jinfo
		sudo update-alternatives --install /usr/bin/$executable $executable /usr/lib/jvm/$JDK/jre/bin/$executable 180
	done
	for file in $(find /usr/lib/jvm/$JDK/bin/ -type f -executable); do
		executable=$(echo $file | rev | cut -d'/' -f1 | rev)
		inJre=$(grep $executable /tmp/$JDK.jinfo | wc -l)
		if [ $inJre -eq 0 ]; then
			echo "jdk $executable /usr/lib/jvm/$JDK/bin/$executable" >> /tmp/$JDK.jinfo
			sudo update-alternatives --install /usr/bin/$executable $executable /usr/lib/jvm/$JDK/bin/$executable 180
		fi
	done
	sudo mv /tmp/$JDK.jinfo /usr/lib/jvm/.$JDK.jinfo
	sudo update-java-alternatives -s $JDK
	# sudo sh -c 'echo "export JAVA_HOME=\"/opt/java\"" >> /etc/profile.d/environment.sh'
fi
echo "Installed versions of Java"
update-java-alternatives -l

sudo update-alternatives --config editor
sudo update-alternatives --config x-www-browser
sudo update-alternatives --config x-terminal-emulator
sudo update-alternatives --config gnome-www-browser

echo "Finised. Press enter to reboot"
read
sudo reboot
