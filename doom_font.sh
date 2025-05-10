#!/bin/bash

# Doom Emacsのアイコン問題を修正するスクリプト

# ホームディレクトリの設定（Dockerでは通常rootですが、環境変数で上書き可能）
HOME_DIR=${HOME_DIR:-/root}

# 必要なフォントをインストール
echo "==== Doom Emacsのアイコン表示問題を修正します ===="
echo "必要なフォントパッケージをインストールします..."

# Dockerコンテナ内では管理者権限は不要
apt-get update && apt-get install -y fonts-powerline fonts-symbola fonts-liberation fonts-dejavu fontconfig wget unzip

# All The Iconsフォントをインストール
echo "All The Iconsフォントをインストールします..."
mkdir -p ${HOME_DIR}/.local/share/fonts

# Nerd Fontsをダウンロードしてインストール
echo "Nerd Fontsをダウンロードしてインストールします..."
wget -q --show-progress https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip -O /tmp/JetBrainsMono.zip
unzip -o /tmp/JetBrainsMono.zip -d ${HOME_DIR}/.local/share/fonts/
rm /tmp/JetBrainsMono.zip

# フォントキャッシュを更新
echo "フォントキャッシュを更新します..."
fc-cache -f -v

# Doom Emacsの設定を更新
if [ -f "${HOME_DIR}/.doom.d/config.el" ]; then
    echo "Doom Emacsの設定を更新します..."
    # JetBrainsMono Nerd Fontを設定
    if ! grep -q "doom-font" "${HOME_DIR}/.doom.d/config.el"; then
        echo '(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 14))' >> "${HOME_DIR}/.doom.d/config.el"
    fi
    
    # all-the-iconsパッケージを確認し、必要に応じてインストール
    echo "all-the-iconsパッケージを確認します..."
    if [ -d "${HOME_DIR}/.config/emacs" ]; then
        cd "${HOME_DIR}/.config/emacs"
        ./bin/doom sync
        emacs --batch --eval "(require 'all-the-icons)" || emacs --batch --eval "(package-initialize)" --eval "(package-refresh-contents)" --eval "(package-install 'all-the-icons)" --eval "(all-the-icons-install-fonts t)"
    fi
fi

echo "==== Doom Emacsのアイコン修正が完了しました！ ====" 