#!/bin/bash

sudo scutil --set ComputerName "cpollet-laptop"
sudo scutil --set LocalHostName "cpollet-laptop"
sudo scutil --set HostName "cpollet-laptop"
dscacheutil -flushcache

echo "Install Xcode"
open -a "App Store"

echo "hit entre when done"
read

echo "Download Chrome"
open "https://www.google.com/chrome/browser/desktop/index.html"

echo "Install Java"
open "http://www.oracle.com/technetwork/java/javase/downloads/index.html"

echo "Download MacPass"
open "http://mstarke.github.io/MacPass/"

echo "Download IDEs"
open "https://www.jetbrains.com/products.html"

echo "Download Docker"
open "https://www.docker.com/"

echo "Download Google Drive"
open "https://www.google.com/intl/en/drive/download/"

echo "Download SourceTree"
open "https://www.sourcetreeapp.com"

echo "Download Telegram"
open "https://macos.telegram.org/"

echo "Download VLC"
open "http://www.videolan.org/vlc/"

echo "Download uTorrent"
open "http://www.utorrent.com/intl/en/"

echo "Download Sublimetext"
open "https://www.sublimetext.com/"

echo "hit enter when done"
read

sudo mkdir -p /usr/local/bin
ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl

mkdir -p ~/{Development,Admin}

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install maven
brew install htop
brew install gnu-sed

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
mkdir -p ~/.oh-my-zsh/custom/themes
curl https://raw.githubusercontent.com/cpollet/initialsetup/master/cpollet.zsh-theme > ~/.oh-my-zsh/custom/cpollet.zsh-theme
gsed -i 's/robbyrussell/cpollet/g' ~/.zshrc

echo "Initial setup done. Hit enter to reboot"
sudo reboot

