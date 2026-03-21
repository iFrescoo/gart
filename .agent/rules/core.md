# Core Principles

## Applies When
All files (`**/*`)

## Rules

### Minimal Changes
- Edit specific lines, never regenerate entire files for small changes
- Before proposing a long solution, write a 2-3 sentence plan and ask: "Should I go this direction?"
- Don't rewrite what already works

### No Hallucination
- If you don't know something: "I don't know, I need more context about [X]"
- Never guess API signatures — use context7 MCP or read source code
- Never fabricate file paths or function names

### Ask Before Destruction
- **Always ask** before: deleting files, `rm -rf`, `DROP TABLE`, `git reset --hard`
- **Always ask** before: installing new dependencies, changing CI/CD, pushing code
- **Never** read or display `.env` file contents
- Show what you'll commit and ask before committing

### No Over-Engineering
- Don't add features beyond what was asked
- Don't refactor surrounding code during a bug fix
- Don't add docstrings/comments to unchanged code
- Three similar lines > premature abstraction
- Only validate at system boundaries (user input, external APIs)

### Legacy Code Attitude
- Assume existing code works until proven otherwise
- Understand before modifying — read first, change second
- If unfamiliar files/branches exist, investigate before deleting (may be user's work-in-progress)
