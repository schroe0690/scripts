#!/bin/bash

# EmacsとSpacemacsのインストールスクリプト（Ubuntu系Linux向け）

set -e

# 1. Emacs本体をインストール
echo "Emacsをインストールします..."
apt update
apt -y install emacs emacs-gtk

# 2. 既存の設定をバックアップ
echo "既存のEmacs設定をバックアップします..."
[ -d "$HOME/.emacs.d" ] && mv "$HOME/.emacs.d" "$HOME/.emacs.d.bak.$(date +%Y%m%d%H%M%S)"
[ -f "$HOME/.emacs" ] && mv "$HOME/.emacs" "$HOME/.emacs.bak.$(date +%Y%m%d%H%M%S)"

# 3. Spacemacsをクローン
echo "Spacemacsをクローンします..."
git clone https://github.com/syl20bnr/spacemacs "$HOME/.emacs.d"

echo "インストール完了！Emacsを起動して初期設定を進めてください。"
