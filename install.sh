#!/usr/bin/env bash

# 添加阿里云源
sudo sed -i 's/http:\/\/archive.ubuntu.com\/ubuntu/https:\/\/mirrors.aliyun.com\/ubuntu/g' /etc/apt/sources.list
sudo sed -i 's/http:\/\/security.ubuntu.com\/ubuntu/https:\/\/mirrors.aliyun.com\/ubuntu/g' /etc/apt/sources.list

# 更新源
sudo apt-get update

# 安装git, curl, wget, openssl vim neovim ack 等基础软件
sudo apt-get install -y git curl wget openssl \
     ack vim neovim python3-pip \
     apt-transport-https \
     ca-certificates gnupg lsb-release

# 添加docker GPG 密钥
curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# 添加docker镜像源
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://mirrors.aliyun.com/docker-ce/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 更新源
sudo apt-get update

# 安装docker
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# 安装fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# 安装vim-plug 插件
mkdir -p ~/.vim/{autoload,colors,doc,plugged,syntax}
cp ./plug.vim ~/.vim/autoload/plug.vim

# 配置vimrc
cp ./.vimrc ~/.vimrc

# 配置neovim config
sudo pip3 install neovim
mkdir -p ~/.config/nvim/
ln -s ~/.vimrc ~/.config/nvim/init.vim

# 启动docker
sudo systemctl enable docker
sudo systemctl start docker
