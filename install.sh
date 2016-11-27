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

echo "Install Java"
open "http://www.oracle.com/technetwork/java/javase/downloads/index.html"

echo "Download Docker"
open "https://www.docker.com/"

echo "hit enter when done"
read

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install maven
brew install htop
brew install gnu-sed

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
brew cask install intellij-idea
brew cask install datagrip

brew install Caskroom/cask/osxfuse
brew install homebrew/fuse/sshfs

sudo mkdir -p /usr/local/bin
ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
mkdir -p ~/.oh-my-zsh/custom/themes
curl https://raw.githubusercontent.com/cpollet/initialsetup/master/cpollet.zsh-theme > ~/.oh-my-zsh/custom/cpollet.zsh-theme
gsed -i 's/robbyrussell/cpollet/g' ~/.zshrc

echo "Initial setup done. Hit enter to reboot"
sudo reboot
