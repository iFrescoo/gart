#!/usr/bin/env bash
# Hook: auto-format (PostToolUse: Edit|Write)
# Runs Prettier on modified files after editing

set -euo pipefail

INPUT=$(cat)
TOOL=$(echo "$INPUT" | jq -r '.tool_name // empty')

if [ "$TOOL" != "Edit" ] && [ "$TOOL" != "Write" ]; then
  exit 0
fi

FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

if [ -z "$FILE_PATH" ]; then
  exit 0
fi

# Only format supported file types
EXTENSION="${FILE_PATH##*.}"
case "$EXTENSION" in
  ts|tsx|js|jsx|json|css|scss|html|md|yaml|yml)
    # Check if prettier is available
    if command -v npx &> /dev/null && [ -f "node_modules/.bin/prettier" ] || npx prettier --version &> /dev/null 2>&1; then
      npx prettier --write "$FILE_PATH" 2>/dev/null || true
    fi
    ;;
esac

exit 0
