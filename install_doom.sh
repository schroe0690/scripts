#!/bin/bash

set -e

echo "==== Doom Emacs & 必要パッケージ自動インストールスクリプト ===="

# 1. 必要なパッケージのインストール準備
apt update -y

# 2. Postfixの事前設定（必要な場合のみ。不要ならこのブロックを削除してください）
echo "postfix postfix/main_mailer_type select Internet Site" | debconf-set-selections
echo "postfix postfix/mailname string example.com" | debconf-set-selections

# 3. 必要なパッケージのインストール（Postfix含む）
DEBIAN_FRONTEND=noninteractive apt install -y git emacs postfix

# 4. 既存のDoom Emacsディレクトリがあれば自動バックアップ
if [ -d "$HOME/.config/emacs" ]; then
    mv "$HOME/.config/emacs" "$HOME/.config/emacs.bak.$(date +%s)"
fi

# 5. Doom Emacsをクローン
git clone --depth 1 https://github.com/doomemacs/doomemacs "$HOME/.config/emacs"

# 6. Doom Emacsのインストール（全て自動進行）
yes | "$HOME/.config/emacs/bin/doom" install

# 7. パスの設定（重複チェックなしで追記）
if [ -n "$ZSH_VERSION" ]; then
    SHELL_RC="$HOME/.zshrc"
elif [ -n "$BASH_VERSION" ]; then
    SHELL_RC="$HOME/.bashrc"
else
    SHELL_RC="$HOME/.profile"
fi

echo 'export PATH="$PATH:$HOME/.config/emacs/bin"' >> "$SHELL_RC"
source "$SHELL_RC"

echo "==== Doom Emacs の自動インストールが完了しました！===="
echo "新しいシェルを開くか 'source $SHELL_RC' を実行してください。"
echo "emacs コマンドでDoom Emacsを起動できます。"
