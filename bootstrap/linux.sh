#!/bin/sh
set -eu

DOTFILES_DIR="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"

if [ "$(uname -s)" != "Linux" ]; then
    echo "Error: linux.sh can only run on Linux."
    exit 1
fi

echo "==> Detecting Linux package manager..."

if command -v apt-get >/dev/null 2>&1; then
    PM="apt"
elif command -v dnf >/dev/null 2>&1; then
    PM="dnf"
elif command -v pacman >/dev/null 2>&1; then
    PM="pacman"
else
    echo "Error: unsupported Linux package manager."
    echo "Supported: apt, dnf, pacman"
    exit 1
fi

echo "    Package manager: $PM"

case "$PM" in
    apt)
        sudo apt-get update
        sudo apt-get install -y \
            git \
            curl \
            ca-certificates \
            unzip \
            zsh \
            tmux \
            fzf \
            ripgrep \
            fd-find \
            bat \
            jq \
            yq \
            postgresql-client \
            redis-tools
        ;;

    dnf)
        sudo dnf install -y \
            git \
            curl \
            ca-certificates \
            unzip \
            zsh \
            tmux \
            fzf \
            ripgrep \
            fd-find \
            bat \
            jq \
            yq \
            postgresql \
            redis
        ;;

    pacman)
        sudo pacman -Sy --needed \
            git \
            curl \
            ca-certificates \
            unzip \
            zsh \
            tmux \
            fzf \
            ripgrep \
            fd \
            bat \
            jq \
            yq \
            postgresql-libs \
            redis
        ;;
esac

echo "==> Creating configuration directories..."

mkdir -p \
    "$HOME/.config/awesome-dev-setup" \
    "$HOME/.config" \
    "$HOME/.local/bin"

echo "==> Installing shared configuration..."

ln -sf "$DOTFILES_DIR/starship.toml" "$HOME/.config/starship.toml"
ln -sf "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"
ln -sf "$DOTFILES_DIR/git/gitignore_global" "$HOME/.gitignore_global"

"$DOTFILES_DIR/scripts/install-git-config.sh"

cp "$DOTFILES_DIR/AGENTS.md" \
   "$HOME/.config/awesome-dev-setup/AGENTS.md"

cp "$DOTFILES_DIR/scripts/init-agent-rules" \
   "$HOME/.local/bin/init-agent-rules"

chmod +x "$HOME/.local/bin/init-agent-rules"

echo
echo "==> Installing optional CLI tools where available..."

for tool in eza zoxide lazygit starship gitleaks; do
    if command -v "$tool" >/dev/null 2>&1; then
        printf "    ✓ %s\n" "$tool"
    else
        printf "    ! %s not installed by this distribution bootstrap\n" "$tool"
    fi
done

echo
echo "==> Linux setup complete."
echo
echo "Language runtimes:"
echo "  mise install"
echo
echo "Optional platform-specific tools:"
echo "  kubectl"
echo "  helm"
echo "  Docker"
echo "  Ghostty"
echo "  Zed"
echo "  Codex"
echo "  Claude Code"
