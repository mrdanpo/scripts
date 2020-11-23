#!/bin/bash

apt-get update -y

# zsh
apt-get install curl \
                git \
                zsh -y

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

cp -rf .zshrc ~/.zshrc

# docker
apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

apt-key fingerprint 0EBFCD88

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable" -y

apt-get update -y && apt-get install docker-ce docker-ce-cli containerd.io -y

# docker-compose
curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

# update system
apt-get update -y && apt-get upgrade -y && apt-get autoremove -y

# enable services
systemctl enable docker
systemctl enable ssh

# unattended upgrades
cp -rf ./etc/apt/apt.conf.d/50unattended-upgrades /etc/apt/apt.conf.d/50unattended-upgrades

reboot now