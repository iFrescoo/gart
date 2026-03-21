#!/usr/bin/env bash
# Hook: bash-logger (PreToolUse: Bash)
# Logs every bash command with timestamp for audit purposes

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

# Create audit directory
AUDIT_DIR="$HOME/.claude/audit"
mkdir -p "$AUDIT_DIR"

# Log the command
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ" 2>/dev/null || date +"%Y-%m-%dT%H:%M:%S")
LOG_FILE="$AUDIT_DIR/bash-commands.log"

echo "[$TIMESTAMP] $COMMAND" >> "$LOG_FILE"

# Always allow — this is a logging hook, not a blocking hook
exit 0
