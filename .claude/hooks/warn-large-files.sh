#!/usr/bin/env bash
# Hook: warn-large-files (PreToolUse: Write)
# Warns when writing files larger than 500 lines

set -euo pipefail

INPUT=$(cat)
TOOL=$(echo "$INPUT" | jq -r '.tool_name // empty')

if [ "$TOOL" != "Write" ]; then
  exit 0
fi

CONTENT=$(echo "$INPUT" | jq -r '.tool_input.content // empty')

if [ -z "$CONTENT" ]; then
  exit 0
fi

# Count lines
LINE_COUNT=$(echo "$CONTENT" | wc -l)
MAX_LINES=500

if [ "$LINE_COUNT" -gt "$MAX_LINES" ]; then
  FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // "unknown"')
  echo "WARNING: File '$FILE_PATH' has $LINE_COUNT lines (limit: $MAX_LINES)."
  echo "Consider splitting this file into smaller modules."
  echo ""
  echo "Allowing write, but please review if this file should be broken up."
fi

# Always allow — this is a warning, not a block
exit 0
