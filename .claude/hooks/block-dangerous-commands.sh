#!/bin/bash
# Claude Code PreToolUse hook — blokuje destrukcyjne komendy bash.
# Exit 0 = allow, Exit 2 = block
#
# Otrzymuje JSON na stdin z polami: tool_name, tool_input
# Sprawdza tool_input.command pod kątem niebezpiecznych wzorców.

INPUT=$(cat)

# Wyciągnij komendę z JSON (tool_input.command)
COMMAND=$(echo "$INPUT" | grep -oP '"command"\s*:\s*"[^"]*"' | head -1 | sed 's/"command"\s*:\s*"//' | sed 's/"$//')

if [ -z "$COMMAND" ]; then
    exit 0
fi

# Wzorce do blokowania
BLOCKED_PATTERNS=(
    "rm -rf /"
    "rm -rf ~"
    "rm -rf \."
    "rm -rf \*"
    "git push --force"
    "git push -f "
    "git reset --hard"
    "git clean -fd"
    "DROP TABLE"
    "DROP DATABASE"
    "TRUNCATE TABLE"
    "> /dev/sda"
    "mkfs\."
    ":(){:|:&};:"
)

COMMAND_LOWER=$(echo "$COMMAND" | tr '[:upper:]' '[:lower:]')

for pattern in "${BLOCKED_PATTERNS[@]}"; do
    pattern_lower=$(echo "$pattern" | tr '[:upper:]' '[:lower:]')
    if echo "$COMMAND_LOWER" | grep -qF "$pattern_lower"; then
        echo "BLOCKED: Komenda zawiera niebezpieczny wzorzec: $pattern"
        echo "Jeśli to celowe — wykonaj ręcznie w terminalu."
        exit 2
    fi
done

exit 0
