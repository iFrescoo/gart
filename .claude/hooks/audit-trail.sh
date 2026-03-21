#!/usr/bin/env bash
# Hook: audit-trail (PostToolUse: *)
# Logs every Claude Code action to a daily JSONL file

set -euo pipefail

INPUT=$(cat)
TOOL=$(echo "$INPUT" | jq -r '.tool_name // empty')

if [ -z "$TOOL" ]; then
  exit 0
fi

# Create audit directory
AUDIT_DIR="$HOME/.claude/audit"
mkdir -p "$AUDIT_DIR"

# Get details based on tool type
case "$TOOL" in
  Bash)
    DETAIL=$(echo "$INPUT" | jq -r '.tool_input.command // "unknown"' | head -c 200)
    ;;
  Read|Write|Edit)
    DETAIL=$(echo "$INPUT" | jq -r '.tool_input.file_path // "unknown"')
    ;;
  Grep)
    DETAIL=$(echo "$INPUT" | jq -r '.tool_input.pattern // "unknown"')
    ;;
  Glob)
    DETAIL=$(echo "$INPUT" | jq -r '.tool_input.pattern // "unknown"')
    ;;
  Agent)
    DETAIL=$(echo "$INPUT" | jq -r '.tool_input.description // "unknown"')
    ;;
  *)
    DETAIL=$(echo "$INPUT" | jq -r '.tool_input | keys[0] // "unknown"' 2>/dev/null || echo "unknown")
    ;;
esac

# Write log entry
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ" 2>/dev/null || date +"%Y-%m-%dT%H:%M:%S")
DATE=$(date +"%Y-%m-%d" 2>/dev/null || date +"%Y-%m-%d")
LOG_FILE="$AUDIT_DIR/$DATE.jsonl"

echo "{\"ts\":\"$TIMESTAMP\",\"tool\":\"$TOOL\",\"detail\":\"$(echo "$DETAIL" | sed 's/"/\\"/g')\"}" >> "$LOG_FILE"

exit 0
