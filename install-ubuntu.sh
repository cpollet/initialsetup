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
  docker-ce

sh -c "$(curl -fsSL https://raw.githubusercontent.com/cpollet/dotfiles/master/install.sh)"
