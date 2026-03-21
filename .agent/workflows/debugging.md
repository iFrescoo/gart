---
name: debugging
description: Systematic 6-step debugging workflow. Use when diagnosing errors, unexpected behavior, or failing tests.
---

# Debugging Workflow

## When to Activate

- User reports an error, crash, or unexpected behavior
- Tests are failing with unclear cause
- User asks to "debug", "investigate", or "fix" something

## Step 1: Reproduce

- Get exact error message, stack trace, or unexpected output
- Identify the trigger: what action/input causes the bug?
- Confirm environment: Node version, OS, browser, config

## Step 2: Isolate

- Narrow down to the smallest reproducing case
- Use `mgrep` to find the error source in codebase
- Check `git log` — did a recent commit introduce this?

## Step 3: Inspect

- Read the relevant code path end-to-end
- Check variable values at key points (add temporary logs if needed)
- Inspect dependencies: are API responses, DB queries, or configs correct?

## Step 4: Hypothesize

- Form 1-3 hypotheses for the root cause
- Rank by likelihood
- For each hypothesis, identify what evidence would confirm/reject it

## Step 5: Fix

- Fix the root cause, not the symptom
- Minimal change — don't refactor surrounding code
- Add a test that would have caught this bug

## Step 6: Prevent

- Why did this bug happen? Missing test? Unclear API? Race condition?
- Add safeguards: type check, validation, error boundary, test case
- Document the fix in commit message (what was wrong, why, how fixed)
