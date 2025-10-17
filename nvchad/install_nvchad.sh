#!/bin/bash
set -e
SCRIPT_DIR=$(pwd)

# 環境変数の設定 (このスクリプト内でのみ有効)
# 永続的な設定は .bashrc や .zshrc などに記述してください
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# Neovimのビルドに必要な依存関係をインストール (Ubuntu/Debian系の場合)
# 必要に応じてお使いのディストリビューションに合わせて変更してください
apt-get update
apt-get install -y ninja-build gettext cmake unzip curl build-essential npm

# 作業ディレクトリを作成 (存在しない場合)
mkdir -p "$HOME/dev"
cd "$HOME/dev"

# Neovimの最新安定版をソースからビルド・インストール
if [ -d "neovim" ]; then
  echo "既存のneovimディレクトリを削除します。"
  rm -rf neovim
fi
git clone https://github.com/neovim/neovim.git
cd neovim
git checkout stable
make CMAKE_BUILD_TYPE=RelWithDebInfo
make install
cd ..
rm -rf neovim # ビルド後、ソースディレクトリは不要なため削除

### 以下, nvchadの設定
# 既存のNeovim設定をバックアップまたは削除 (必要に応じて変更)
NVIM_CONFIG_DIR="$XDG_CONFIG_HOME/nvim"
NVIM_DATA_DIR="$XDG_DATA_HOME/nvim"
NVIM_CACHE_DIR="$XDG_CACHE_HOME/nvim"

if [ -d "$NVIM_CONFIG_DIR" ]; then
  echo "既存のNeovim設定ディレクトリ ($NVIM_CONFIG_DIR) をバックアップします: ${NVIM_CONFIG_DIR}.bak"
  mv "$NVIM_CONFIG_DIR" "${NVIM_CONFIG_DIR}.bak.$(date +%Y%m%d%H%M%S)"
fi
if [ -d "$NVIM_DATA_DIR" ]; then
  echo "既存のNeovimデータディレクトリ ($NVIM_DATA_DIR) をバックアップします: ${NVIM_DATA_DIR}.bak"
  mv "$NVIM_DATA_DIR" "${NVIM_DATA_DIR}.bak.$(date +%Y%m%d%H%M%S)"
fi
if [ -d "$NVIM_CACHE_DIR" ]; then
  echo "既存のNeovimキャッシュディレクトリ ($NVIM_CACHE_DIR) を削除します。"
  rm -rf "$NVIM_CACHE_DIR"
fi


# NvChadのインストール
echo "NvChadをインストールします: $NVIM_CONFIG_DIR"
git clone https://github.com/NvChad/starter "$NVIM_CONFIG_DIR" --depth 1

# nvchadの設定をクローン
cd "$SCRIPT_DIR"
if [ -f ./apply_nvchad.sh ]; then
  ./apply_nvchad.sh
fi

# プラグインの同期
echo "Neovimを起動してプラグインを同期します..."
nvim --headless +"Lazy sync" +qa

echo "nvim と NvChad のインストールが完了しました。"
echo "ターミナルを再起動するか、source ~/.bashrc (またはお使いのシェルの設定ファイル) を実行して環境変数を読み込んでください。"
echo "その後、nvim を起動してください。"
