## スクリプトのバックアップ方法

スクリプト自体をバックアップするには以下の手順を実行する

1. ユーザー名・トークンを環境変数に登録する

一時的であるならばそのままターミナルで
何度も使用する予定がある場合は `~/.bashrc` に記載しておく
　　
```bash
export GITHUB_USER="your_github_username"
export GITHUB_TOKEN="your_personal_access_token"
```

2. バックアップ用スクリプトを実行する
```bash
bash backup_scripts.sh
```
