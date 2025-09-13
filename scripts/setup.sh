#!/usr/bin/env bash
set -euo pipefail

echo "[*] Setting up Git filters for docx ↔ md conversion..."

# Make sure scripts are executable
chmod +x ./scripts/docx-clean.sh ./scripts/docx-smudge.sh

# Configure Git filters locally (does not affect global config)
git config filter.docx.clean  './scripts/docx-clean.sh'
git config filter.docx.smudge './scripts/docx-smudge.sh'
git config filter.docx.required true

# Refresh working tree so smudge runs
git checkout -- .

echo "[✓] Setup complete. Your .docx files will round-trip via markdown in the repo."
