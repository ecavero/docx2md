#!/usr/bin/env bash
set -e

# Figure out where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Root of the repository (one level up from scripts/)
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Define filters relative to repo root
CLEAN="$SCRIPT_DIR/docx-clean.sh"
SMUDGE="$SCRIPT_DIR/docx-smudge.sh"

# Configure git filters
git config filter.docx.clean  "$CLEAN"
git config filter.docx.smudge "$SMUDGE"
git config filter.docx.required true

echo "Git filters configured:"
echo "  clean  -> $CLEAN"
echo "  smudge -> $SMUDGE"
