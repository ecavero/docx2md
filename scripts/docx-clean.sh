#!/usr/bin/env bash
set -euo pipefail

INPUT="$1"
OUTPUT="$2"
TMPDIR=$(mktemp -d)

# Extract DOCX into tmpdir
unzip -q "$INPUT" -d "$TMPDIR"

# Convert DOCX → Markdown (with images)
pandoc "$INPUT" -o "$OUTPUT" --extract-media=media

# Stage extracted images (so they are committed too)
if [ -d "media" ]; then
  git add media/*
fi
