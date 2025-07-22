#!/bin/bash

# 設定
SCR_DIR=$(pwd)
GITHUB_REPO="schroe0690/scripts.git"
GITHUB_URL="https://${GITHUB_USER}:${GITHUB_TOKEN}@github.com/${GITHUB_REPO}"

# ディレクトリ移動
cd "$SCR_DIR"

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
git commit -m "Update scripts $(date '+%Y-%m-%d %H:%M:%S')"
git push -u origin main
echo "スクリプトにバックアップしました。"