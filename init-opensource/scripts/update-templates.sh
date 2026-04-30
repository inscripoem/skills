#!/bin/bash
# Update all bundled templates from their authoritative sources
# Run this script to refresh templates when new versions are released

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_DIR="$SCRIPT_DIR/../templates"
LICENSE_BASE="https://raw.githubusercontent.com/github/choosealicense.com/gh-pages/_licenses"

echo "Updating open-source repository templates..."
echo ""

# Update LICENSE templates
echo "=== Updating LICENSE templates ==="
mkdir -p "$TEMPLATE_DIR/license"
cd "$TEMPLATE_DIR/license"

for key in mit apache-2.0 gpl-3.0 lgpl-3.0 mpl-2.0 bsd-3-clause isc cc0-1.0 unlicense; do
    echo -n "  Downloading $key... "
    if curl -sL "$LICENSE_BASE/$key.txt" > "$key.md" 2>/dev/null && [ -s "$key.md" ] && [ "$(wc -c < "$key.md")" -gt 100 ]; then
        # Clean YAML frontmatter if present
        if head -1 "$key.md" | grep -q '^---$'; then
            awk '/^---$/{count++; next} count>=2' "$key.md" > "$key.md.tmp"
            mv "$key.md.tmp" "$key.md"
        fi
        echo "OK ($(wc -c < "$key.md") bytes)"
    else
        echo "FAILED - keeping existing file"
    fi
done

# Update CODE_OF_CONDUCT
echo ""
echo "=== Updating CODE_OF_CONDUCT templates ==="
mkdir -p "$TEMPLATE_DIR/coc"
cd "$TEMPLATE_DIR/coc"

echo -n "  Downloading English version... "
if curl -sL "https://www.contributor-covenant.org/version/2/1/code_of_conduct/code_of_conduct.md" > en.md 2>/dev/null && [ -s en.md ]; then
    echo "OK ($(wc -c < en.md) bytes)"
else
    echo "FAILED - keeping existing file"
fi

echo -n "  Downloading Chinese version... "
if curl -sL "https://www.contributor-covenant.org/zh-cn/version/2/1/code_of_conduct/code_of_conduct.md" > zh.md 2>/dev/null && [ -s zh.md ]; then
    echo "OK ($(wc -c < zh.md) bytes)"
else
    echo "FAILED - keeping existing file"
fi

# CONTRIBUTING and Issue/PR templates are hand-crafted, skip auto-update
echo ""
echo "=== Skipping CONTRIBUTING and Issue/PR templates (hand-crafted) ==="

# Update README templates
echo ""
echo "=== README templates are hand-crafted, skipping auto-update ==="

echo ""
echo "Update complete!"
