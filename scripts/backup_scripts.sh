#!/bin/bash

# 定数
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
GITHUB_REPO="schroe0690/scripts.git"

# 認証方法を決定
if [ -n "$GITHUB_USER" ] && [ -n "$GITHUB_TOKEN" ]; then
  # 環境変数が設定されている場合はHTTPS with token
  GITHUB_URL="https://${GITHUB_USER}:${GITHUB_TOKEN}@github.com/${GITHUB_REPO}"
  echo "環境変数を使用してHTTPS認証を行います"
else
  # 環境変数が未設定の場合はシンプルなHTTPS（git credential helperに依存）
  GITHUB_URL="https://github.com/${GITHUB_REPO}"
  echo "Git credential helperを使用してHTTPS認証を行います"
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
