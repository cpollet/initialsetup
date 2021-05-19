#!/bin/bash

sudo scutil --set ComputerName "cpollet-laptop"
sudo scutil --set LocalHostName "cpollet-laptop"
sudo scutil --set HostName "cpollet-laptop"
dscacheutil -flushcache

mkdir -p ~/{Development,Admin}

echo "Install Xcode"
open -a "App Store"

echo "hit entre when done"
read

"Install xcode-select"
xcode-select --install

echo "Install Java (opt)"
open "http://www.oracle.com/technetwork/java/javase/downloads/index.html"

echo "Install Go"
open "https://golang.org/doc/install"

echo "Install rust"
open "https://www.rust-lang.org/tools/install"

echo "Download Docker"
open "https://www.docker.com/"

echo "Install XQuartz"
open "https://www.xquartz.org/"

echo "Install Max"
open "http://sbooth.org/Max/#download"

echo "Install HandBrake"
open "https://handbrake.fr/"

echo "Install Toolbox App"
open "https://www.jetbrains.com/toolbox/app/"

echo "Install Digikam"
echo "Install pCould Drive"

echo "Install Folx"
open "https://mac.eltima.com/download-manager.html"

echo "Install Firefox"
open "https://www.mozilla.org/fr/firefox/mac/"

echo "Install Thunderbird"
open "https://www.thunderbird.net/fr/"

echo "Install Spotify"
open "https://www.spotify.com/ch-fr/download/mac/"

echo "Install 1password"
open "https://1password.com/"

echo "Install Zwift"
open "https://www.zwift.com/"

echo "Install zoom"
echo "https://zoom.us/"

echo "Install Skype"

echo "Install MS Remote Desktop"
echo "Install Citrix Workspace"
echo "Install VirtualBox"
echo "Install LibreOffice"

echo "Install Tunnelblick"
open "https://tunnelblick.net"

echo "Install kDrive"
echo "Install pCloud"

echo "hit enter when done"
read

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install maven
brew install gradle
brew install htop
brew install gnu-sed
brew install node
brew install socat
brew install easy-tag
brew install watch
brew install gdb
brew install gpg
brew install java

brew tap caskroom/cask
brew cask install kdiff3
brew cask install vlc
brew cask install google-chrome
brew cask install google-drive
brew cask install sourcetree
# brew cask install macpass
# brew cask install telegram-desktop
brew cask install sublime-text
brew cask install postman
brew cask install graphiql
brew cask install transmission-remote-gui

brew install Caskroom/cask/osxfuse
brew install sshfs

python3 -m pip install gdbgui --upgrade

sudo mkdir -p /usr/local/bin
ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl

/usr/libexec/java_home -V

echo "Initial setup done. Hit enter to reboot"
read
sudo reboot
