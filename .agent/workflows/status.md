---
name: status
description: Project health dashboard workflow. Runs validate.sh to produce a traffic-light report across code quality, security, tests, and dependencies. One-command project audit.
---

# Status Workflow

## When to Activate

- User says "status", "health check", "project health", "audit project", "how's the project"
- Before starting a new feature (check baseline health)
- During code review or handoff

## Phase 1: Run Validation (Auto)

Execute the validation script:

```bash
bash scripts/validate.sh --full
```

If `validate.sh` is not found, run checks manually (see Phase 2).

## Phase 2: Health Checks

### Code Quality

- [ ] `tsc --noEmit` — TypeScript type checking
- [ ] `npm run lint` or `ruff check .` — Linting
- [ ] No `console.log` in production code
- [ ] No `any` types in TypeScript

### Security

- [ ] `npm audit --audit-level=high` — Known vulnerabilities
- [ ] No secrets in source code (grep for API keys, tokens, passwords)
- [ ] `.env` is in `.gitignore`
- [ ] No hardcoded credentials

### Tests

- [ ] `npm test` — All tests pass
- [ ] Coverage report: `npm run test:coverage`
- [ ] No skipped tests without reason

### Dependencies

- [ ] `npm outdated` — Check for updates
- [ ] No deprecated packages
- [ ] Lock file is committed and up to date

### Git Health

- [ ] No uncommitted changes
- [ ] Branch is up to date with remote
- [ ] No merge conflicts

## Phase 3: Report

Generate a traffic-light dashboard:

```
Project Health Report
====================

Code Quality  [PASS] tsc clean, lint clean
Security      [WARN] 2 moderate npm vulnerabilities
Tests         [PASS] 47/47 passing, 82% coverage
Dependencies  [WARN] 3 packages outdated
Git           [PASS] clean, up to date

Overall: HEALTHY (2 warnings)
```

Status indicators:

- `[PASS]` — All checks passed
- `[WARN]` — Non-blocking issues found
- `[FAIL]` — Blocking issues that need attention
- `[SKIP]` — Check could not run (tool not found)

## Phase 4: Recommendations

Based on findings, suggest actions in priority order:

1. **Critical** — Fix immediately (security vulnerabilities, failing tests)
2. **Important** — Fix soon (outdated deps, missing coverage)
3. **Nice to have** — Fix when convenient (minor lint warnings)
