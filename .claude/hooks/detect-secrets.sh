#!/usr/bin/env bash
# Hook: detect-secrets (PreToolUse: Write)
# Scans file content for hardcoded secrets before writing

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

# Secret patterns to detect
SECRET_PATTERNS=(
  'API_KEY[[:space:]]*=[[:space:]]*["\x27][A-Za-z0-9_-]{20,}'
  'API_SECRET[[:space:]]*=[[:space:]]*["\x27][A-Za-z0-9_-]{20,}'
  'SECRET_KEY[[:space:]]*=[[:space:]]*["\x27][A-Za-z0-9_-]{20,}'
  'ACCESS_TOKEN[[:space:]]*=[[:space:]]*["\x27][A-Za-z0-9_-]{20,}'
  'PRIVATE_KEY[[:space:]]*=[[:space:]]*["\x27][A-Za-z0-9_-]{20,}'
  'password[[:space:]]*=[[:space:]]*["\x27][^"\x27]{8,}'
  'AKIA[0-9A-Z]{16}'
  'ghp_[A-Za-z0-9]{36}'
  'gho_[A-Za-z0-9]{36}'
  'sk-[A-Za-z0-9]{32,}'
  'sk_live_[A-Za-z0-9]{24,}'
  'pk_live_[A-Za-z0-9]{24,}'
)

for pattern in "${SECRET_PATTERNS[@]}"; do
  if echo "$CONTENT" | grep -qE "$pattern"; then
    echo "BLOCKED: Potential hardcoded secret detected in file content."
    echo "Use environment variables instead of hardcoding credentials."
    echo "Store secrets in .env and reference them via process.env.VAR_NAME."
    exit 2
  fi
done

exit 0
