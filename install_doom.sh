#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Update package lists
sudo apt update

# Install Emacs
# Check if Emacs is already installed
if ! command -v emacs &> /dev/null
then
    echo "Emacs not found. Installing Emacs..."
    sudo apt install -y emacs
else
    echo "Emacs is already installed."
fi

# Install dependencies for Doom Emacs
# Git is required to clone Doom Emacs
if ! command -v git &> /dev/null
then
    echo "Git not found. Installing Git..."
    sudo apt install -y git
else
    echo "Git is already installed."
fi

# Ripgrep is recommended for faster search in Doom Emacs
if ! command -v rg &> /dev/null
then
    echo "Ripgrep not found. Installing Ripgrep..."
    sudo apt install -y ripgrep
else
    echo "Ripgrep is already installed."
fi

# Clone Doom Emacs repository if it doesn't exist
if [ ! -d "$HOME/.emacs.d" ]
then
    echo "Cloning Doom Emacs repository..."
    git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
else
    echo "Doom Emacs directory ~/.emacs.d already exists."
    echo "If you want to reinstall, please remove it first."
fi

# Install Doom Emacs
if [ -f "$HOME/.emacs.d/bin/doom" ]
then
    echo "Running Doom Emacs installation..."
    ~/.emacs.d/bin/doom install

    echo "Installation complete!"
    echo "Please add doom to your PATH:"
    echo '  export PATH="$HOME/.emacs.d/bin:$PATH"'
    echo "Then run 'doom sync' to finalize the installation."
else
    echo "Doom Emacs installation script not found. Please check the clone was successful."
fi
