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

echo "Install Java"
open "http://www.oracle.com/technetwork/java/javase/downloads/index.html"

echo "Install Go"
open "https://golang.org/doc/install"

echo "Download Docker"
open "https://www.docker.com/"

echo "Install XQuartz"
open "https://www.xquartz.org/"

echo "Install Max"
open "http://sbooth.org/Max/#download"

echo "Install Toolbox App"
open "https://www.jetbrains.com/toolbox/app/"

echo "Install Digikam"
echo "Install pCould Drive"

echo "hit enter when done"
read

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
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

brew tap caskroom/cask
brew cask install kdiff3
brew cask install vlc
brew cask install google-chrome
brew cask install google-drive
brew cask install sourcetree
brew cask install utorrent
brew cask install macpass
brew cask install telegram-desktop
brew cask install sublime-text
brew cask install postman
brew cask install graphiql

brew install Caskroom/cask/osxfuse
brew install sshfs

python3 -m pip install gdbgui --upgrade

sudo mkdir -p /usr/local/bin
ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl

sh -c "$(curl -fsSL https://raw.githubusercontent.com/cpollet/dotfiles/master/install.sh)"

echo "Initial setup done. Hit enter to reboot"
read
sudo reboot