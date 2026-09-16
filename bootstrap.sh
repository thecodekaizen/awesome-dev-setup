#!/bin/zsh

set -e

DOTFILES_DIR="${0:A:h}"

if [[ "$(uname -s)" != "Darwin" ]]; then
    echo "Error: awesome-dev-setup supports macOS only."
    exit 1
fi

if ! command -v brew >/dev/null 2>&1; then
    echo "Error: Homebrew is required."
    echo "Install it from https://brew.sh"
    exit 1
fi

eval "$(brew shellenv)"

echo "==> Installing Homebrew packages..."
brew bundle --file="$DOTFILES_DIR/Brewfile"

echo "==> Creating config directories..."
mkdir -p "$HOME/.config/ghostty" "$HOME/.config" "$HOME/.local/bin"

echo "==> Installing dotfiles..."
ln -sf "$DOTFILES_DIR/ghostty/config" "$HOME/.config/ghostty/config"
ln -sf "$DOTFILES_DIR/starship.toml" "$HOME/.config/starship.toml"
ln -sf "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"
ln -sf "$DOTFILES_DIR/git/gitignore_global" "$HOME/.gitignore_global"

echo "==> Configuring Git..."
git config --global core.excludesfile "$HOME/.gitignore_global"

echo "==> Installing local scripts..."
cp "$DOTFILES_DIR/scripts/init-agent-rules" "$HOME/.local/bin/init-agent-rules"
chmod +x "$HOME/.local/bin/init-agent-rules"

echo "==> Installing Zsh configuration..."
if [[ -L "$HOME/.zshrc" && "$(readlink "$HOME/.zshrc")" == "$DOTFILES_DIR/zsh/.zshrc" ]]; then
    echo "    ~/.zshrc already managed by awesome-dev-setup"
elif [[ -e "$HOME/.zshrc" ]]; then
    BACKUP="$HOME/.zshrc.backup.$(date +%Y%m%d%H%M%S)"
    cp "$HOME/.zshrc" "$BACKUP"
    echo "    Existing ~/.zshrc preserved. Backup: $BACKUP"
else
    ln -s "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
fi

echo "==> Done."
echo "Machine-specific configuration belongs in ~/.zshrc.local."
echo "Use .zshrc.local.example as a starting point."
