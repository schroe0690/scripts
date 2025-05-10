#!/bin/bash

set -e

echo "==== Doom Emacs & 必要パッケージ自動インストールスクリプト ===="

# 1. 必要なパッケージのインストール準備
apt update -y

# 2. 必要なパッケージのインストール（Postfixは不要）
DEBIAN_FRONTEND=noninteractive apt install -y git emacs ripgrep fd-find curl

# 3. 既存のDoom Emacsディレクトリがあれば自動バックアップ
if [ -d "$HOME/.config/emacs" ]; then
    mv "$HOME/.config/emacs" "$HOME/.config/emacs.bak.$(date +%s)"
fi

# 4. Doom Emacsをクローン
git clone --depth 1 https://github.com/doomemacs/doomemacs "$HOME/.config/emacs"

# 5. Doom Emacsのインストール（全て自動進行）
"$HOME/.config/emacs/bin/doom" install -y

# 6. パスの設定
echo 'export PATH="$PATH:$HOME/.config/emacs/bin"' >> "$HOME/.bashrc"

# 7. シンボリックリンクの作成（ripgrep, fd）
ln -sf $(which rg) /usr/local/bin/rg
ln -sf $(which fdfind) /usr/local/bin/fd

echo "==== Doom Emacs の自動インストールが完了しました！===="
echo "emacs コマンドでDoom Emacsを起動できます。"
