---
description: Structured code review workflow. Use when reviewing PRs, code changes, or performing quality checks on modified files.
agent: build
---


# Code Review Workflow

## When to Activate

- User asks to review code, a PR, or recent changes
- After completing a feature implementation
- Before merging or pushing code

## Phase 1: Scope

1. Identify changed files (`git diff --name-only` or PR diff)
2. Categorize changes: new feature, bug fix, refactor, config change
3. Note the size — if >500 lines changed, break into logical chunks

## Phase 2: Review Checklist

For each changed file, check:

- [ ] **Correctness** — Does the logic do what it claims?
- [ ] **Security** — SQL injection, XSS, hardcoded secrets, .env exposure?
- [ ] **Performance** — O(n^2) loops, N+1 queries, unnecessary re-renders?
- [ ] **Types** — No `any`, proper return types, null checks?
- [ ] **Imports** — No duplicates, no unused, no circular dependencies?
- [ ] **Tests** — Are new paths covered? Do existing tests still pass?
- [ ] **Naming** — Clear, consistent, no abbreviations without context?

## Phase 3: Report

Use this format for each finding:

```
OK — [what is good]
Needs improvement — [file:line] -> [suggested fix]
Critical — [file:line] -> [suggested fix]
```

## Phase 4: Summary

1. Overall assessment: Ship / Ship with fixes / Needs rework
2. List blocking issues (if any)
3. Suggest follow-up tasks
