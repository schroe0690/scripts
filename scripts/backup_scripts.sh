#!/bin/bash

# 定数
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
GITHUB_REPO="schroe0690/scripts.git"

# 認証方法を選択（SSH優先、HTTPSはフォールバック）
if [ -n "$GITHUB_USER" ] && [ -n "$GITHUB_TOKEN" ]; then
  GITHUB_URL="https://${GITHUB_USER}:${GITHUB_TOKEN}@github.com/${GITHUB_REPO}"
else
  GITHUB_URL="git@github.com:${GITHUB_REPO}"
fi

# ディレクトリ移動
cd "$SCRIPT_DIR"

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
echo "スクリプトをバックアップしました。"
