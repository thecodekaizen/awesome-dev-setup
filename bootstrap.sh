#!/bin/sh
set -eu

DOTFILES_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
OS="$(uname -s)"
ARCH="$(uname -m)"

echo "========================================"
echo " awesome-dev-setup"
echo "========================================"
echo
echo "OS:           $OS"
echo "Architecture: $ARCH"
echo

case "$OS" in
    Darwin)
        echo "Platform: macOS"
        echo
        exec "$DOTFILES_DIR/bootstrap/macos.sh"
        ;;

    Linux)
        echo "Platform: Linux"
        echo
        exec "$DOTFILES_DIR/bootstrap/linux.sh"
        ;;

    MINGW*|MSYS*|CYGWIN*)
        echo "Platform: Windows"
        echo
        echo "Use PowerShell instead:"
        echo
        echo "  powershell -ExecutionPolicy Bypass -File bootstrap/windows.ps1"
        echo
        exit 0
        ;;

    *)
        echo "Error: unsupported operating system: $OS"
        exit 1
        ;;
esac
