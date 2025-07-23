#!/bin/bash

# 設定
DOOM_DIR="$HOME/.config/nvim"
GITHUB_REPO="schroe0690/nvchad_settings.git"
GITHUB_URL="https://${GITHUB_USER}:${GITHUB_TOKEN}@github.com/${GITHUB_REPO}"

# ディレクトリ移動
cd "$DOOM_DIR"

# リモートリポジトリを設定
if [ ! -d ".git" ]; then
  git init
  git remote add origin "$GITHUB_URL"
  git branch -M main
else
  git remote set-url origin "$GITHUB_URL"
fi

# ステージ・コミット・プッシュ
git add .
git commit -m "Update doom config $(date '+%Y-%m-%d %H:%M:%S')"
git push -u origin main
echo "nvchadの設定をGitHubにバックアップしました。"