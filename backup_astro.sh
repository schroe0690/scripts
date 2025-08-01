#!/bin/bash

# 設定
ASTRO_DIR="$HOME/.config/nvim"
GITHUB_REPO="schroe0690/astro_settings.git"
GITHUB_URL="https://${GITHUB_USER}:${GITHUB_TOKEN}@github.com/${GITHUB_REPO}"

# ディレクトリ移動
cd "$ASTRO_DIR"

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
git commit -m "Update astro config $(date '+%Y-%m-%d %H:%M:%S')"
git push -u origin main
echo "AstroNvimの設定をGitHubにバックアップしました。"