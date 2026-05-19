#!/bin/bash

set -e

package_install=""
if [[ "$(uname -s)" == "Darwin" ]]; then
    echo "==> Mac detected"
    if ! command -v brew &>/dev/null; then
        echo "==> Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    package_install="brew install"
elif command -v pacman &>/dev/null; then
    echo "==> Arch detected"
    package_install="sudo pacman -S --needed"
elif command -v apt &>/dev/null; then
    echo "==> Ubuntu/Debian detected"
    sudo apt update
    package_install="sudo apt install -y"
else
    echo "Unsupported platform"
    exit 1
fi

packages=(
    stow
    git
    curl
    zsh
    fzf
    zoxide
    direnv
    colordiff
    tmux
    neovim
    helix
)

echo "==> Installing packages..."
$package_install "${packages[@]}"
