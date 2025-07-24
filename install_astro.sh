#!/bin/bash
set -e
SCRIPT_DIR=$(pwd)

# 環境変数の設定
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# 依存関係のインストール
apt-get update
apt-get install -y ninja-build gettext cmake unzip curl build-essential npm

# Neovimのビルド・インストール
mkdir -p "$HOME/dev"
cd "$HOME/dev"
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
rm -rf neovim

# Neovim設定のバックアップ
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

# Astronvimのインストール
echo "Astronvimをインストールします: $NVIM_CONFIG_DIR"
git clone https://github.com/AstroNvim/AstroNvim "$NVIM_CONFIG_DIR" --depth 1

# 独自設定を適用したい場合
cd "$SCRIPT_DIR"
if [ -f ./apply_astronvim.sh ]; then
  ./apply_astronvim.sh
fi

# プラグインの同期
echo "Neovimを起動してプラグインを同期します..."
nvim --headless "+AstroUpdate" +qa

echo "nvim と Astronvim のインストールが完了しました。"
echo "ターミナルを再起動するか、source ~/.bashrc (またはお使いのシェルの設定ファイル) を実行して環境変数を読み込んでください。"
echo "その後、nvim を起動してください。"