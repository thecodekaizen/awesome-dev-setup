#!/bin/sh
set -eu

DOTFILES_DIR="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
TOOLS_FILE="$DOTFILES_DIR/tools.yaml"

if [ ! -f "$TOOLS_FILE" ]; then
    echo "Error: tools.yaml not found."
    exit 1
fi

if ! command -v yq >/dev/null 2>&1; then
    echo "Error: yq is required to verify tools.yaml."
    exit 1
fi

echo "==> Checking awesome-dev-setup tools"
echo ""

MISSING=0

for tool in $(yq -r '
    .core + .development + .data + .applications + .optional
    | keys
    | .[]
' "$TOOLS_FILE" | sort -u); do

    case "$tool" in
        libpq)
            command -v psql >/dev/null 2>&1 && STATUS="✓" || STATUS="✗"
            ;;
        redis)
            command -v redis-cli >/dev/null 2>&1 && STATUS="✓" || STATUS="✗"
            ;;
        ghostty|zed|codex|claude-code)
            command -v "$tool" >/dev/null 2>&1 && STATUS="✓" || STATUS="?"
            ;;
        *)
            command -v "$tool" >/dev/null 2>&1 && STATUS="✓" || STATUS="✗"
            ;;
    esac

    printf "%-16s %s\n" "$tool" "$STATUS"

    if [ "$STATUS" = "✗" ]; then
        MISSING=$((MISSING + 1))
    fi
done

echo ""

if [ "$MISSING" -gt 0 ]; then
    echo "$MISSING required tool(s) are missing."
    exit 1
fi

echo "All required CLI tools are available."
