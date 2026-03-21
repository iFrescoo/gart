#!/usr/bin/env bash
# Hook: typecheck (PostToolUse: Edit|Write)
# Runs TypeScript type checking after editing .ts/.tsx files

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

# Only check TypeScript files
EXTENSION="${FILE_PATH##*.}"
case "$EXTENSION" in
  ts|tsx)
    # Check if tsc is available
    if command -v npx &> /dev/null && [ -f "tsconfig.json" ]; then
      RESULT=$(npx tsc --noEmit 2>&1) || true
      if [ -n "$RESULT" ]; then
        echo "TypeScript errors found:"
        echo "$RESULT" | head -20
      fi
    fi
    ;;
esac

exit 0
