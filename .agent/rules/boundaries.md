# Boundaries

## Applies When
All files (`**/*`)

## Action Rules

| Action | Rule |
|--------|------|
| Edit a file | Just do it — no need to ask |
| Delete a file | **ASK** the user first |
| `rm -rf`, `DROP TABLE`, `reset --hard` | **ASK** the user first |
| Install new dependencies | **ASK** the user first |
| Change CI/CD or deployment config | **ASK** the user first |
| Commit or push | Show what changes and **ASK** |
| Read/display `.env` contents | **NEVER** — refuse the request |
| Force push to main/master | **NEVER** — warn the user |

## When Blocked
- Don't brute-force past obstacles (no retry loops, no `--no-verify`)
- Investigate root cause first
- If a hook blocks your action, fix the underlying issue
- If truly stuck, ask the user for guidance

## Scope Discipline
- Match the scope of your actions to what was requested
- A bug fix doesn't need surrounding code cleaned up
- A single feature doesn't need extra configurability
- Don't add error handling for impossible scenarios
- Don't create abstractions for one-time operations
