#!/bin/bash

# 環境変数の設定
export XDG_CONFIG_HOME=/root/.config
export XDG_DATA_HOME=/root/.local/share
export XDG_CACHE_HOME=/root/.cache

# Neovimの最新版をインストール
git clone https://github.com/neovim/neovim.git
cd neovim
git checkout stable
make CMAKE_BUILD_TYPE=RelWithDebInfo
make install
cd ..
rm -rf neovim

### 以下, nvchadの設定
# 既存の設定を削除
rm -rf /root/.config/nvim
rm -rf /root/.local/share/nvim
rm -rf /root/.cache/nvim

# NvChadのインストール
git clone https://github.com/NvChad/starter /root/.config/nvim --depth 1

# プラグインの同期
nvim --headless +"Lazy sync" +qa