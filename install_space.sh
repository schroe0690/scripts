#!/bin/bash

# Emacs & Spacemacs 自動インストールスクリプト（完全自動・質問なし）

set -e

echo "=== Emacs & Spacemacs 自動インストール開始 ==="

# 1. Emacs本体を自動インストール
apt update -y
apt install -y emacs emacs-gtk git

# 2. 既存の設定を自動バックアップ
timestamp=$(date +%Y%m%d%H%M%S)
[ -d "$HOME/.emacs.d" ] && mv -f "$HOME/.emacs.d" "$HOME/.emacs.d.bak.$timestamp"
[ -f "$HOME/.emacs" ] && mv -f "$HOME/.emacs" "$HOME/.emacs.bak.$timestamp"

# 3. Spacemacsをクローン（developブランチを使いたい場合はコメントアウトを外す）
git clone https://github.com/syl20bnr/spacemacs "$HOME/.emacs.d"
# git -C "$HOME/.emacs.d" checkout develop

# 4. .spacemacsファイルの自動生成（Emacs初回起動時の質問をスキップしたい場合）
#   - 既定の.spacemacsテンプレートをコピー
cp "$HOME/.emacs.d/core/templates/.spacemacs.template" "$HOME/.spacemacs"

echo "=== インストール完了！Emacsを起動してください。 ==="
