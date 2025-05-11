#!/bin/bash

# Emacs & Spacemacs 完全自動インストールスクリプト（Postfix等のプロンプトもスキップ）

set -e

echo "=== Emacs & Spacemacs 自動インストール開始 ==="

# 1. 必要なパッケージを自動インストール
# postfixのインストール時にプロンプトが出ないようプリシード
echo "postfix postfix/main_mailer_type select Local only" | debconf-set-selections

DEBIAN_FRONTEND=noninteractive apt update -y
DEBIAN_FRONTEND=noninteractive apt install -y emacs emacs-gtk git postfix

# 2. 既存の設定を自動バックアップ
timestamp=$(date +%Y%m%d%H%M%S)
[ -d "$HOME/.emacs.d" ] && mv -f "$HOME/.emacs.d" "$HOME/.emacs.d.bak.$timestamp"
[ -f "$HOME/.emacs" ] && mv -f "$HOME/.emacs" "$HOME/.emacs.bak.$timestamp"

# 3. Spacemacsをクローン
git clone https://github.com/syl20bnr/spacemacs "$HOME/.emacs.d"

# 4. .spacemacsファイルを自動生成
cp "$HOME/.emacs.d/core/templates/.spacemacs.template" "$HOME/.spacemacs"

echo "=== インストール完了！Emacsを起動してください。 ==="
