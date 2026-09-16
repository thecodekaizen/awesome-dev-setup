#!/bin/zsh

set -e

DOTFILES_DIR="${0:A:h}"

echo "==> Installing Homebrew packages..."
brew bundle --file="$DOTFILES_DIR/Brewfile"

echo "==> Creating config directories..."
mkdir -p "$HOME/.config/ghostty"
mkdir -p "$HOME/.config"

echo "==> Installing dotfiles..."

ln -sf "$DOTFILES_DIR/ghostty/config" "$HOME/.config/ghostty/config"
ln -sf "$DOTFILES_DIR/starship.toml" "$HOME/.config/starship.toml"
ln -sf "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"
ln -sf "$DOTFILES_DIR/git/gitignore_global" "$HOME/.gitignore_global"

echo "==> Configuring Git..."
git config --global core.excludesfile "$HOME/.gitignore_global"

echo "==> Done."
echo ""
echo "Machine-specific configuration is intentionally not installed."
echo "Review ~/.zshrc.local separately."
