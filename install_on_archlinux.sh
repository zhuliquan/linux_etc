#!/usr/bin/env bash

# 添加清华大学源
sudo echo 'Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist

# 更新源
sudo pacman -Syyu

# 安装git, curl, wget, openssl vim neovim ack 等基础软件
pacman -Sy curl git wget openssl \
    lrzsz ack vim neovim cmake \
    make automake tldr jq \
    net-tools unzip gcc lua \
    ca-certificates gnupg lsb-release \
    python3 pkg-config zlib \
    docker docker-compose

# 启动docker
sudo systemctl enable docker
sudo systemctl start docker

# 配置python虚拟环境
mkdir -p $HOME/infra/venv
python3 -m venv $HOME/infra/venv
source $HONE/infra/venv/bin/activate
mkdir -p $HOME/.config/pip
cp ./python/pip.conf $HOME/.cnofig/pip

# 安装fzf
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
$HOME/.fzf/install

# 安装vim-plug 插件
mkdir -p $HOME/.vim/{autoload,colors,doc,plugged,syntax}
cp ./vim/plug.vim $HOME/.vim/autoload/plug.vim
mkdir -p ~/.local/share/nvim/site/autoload/
cp ./vim/plug.vim $HOME/.local/share/nvim/site/autoload/plug.vim

# 配置vimrc
cp ./vim/.vimrc $HOME/.vimrc

# 配置neovim config
pip3 install neovim
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

# 配置rust-analyzer lsp
mkdir -p $HOME/infra/rust-analyzer
# cat ./rust/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > $HOME/infra/rust-analyzer/rust-analyzer
 curl -L https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > $HOME/infra/rust-analyzer/rust-analyzer
chmod +x $HOME/infra/rust-analyzer/rust-analyzer

# 安装protoc
wget https://github.com/protocolbuffers/protobuf/releases/download/v21.8/protoc-21.8-linux-x86_64.zip
unzip protoc*.zip -d ./protoc
sudo mv ./protoc/bin/protoc /usr/local/bin
sudo mv ./protoc/include/* /usr/local/include

# 设置别名
echo 'alias nvi=nvim' >> $HOME/.bashrc
echo 'alias ls="ls -l"' >> $HOME/.bashrc

# 设置默认编辑器为vim
echo 'export EDITOR=vim' >> $HOME/.bashrc

# 配置路径
echo 'export PATH=$HOME/infra/node/bin:$GOROOT/bin:$GOPATH/bin:$PATH' >> $HOME/.bashrc

# 启用bashrc相关配置
source $HOME/.bashrc

# 创建存放插件的目录
mkdir -p $HOME/.local/share/nvim/plugged

# PlugInstall插件
nvim -c ':PlugInstall' -c ':q' -c ':q' -c ':q'

# 安装vim-go依赖的文件
nvim -c ':GoInstallBinaries' -c ':q'

# 安装coc.nvim插件
nvim -c ':CocInstall coc-calc coc-cmake coc-css coc-docker' \
     -c ':CocInstall coc-eslint coc-explorer coc-git coc-go' \
     -c ':CocInstall coc-graphql coc-html coc-java coc-jedi' \
     -c ':CocInstall coc-json coc-markdownlint coc-metals coc-powershell' \
     -c ':CocInstall coc-rust-analyzer coc-sh coc-spell-checker coc-sql coc-swagger' \
     -c ':CocInstall coc-toml coc-tsserver coc-xml coc-yaml coc-lua'

