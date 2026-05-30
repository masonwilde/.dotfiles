#!/bin/bash

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "==> Installing packages..."
"$DOTFILES_DIR/get_packages.sh"

echo "==> Installing external tools..."
"$DOTFILES_DIR/install_externals.sh"

echo "==> Stowing dotfiles..."
"$DOTFILES_DIR/setup.sh"

echo "==> Configuring git hooks..."
git config core.hooksPath "$DOTFILES_DIR/hooks"

echo "==> Done! Restart your shell to pick up changes."
