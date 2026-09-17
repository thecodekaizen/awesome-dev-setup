#!/bin/sh
set -eu

DOTFILES_DIR="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
CONFIG_DIR="$HOME/.config/awesome-dev-setup"
GIT_CONFIG="$HOME/.gitconfig"
SHARED_CONFIG="$DOTFILES_DIR/git/gitconfig"
INSTALLED_CONFIG="$CONFIG_DIR/gitconfig"
INCLUDE_PATH="~/.config/awesome-dev-setup/gitconfig"

if [ ! -f "$SHARED_CONFIG" ]; then
    echo "Error: shared Git config not found."
    exit 1
fi

mkdir -p "$CONFIG_DIR"
cp "$SHARED_CONFIG" "$INSTALLED_CONFIG"

if [ ! -f "$GIT_CONFIG" ]; then
    touch "$GIT_CONFIG"
fi

# Remove the old repo-location-dependent include if it exists.
git config --global --unset-all include.path "$SHARED_CONFIG" 2>/dev/null || true

# Add the portable home-relative include.
if git config --global --get-all include.path 2>/dev/null | grep -Fxq "$INCLUDE_PATH"; then
    echo "    Shared config already included."
else
    git config --global --add include.path "$INCLUDE_PATH"
    echo "    Added portable shared config."
fi

echo
echo "✓ Git configuration ready."
