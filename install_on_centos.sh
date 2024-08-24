#!/usr/bin/env bash

sudo rm /etc/yum.repos.d/*.repo
# 添加腾讯云源
sudo cp ./centos/Centos-Base.repo /etc/yum.repos.d/Centos-Base.repo
# 添加阿里云源
# sudo cp ./centos/Centos-Base.repo /etc/yum.repos.d/Centos-Base.repo

# 更新源
sudo yum makecache
sudo yum update

# 安装git, curl, wget, openssl vim docker 等基础软件
sudo yum install -y \
     git curl wget openssl lrzsz \
     vim python3-pip \
     ca-certificates gnupg "dnf-command(config-manager)" \
     cmake gcc g++ automake make libssl-devel pkg-config \
     zlib-devel

# 从二进制文件安装docker
sudo bash ./docker/install_docker.sh -s docker --mirror Aliyun

# 启动docker
sudo systemctl enable docker
sudo systemctl start docker

# 安装fzf
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
$HOME/.fzf/install

# 安装ack
curl https://beyondgrep.com/ack-v3.7.0 1>ack 2>/dev/null 
sudo cp ack /usr/bin/ack && sudo chmod 0755 /usr/bin/ack

# 安装neovim
wget https://github.com/neovim/neovim/releases/download/v0.10.1/nvim-linux64.tar.gz
tar -zxf nvim-linux64.tar.gz && sudo cp nvim-linux64/bin/nvim /usr/bin/nvim
sudo pip3 install neovim

# 安装vim-plug 插件
mkdir -p $HOME/.vim/{autoload,colors,doc,plugged,syntax}
cp ./plug.vim $HOME/.vim/autoload/plug.vim

# 配置vimrc
cp ./vim/.vimrc $HOME/.vimrc

# 配置neovim config
mkdir -p $HOME/.config/nvim/
ln -s $HOME/.vimrc $HOME/.config/nvim/init.vim
cp ./vim/coc-settings.json $HOME/.config/nvim/coc-settings.json

# 安装node语言环境
wget https://npmmirror.com/mirrors/node/v20.17.0/node-v20.17.0-linux-x64.tar.xz
tar -xf node-v20.17.0-linux-x64.tar.xz
mkdir -p $HOME/infra/
mv node-v20.17.0-linux-x64 $HOME/infra/node
cp ./node/.npmrc $HOME/.npmrc

# 安装go语言环境
wget https://studygolang.com/dl/golang/go1.23.0.linux-amd64.tar.gz
tar -zxf go1.23.0.linux-amd64.tar.gz
mkdir -p $HOME/infra
mv go $HOME/infra/
mkdir -p $HOME/workspace/go/{src,pkg,bin}
echo 'export GO111MODULE=on' >> $HOME/.bashrc
echo 'export GOPROXY=https://goproxy.io,direct' >> $HOME/.bashrc
echo 'export GOPRIVATE=git.mycompany.com,github.com/my/private' >> $HOME/.bashrc
echo 'export GOROOT=$HOME/infra/go' >> $HOME/.bashrc
echo 'export GOPATH=$HOME/workspace/go' >> $HOME/.bashrc

# 安装rust语言环境
echo 'export RUSTUP_DIST_SERVER="https://rsproxy.cn"' >> $HOME/.bashrc
echo 'export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"' >> $HOME/.bashrc
source $HOME/.bashrc
curl --proto '=https' --tlsv1.2 -sSf https://rsproxy.cn/rustup-init.sh | sh
cp ./rust/config.toml $HOME/.cargo/config
cp ./rust/config.toml $HOME/.cargo/config.toml

# 配置路径
echo 'export PATH=$HOME/infra/node/bin:$GOROOT/bin:$GOPATH/bin:$PATH' >> $HOME/.bashrc

# 启用bashrc相关配置
source $HOME/.bashrc
