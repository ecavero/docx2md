#!/usr/bin/env bash
set -euo pipefail

INPUT="$1"
OUTPUT="$2"

# Convert Markdown + images back into DOCX
pandoc "$INPUT" -o "$OUTPUT"
