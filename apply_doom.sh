#!/bin/bash

GITHUB_URL="https://github.com/schroe0690/doom_settings.git"
DOOM_DIR="$HOME/.config/doom"
TMP_DIR="$HOME/doom_tmp_clone"

# 既存の設定をバックアップ（任意）
if [ -d "$DOOM_DIR" ]; then
  mv "$DOOM_DIR" "${DOOM_DIR}_backup_$(date '+%Y%m%d_%H%M%S')"
fi

# 一時ディレクトリがあれば削除
rm -rf "$TMP_DIR"

# GitHubからクローン
git clone "$GITHUB_URL" "$TMP_DIR"

# クローンした内容を適用
mv "$TMP_DIR" "$DOOM_DIR"


echo "GitHubからdoom設定を適用しました。"
echo "doomを再起動してください。"