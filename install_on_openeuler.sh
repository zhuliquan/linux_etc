#!/usr/bin/env bash

# 添加阿里云源
sudo sed -e 's|http://repo.openeuler.org/|https://mirrors.aliyun.com/openeuler/|g' \
         -e 's|https://mirrors.openeuler.org/|https://mirrors.aliyun.com/openeuler/|g' \
         -i.bak \
         /etc/yum.repos.d/openEuler.repo

# 更新源
sudo yum makecache
sudo yum update

# 安装git, curl, wget, openssl vim docker 等基础软件
sudo yum install -y git curl wget openssl \
     vim python3-pip \
     ca-certificates gnupg \
     "dnf-command(config-manager)" \

# 从二进制文件安装docker
# github
sudo curl -fsSL https://github.com/tech-shrimp/docker_installer/releases/download/latest/linux.sh | bash -s docker --mirror Aliyun
# gitee
# sudo curl -fsSL https://gitee.com/tech-shrimp/docker_installer/releases/download/latest/linux.sh| bash -s docker --mirror Aliyun

# 安装fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# 安装ack
curl https://beyondgrep.com/ack-v3.7.0 1>ack 2>/dev/null 
sudo cp ack /usr/bin/ack && sudo chmod 0755 /usr/bin/ack

# 安装neovim
wget https://github.com/neovim/neovim/releases/download/v0.10.1/nvim-linux64.tar.gz
tar -zxf nvim-linux64.tar.gz && sudo cp nvim-linux64/bin/nvim /usr/bin/nvim
sudo pip3 install neovim

# 安装vim-plug 插件
mkdir -p ~/.vim/{autoload,colors,doc,plugged,syntax}
cp ./plug.vim ~/.vim/autoload/plug.vim

# 配置vimrc
cp ./.vimrc ~/.vimrc

# 配置neovim config
mkdir -p ~/.config/nvim/
ln -s ~/.vimrc ~/.config/nvim/init.vim

# 启动docker
sudo systemctl enable docker
sudo systemctl start docker

# 启用bashrc相关配置
source ~/.bashrc
