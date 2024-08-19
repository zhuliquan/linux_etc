#!/usr/bin/env bash

# 安装git, curl, wget, openssl vim neovim ack
sudo apt-get update
sudo apt-get install -y git curl wget openssl vim neovim ack python3-pip

# 安装fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# 安装vim-plug 插件
mkdir -p ~/.vim/{autoload,colors,doc,plugged,syntax}
cp ./plug.vim ~/.vim/autoload/plug.vim

# 配置vimrc
cp ./.vimrc ~/.vimrc

# 配置neovim config
mkdir -p ~/.config/nvim/
ln -s ~/.vimrc ~/.config/nvim/init.vim

