#!/bin/zsh
set -e

DOTFILES_DIR="${0:A:h:h}"
TOOLS_FILE="$DOTFILES_DIR/tools.yaml"
BREWFILE="$DOTFILES_DIR/Brewfile"

if ! command -v yq >/dev/null 2>&1; then
    echo "Error: yq is required."
    exit 1
fi

if [[ ! -f "$TOOLS_FILE" ]]; then
    echo "Error: tools.yaml not found."
    exit 1
fi

TMP="$(mktemp)"

{
    echo "# Generated from tools.yaml"
    echo ""

    echo "# CLI / development / data"
    yq -r '
      .core, .development, .data
      | to_entries[]
      | select(.value.macos != null)
      | "brew \"" + .value.macos + "\""
    ' "$TOOLS_FILE"

    echo ""
    echo "# Applications"
    yq -r '
      .applications
      | to_entries[]
      | select(.value.macos != null)
      | "cask \"" + .value.macos + "\""
    ' "$TOOLS_FILE"
} > "$TMP"

echo "==> Generated Brewfile"
echo "----------------------"
cat "$TMP"

echo ""
echo "==> Difference from current Brewfile"
echo "-------------------------------------"
diff -u "$BREWFILE" "$TMP" || true

rm -f "$TMP"
