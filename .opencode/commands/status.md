---
description: Project health dashboard — one-command audit with traffic-light report
agent: build
---

# Status

## When to Use

- User says "status", "health check", "project health", "audit"
- Before starting a new feature
- During code review or handoff

## Process

### 1. Run Validation (Auto)

```bash
bash scripts/validate.sh --full
```

If `validate.sh` is not found, run checks manually.

### 2. Health Checks

**Code Quality**

- `tsc --noEmit` — TypeScript type checking
- `npm run lint` — Linting
- No `any` types in TypeScript

**Security**

- `npm audit --audit-level=high` — Known vulnerabilities
- No secrets in source code
- `.env` is in `.gitignore`

**Tests**

- `npm test` — All tests pass
- Coverage report if available

**Dependencies**

- `npm outdated` — Check for updates
- No deprecated packages

**Git Health**

- No uncommitted changes
- Branch is up to date with remote

### 3. Report

```
Project Health Report
====================
Code Quality  [PASS] tsc clean, lint clean
Security      [WARN] 2 moderate vulnerabilities
Tests         [PASS] 47/47 passing, 82% coverage
Dependencies  [WARN] 3 packages outdated
Git           [PASS] clean, up to date

Overall: HEALTHY (2 warnings)
```

### 4. Recommendations

Prioritized actions: Critical → Important → Nice to have.
