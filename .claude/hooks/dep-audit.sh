#!/usr/bin/env bash
# Hook: dep-audit (PostToolUse: Write)
# Runs npm audit after package.json changes

set -euo pipefail

INPUT=$(cat)
TOOL=$(echo "$INPUT" | jq -r '.tool_name // empty')

if [ "$TOOL" != "Write" ] && [ "$TOOL" != "Edit" ]; then
  exit 0
fi

FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

if [ -z "$FILE_PATH" ]; then
  exit 0
fi

# Only check package.json changes
FILENAME=$(basename "$FILE_PATH")
if [ "$FILENAME" != "package.json" ]; then
  exit 0
fi

# Run npm audit if npm is available
if command -v npm &> /dev/null; then
  AUDIT_RESULT=$(npm audit --audit-level=high 2>&1) || true

  if echo "$AUDIT_RESULT" | grep -qiE "high|critical"; then
    echo "WARNING: npm audit found high/critical vulnerabilities after package.json change:"
    echo "$AUDIT_RESULT" | grep -iE "high|critical" | head -10
    echo ""
    echo "Run 'npm audit' for full details and 'npm audit fix' to resolve."
  fi
fi

# Always allow — this is an informational hook
exit 0
