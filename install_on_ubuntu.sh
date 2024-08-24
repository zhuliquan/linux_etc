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
     ca-certificates gnupg lsb-release \
	 lrzsz

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

# 启动docker
sudo systemctl enable docker
sudo systemctl start docker

# 安装fzf
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
$HOME/.fzf/install

# 安装vim-plug 插件
mkdir -p $HOME/.vim/{autoload,colors,doc,plugged,syntax}
cp ./vim/plug.vim $HOME/.vim/autoload/plug.vim

# 配置vimrc
cp ./vim/.vimrc $HOME/.vimrc

# 配置neovim config
sudo pip3 install neovim
mkdir -p $HOME/.config/nvim/
ln -s $HOME/.vimrc $HOME/.config/nvim/init.vim
cp ./vim/coc-settings.json $HOME/.config/nvim/coc-settings.json

# 安装node语言环境
wget https://npmmirror.com/mirrors/node/v20.17.0/node-v20.17.0-linux-x64.tar.xz
tar -xf node-v20.17.0-linux-x64.tar.xz
mkdir -p $HOME/infra/
mv node-v20.17.0-linux-x64 $HOME/infra/node
cp ./node/.npmrc $HOME/.npmrc
echo 'export PATH=$HOME/infra/node/bin:$PATH' >> $HOME/.bashrc

# 安装go语言环境
wget https://studygolang.com/dl/golang/go1.23.0.linux-amd64.tar.gz
tar -zxf go1.23.0.linux-amd64.tar.gz
mkdir -p $HOME/infra
mv go $HOME/infra/
mkdir -p $HOME/workspace/go/{src,pkg,bin}
echo 'export GOROOT=$HOME/infra/go' >> $HOME/.bashrc
echo 'export GO111MODULE=on' >> $HOME/.bashrc
echo 'export GOPROXY=https://goproxy.io,direct' >> $HOME/.bashrc
echo 'export GOPRIVATE=git.mycompany.com,github.com/my/private' >> $HOME/.bashrc
echo 'export GOPATh=$HOME/workspace/go' >> $HOME/.bashrc
echo 'export PATH=$GOROOT/bin:$GOPATH/bin:$PATH' >> $HOME/.bashrc

# 安装rust语言环境
echo 'export RUSTUP_DIST_SERVER="https://rsproxy.cn"' >> $HOME/.bashrc
echo 'export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"' >> $HOME/.bashrc
source $HOME/.bashrc
curl --proto '=https' --tlsv1.2 -sSf https://rsproxy.cn/rustup-init.sh | sh
cp ./rust/config.toml $HOME/.cargo/config
cp ./rust/config.toml $HOME/.cargo/config.toml

# 启用bashrc相关配置
source $HOME/.bashrc
