#!/bin/bash

NVCHAD_DIR="$HOME/.config/doom"
GITHUB_URL="https://github.com/schroe0690/doom_settings.git"

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

# コミット
git commit -m "Update doom config $(date '+%Y-%m-%d %H:%M:%S')"
git push -u origin main
echo "doomの設定をGitHubにバックアップしました。"
