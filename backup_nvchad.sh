#!/bin/bash

NVCHAD_DIR="$HOME/.config/nvim"
GITHUB_URL="https://github.com/schroe0690/nvchad_settings.git"

cd "$NVCHAD_DIR"

# .gitディレクトリがなければ初期化
if [ ! -d ".git" ]; then
  git init
  git remote add origin "$GITHUB_URL"
  git branch -M main
else
  # 既存のリモートURLを上書き
  git remote set-url origin "$GITHUB_URL"
fi

# 変更をステージング
git add .

# 変更があればコミット
if ! git diff --cached --quiet; then
  git commit -m "Update nvchad config $(date '+%Y-%m-%d %H:%M:%S')"
  git push -u origin main
  echo "nvchadの設定をGitHubにバックアップしました。"
else
  echo "変更はありません。"
fi
