#!/bin/bash

GITHUB_URL="https://github.com/schroe0690/astro_settings.git"
ASTRO_DIR="$HOME/.config/nvim"
TMP_DIR="$HOME/astro_tmp_clone"

# 既存の設定をバックアップ（任意）
if [ -d "$ASTRO_DIR" ]; then
  mv "$ASTRO_DIR" "${ASTRO_DIR}_backup_$(date '+%Y%m%d_%H%M%S')"
fi

# 一時ディレクトリがあれば削除
rm -rf "$TMP_DIR"

# GitHubからクローン
git clone "$GITHUB_URL" "$TMP_DIR"

# クローンした内容を適用
mv "$TMP_DIR" "$ASTRO_DIR"

# キャッシュのクリア
rm -rf "$HOME/.local/share/nvim"
rm -rf "$HOME/.cache/nvim"

echo "GitHubからAstroNvimの設定を適用しました。"
echo "nvimを再起動してください。"