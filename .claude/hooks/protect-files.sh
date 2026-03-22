#!/usr/bin/env bash
# Hook: protect-files (PreToolUse: Edit|Write)
# Prevents modification of sensitive files

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

# Extract filename from path
FILENAME=$(basename "$FILE_PATH")
DIRNAME=$(dirname "$FILE_PATH")

# Protected file patterns
PROTECTED_FILES=(
  '.env'
  '.env.local'
  '.env.production'
  '.env.staging'
  '.env.development'
  'credentials.json'
  'serviceAccountKey.json'
  'id_rsa'
  'id_ed25519'
)

# Protected directories
PROTECTED_DIRS=(
  '.git/'
)

# Check protected files
for protected in "${PROTECTED_FILES[@]}"; do
  if [ "$FILENAME" = "$protected" ]; then
    echo "BLOCKED: Cannot modify protected file '$FILENAME'."
    echo "This file may contain secrets. Edit it manually if needed."
    exit 2
  fi
done

# Check protected directories
for dir in "${PROTECTED_DIRS[@]}"; do
  if echo "$FILE_PATH" | grep -q "/$dir\|\\\\$dir"; then
    echo "BLOCKED: Cannot modify files inside protected directory '$dir'."
    exit 2
  fi
done

# Check .env.* pattern (any .env variant) — .env.example is a template, not a secret
if [ "$FILENAME" != ".env.example" ] && echo "$FILENAME" | grep -qE '^\.env\.'; then
  echo "BLOCKED: Cannot modify environment file '$FILENAME'."
  echo "This file may contain secrets. Edit it manually if needed."
  exit 2
fi

exit 0
