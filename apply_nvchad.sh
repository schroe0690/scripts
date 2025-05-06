#!/bin/bash

GITHUB_URL="https://github.com/schroe0690/nvchad_settings.git"
NVCHAD_DIR="$HOME/.config/nvim"
TMP_DIR="$HOME/nvchad_tmp_clone"

# 既存の設定をバックアップ（任意）
if [ -d "$NVCHAD_DIR" ]; then
  mv "$NVCHAD_DIR" "${NVCHAD_DIR}_backup_$(date '+%Y%m%d_%H%M%S')"
fi

# 一時ディレクトリがあれば削除
rm -rf "$TMP_DIR"

# GitHubからクローン
git clone "$GITHUB_URL" "$TMP_DIR"

# クローンした内容を適用
mv "$TMP_DIR" "$NVCHAD_DIR"

# キャッシュのクリア
rm -rf "$HOME/.local/share/nvim"
rm -rf "$HOME/.cache/nvim"

echo "GitHubからnvchad設定を適用しました。"
echo "nvimを再起動してください。"