# Git Conventions

## Applies When
Git operations, commit messages, branch management

## Conventional Commits

Format: `type(scope): description`

| Type | When |
|------|------|
| `feat:` | New feature |
| `fix:` | Bug fix |
| `docs:` | Documentation only |
| `refactor:` | Code change that neither fixes nor adds |
| `test:` | Adding or updating tests |
| `chore:` | Build, CI, dependencies, tooling |
| `perf:` | Performance improvement |
| `style:` | Formatting, whitespace (no logic change) |
| `ci:` | CI/CD pipeline changes |

### Commit Message Rules
- Focus on **why**, not what (the diff shows what)
- 1-2 sentences, concise
- Never commit `.env`, `credentials.json`, or secret files
- Prefer `git add <specific files>` over `git add -A`

## Branch Naming
- `feat/short-description` — new feature
- `fix/issue-number-description` — bug fix
- `refactor/what-changed` — refactoring
- `docs/topic` — documentation

## Safety
- **Never** force push to `main`/`master`
- **Never** use `--no-verify` to skip hooks
- **Never** use `-i` flag (interactive mode not supported)
- Prefer new commits over amending (amend can destroy previous work)
- Investigate merge conflicts rather than discarding changes
