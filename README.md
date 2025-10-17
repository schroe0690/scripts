## スクリプトのバックアップ方法

スクリプト自体をバックアップするには以下の手順を実行する

1. グローバル情報の設定

mac でコンテナ内から使用する場合、ホスト側の git 情報がそのまま引き継がれることがある
指定したユーザーで更新する場合はあらかじめユーザー名・メールアドレスを設定する必要がある

```bash
git config --global user.name "your_github_username"
git config --global user.email "your_github_email"
```

2. ユーザー名・トークンを環境変数に登録

一時的であるならばそのままターミナルで
何度も使用する予定がある場合は `~/.bashrc` に記載しておく
　　
```bash
export GITHUB_USER="your_github_username"
export GITHUB_TOKEN="your_personal_access_token"
```

3. バックアップ用スクリプトの実行
```bash
bash backup_scripts.sh
```
