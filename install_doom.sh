#!/bin/bash

set -e

echo "==== Doom Emacs 自動インストールスクリプト ===="

# 1. 必要なパッケージのインストール（自動でyes）
apt update -y
apt install -y git emacs

# 2. 既存のDoom Emacsディレクトリがあれば自動バックアップ
if [ -d "$HOME/.config/emacs" ]; then
    mv "$HOME/.config/emacs" "$HOME/.config/emacs.bak.$(date +%s)"
fi

# 3. Doom Emacsをクローン
git clone --depth 1 https://github.com/doomemacs/doomemacs "$HOME/.config/emacs"

# 4. Doom Emacsのインストール（全て自動進行）
yes | "$HOME/.config/emacs/bin/doom" install

# 5. パスの設定（重複チェックなしで追記）
if [ -n "$ZSH_VERSION" ]; then
    SHELL_RC="$HOME/.zshrc"
elif [ -n "$BASH_VERSION" ]; then
    SHELL_RC="$HOME/.bashrc"
else
    SHELL_RC="$HOME/.profile"
fi

echo 'export PATH="$PATH:$HOME/.config/emacs/bin"' >> "$SHELL_RC"

echo "==== Doom Emacs の自動インストールが完了しました！===="
echo "新しいシェルを開くか 'source $SHELL_RC' を実行してください。"
echo "emacs コマンドでDoom Emacsを起動できます。"
