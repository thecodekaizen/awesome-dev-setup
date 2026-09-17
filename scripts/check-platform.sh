#!/bin/sh
set -eu

DOTFILES_DIR="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"

case "$(uname -s)" in
    Darwin) PLATFORM="macos" ;;
    Linux) PLATFORM="linux" ;;
    MINGW*|MSYS*|CYGWIN*) PLATFORM="windows" ;;
    *)
        echo "Unsupported platform: $(uname -s)"
        exit 1
        ;;
esac

echo "========================================"
echo " awesome-dev-setup platform check"
echo "========================================"
echo
echo "OS:           $PLATFORM"
echo "Architecture: $(uname -m)"
echo

echo "Required commands:"
echo

COMMANDS="
git
gh
fzf
rg
fd
bat
jq
tmux
zsh
"

MISSING=0

for command in $COMMANDS; do
    if command -v "$command" >/dev/null 2>&1; then
        printf "  ✓ %s\n" "$command"
    else
        printf "  ✗ %s\n" "$command"
        MISSING=$((MISSING + 1))
    fi
done

echo

if [ "$MISSING" -eq 0 ]; then
    echo "✓ All core commands are available."
else
    echo "✗ $MISSING core command(s) missing."
    echo "Run the platform bootstrap to install them."
    exit 1
fi
