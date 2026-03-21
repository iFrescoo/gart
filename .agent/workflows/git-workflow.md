---
name: git-workflow
description: Git branching, commit, and PR workflow. Use when creating branches, committing changes, or preparing pull requests.
---

# Git Workflow

## When to Activate

- User asks to commit, push, or create a PR
- Starting work on a new feature or bug fix
- Preparing code for review

## Branch Naming

```
feat/short-description     # New feature
fix/issue-description       # Bug fix
docs/what-changed           # Documentation
refactor/what-changed       # Code refactoring
chore/what-changed          # Maintenance tasks
```

## Commit Messages (Conventional Commits)

```
feat: add user authentication flow
fix: resolve race condition in data loader
docs: update API reference for v2 endpoints
refactor: extract validation logic to shared util
test: add integration tests for payment module
chore: update dependencies to latest versions
```

Rules:
- Imperative mood ("add", not "added" or "adds")
- No period at the end
- First line under 72 characters
- Body (optional): explain WHY, not WHAT

## Pre-Commit Checklist

- [ ] `git diff` — review all changes before staging
- [ ] No `.env`, credentials, or secrets in staged files
- [ ] No `console.log` / debug statements left behind
- [ ] Tests pass (`npm test`)
- [ ] Types check (`tsc --noEmit`)
- [ ] Lint clean (`npm run lint`)

## Pull Request Template

```markdown
## Summary
[1-3 bullet points describing the change]

## Test Plan
- [ ] Unit tests added/updated
- [ ] Manual testing steps
- [ ] Edge cases considered
```
