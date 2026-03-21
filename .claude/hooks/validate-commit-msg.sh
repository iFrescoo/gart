#!/usr/bin/env bash
# Hook: validate-commit-msg (PreToolUse: Bash)
# Enforces Conventional Commits format on git commit commands

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

# Only check git commit commands
if ! echo "$COMMAND" | grep -qE 'git[[:space:]]+commit'; then
  exit 0
fi

# Extract commit message from -m flag
COMMIT_MSG=$(echo "$COMMAND" | grep -oP '(?<=-m[[:space:]]["\x27])[^"\x27]*' || true)

# Also check heredoc style commit messages
if [ -z "$COMMIT_MSG" ]; then
  COMMIT_MSG=$(echo "$COMMAND" | grep -oP '(?<=-m[[:space:]]"\$\(cat <<.*?EOF).*?(?=EOF)' || true)
fi

# If we can't extract the message (interactive or complex), allow it
if [ -z "$COMMIT_MSG" ]; then
  exit 0
fi

# Validate Conventional Commits format
VALID_TYPES="feat|fix|docs|style|refactor|test|chore|perf|ci|build|revert"
if ! echo "$COMMIT_MSG" | grep -qE "^($VALID_TYPES)(\(.+\))?!?:[[:space:]].+"; then
  echo "BLOCKED: Commit message does not follow Conventional Commits format."
  echo ""
  echo "Expected: type(scope): description"
  echo "Valid types: feat, fix, docs, style, refactor, test, chore, perf, ci, build, revert"
  echo ""
  echo "Examples:"
  echo "  feat: add user registration"
  echo "  fix(auth): resolve token expiration bug"
  echo "  docs: update API reference"
  exit 2
fi

exit 0
