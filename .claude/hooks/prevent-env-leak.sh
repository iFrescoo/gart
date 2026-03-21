#!/usr/bin/env bash
# Hook: prevent-env-leak (PreToolUse: Bash)
# Blocks commands that could leak environment variables or .env file contents

set -euo pipefail

INPUT=$(cat)
TOOL=$(echo "$INPUT" | jq -r '.tool_name // empty')

if [ "$TOOL" != "Bash" ]; then
  exit 0
fi

COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

if [ -z "$COMMAND" ]; then
  exit 0
fi

# Patterns that could leak secrets
LEAK_PATTERNS=(
  'cat[[:space:]].*\.env'
  'cat[[:space:]].*\.secret'
  'cat[[:space:]].*credentials'
  'less[[:space:]].*\.env'
  'more[[:space:]].*\.env'
  'head[[:space:]].*\.env'
  'tail[[:space:]].*\.env'
  'echo[[:space:]].*\$[A-Z_]*KEY'
  'echo[[:space:]].*\$[A-Z_]*SECRET'
  'echo[[:space:]].*\$[A-Z_]*TOKEN'
  'echo[[:space:]].*\$[A-Z_]*PASSWORD'
  'printenv'
  'env[[:space:]]*|'
  'env[[:space:]]*$'
  'set[[:space:]]*|[[:space:]]*grep'
  'export[[:space:]]*-p'
)

for pattern in "${LEAK_PATTERNS[@]}"; do
  if echo "$COMMAND" | grep -qiE "$pattern"; then
    echo "BLOCKED: This command could leak sensitive environment variables or secrets."
    echo "Use .env.example to reference variable names without exposing values."
    exit 2
  fi
done

exit 0
