# Debugging Protocol

For difficult bugs, follow this flow:

## Step 1 — Reproduction

- Create a minimal reproduction case
- Document the exact steps to trigger the bug
- Check versions: OS, Node, framework, dependencies

## Step 2 — Isolation

- Binary search: disable half the code/features
- `git bisect` — when was the bug introduced?
- Remove dependencies one by one

## Step 3 — Inspection

- Strategic `console.log` or debugger statements
- Check network requests and responses
- Review recent changes in `git log`
- `lsp hover` for types, `lsp findReferences` for data flow

## Step 4 — Hypothesis

- Formulate a theory — root cause, not symptom
- Check for race conditions and timing issues
- Test each assumption separately

## Step 5 — Fix and Verification

- Test the fix thoroughly
- Add a regression test
- Document the root cause in a comment or commit message

## Step 6 — Prevention

- Better error handling
- Better logging
- Tests for edge cases
