#!/usr/bin/env bash
set -euo pipefail

# Git gives us the placeholder JSON/Markdown on stdin
# We don’t actually need it, but we read it anyway
cat > /dev/null

# Find the Markdown file that matches the DOCX
# Git doesn’t pass the filename, so we rely on env var if set
base=""
if [ -n "${GIT_FILENAME:-}" ]; then
  base="$(basename "$GIT_FILENAME" .docx)"
else
  echo "Warning: GIT_FILENAME not set, trying heuristic" >&2
  # fallback: pick the first .md in the repo
  base="$(ls *.md 2>/dev/null | head -n1 | sed 's/\.md$//')"
fi

md_file="${base}.md"
media_dir="media"

# Convert Markdown (+ media if exists) → DOCX (to stdout)
if [ -f "$md_file" ]; then
  if [ -d "$media_dir" ]; then
    pandoc -f markdown -t docx "$md_file" -o - --resource-path="$media_dir"
  else
    pandoc -f markdown -t docx "$md_file" -o -
  fi
else
  echo "Error: Expected $md_file not found" >&2
  exit 1
fi
