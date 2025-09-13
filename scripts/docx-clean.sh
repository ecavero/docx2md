#!/usr/bin/env bash
set -euo pipefail

# Git provides the file contents via stdin
tmp_in=$(mktemp --suffix=.docx)
cat > "$tmp_in"

# Convert DOCX → Markdown, extracting media
# pandoc will write Markdown to stdout (back to Git filter)
pandoc "$tmp_in" -t markdown --extract-media=media

# Stage images if extracted
if [ -d "media" ]; then
  git add media/* || true
fi

# Clean up
rm -f "$tmp_in"
