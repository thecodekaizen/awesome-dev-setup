#!/bin/zsh

set -e

if [[ "$(uname -s)" != "Darwin" ]]; then echo "Error: awesome-dev-setup supports macOS only."; exit 1; fi

if ! command -v brew >/dev/null 2>&1; then echo "Error: Homebrew is required. Install it first: https://brew.sh"; exit 1; fi

eval "$(brew shellenv)"

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
echo "==> Installing local scripts..."
mkdir -p "$HOME/.local/bin"
cp "$DOTFILES_DIR/scripts/init-agent-rules" "$HOME/.local/bin/init-agent-rules"
chmod +x "$HOME/.local/bin/init-agent-rules"

echo "==> Installing Zsh configuration..."
if [[ -e "$HOME/.zshrc" && ! -L "$HOME/.zshrc" ]]; then
    cp "$HOME/.zshrc" "$HOME/.zshrc.backup.$(date +%Y%m%d%H%M%S)"
fi

if [[ -e "$HOME/.zshrc" && ! -L "$HOME/.zshrc" ]]; then
    cp "$HOME/.zshrc" "$HOME/.zshrc.backup.$(date +%Y%m%d%H%M%S)"
fi

if [[ -L "$HOME/.zshrc" && "$(readlink "$HOME/.zshrc")" == "$DOTFILES_DIR/zsh/.zshrc" ]]; then
    :
elif [[ ! -e "$HOME/.zshrc" ]]; then
    ln -s "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
else
    echo "==> Existing ~/.zshrc preserved. Source the repository config manually if desired."
fi

echo "==> Done."
echo ""
echo "Machine-specific configuration is intentionally not installed."
echo "Review ~/.zshrc.local separately."
