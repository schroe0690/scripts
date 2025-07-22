#!/bin/bash

# 設定
set -e
WORKDIR="$HOME/emacs-build"
SCRIPT_DIR=$(pwd)

# 1. 必要なパッケージをインストール
apt update
apt install -y git build-essential gcc make cmake ncurses-dev libjansson-dev libgccjit-10-dev \
    libgtk-3-dev libgnutls28-dev libxml2-dev libxpm-dev libjpeg-dev libpng-dev libgif-dev \
    libtiff-dev libxaw7-dev texinfo libvterm-dev autoconf

# 2. 作業ディレクトリ作成
mkdir -p "$WORKDIR"
cd "$WORKDIR"

# 3. 既存のemacsディレクトリがあれば削除
if [ -d emacs ]; then
    rm -rf emacs
fi

# 4. gitからemacsリポジトリクローン
git clone --depth 1 https://github.com/emacs-mirror/emacs.git
cd emacs

# 5. ビルド準備
./autogen.sh
./configure

# 6. ビルドとインストール
make -j"$(nproc)"
make install

# 7. バージョン確認
echo "Emacs Versions: "
emacs --version

# 8. 既存の~/.emacs.dをバックアップ
if [ -d "$HOME/.emacs.d" ]; then
    mv "$HOME/.emacs.d" "$HOME/.emacs.d.bak_$(date +%Y%m%d_%H%M%S)"
fi

# 9. doom-emacsをクローン
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs


# 10. doom-emacsのパスを通す
# bash以外のシェルにも対応できるようにしたい
echo 'export PATH=$PATH:$HOME/.config/emacs/bin/' >> ~/.bashrc

# 11. doom-emacsの設定をクローン
cd "$SCRIPT_DIR"
./apply_doom.sh

# 12. doom-emacsのインストール
source ~/.bashrc
doom sync

echo "Emacsのビルドとdoom-emacsの導入が完了しました。"
echo "doom-emacsを起動するには以下のコマンドを実行してください"
# echo "doom-emacsの設定のため、以下のコマンドを入力してください"
echo "source ~/.bashrc"
# echo "doom sync"