#!/usr/bin/env bash
set -euo pipefail

echo "== Git Sanity Lite Check =="
echo "Repo: $(git rev-parse --show-toplevel 2>/dev/null || echo 'N/A')"
echo "Global .gitattributes: $(git config --global core.attributesfile || echo 'not set')"
echo

echo "— EOL summary —"
git check-attr eol -- :/ | sort | uniq -c || true
echo

echo "— Binary files (sample) —"
git check-attr binary -- :/ | grep ': binary: set' | head -n 20 || true
