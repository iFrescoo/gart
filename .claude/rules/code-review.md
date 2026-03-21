# Code Review

## Applies When
All files during review (`**/*`)

## Review Format

```
OK — [what's good about the code]
Needs improvement — [file:line] -> [suggested fix with reason]
Critical — [file:line] -> [must-fix issue with explanation]
```

## Checklist

### Correctness
- [ ] Does the code do what it's supposed to?
- [ ] Are edge cases handled (null, empty, boundary values)?
- [ ] Are error conditions handled properly?
- [ ] Does it match the requirements/ticket?

### Security
- [ ] No hardcoded secrets or credentials
- [ ] Input validated at system boundaries
- [ ] No SQL injection, XSS, or CSRF vulnerabilities
- [ ] Sensitive data not logged or exposed in errors

### Performance
- [ ] No O(n²) where O(n) is possible
- [ ] No N+1 database queries
- [ ] No memory leaks (uncleared listeners, timers)
- [ ] Reasonable bundle size impact

### Maintainability
- [ ] Clear naming (no abbreviations, no magic numbers)
- [ ] Functions are small and single-purpose
- [ ] No dead code or commented-out blocks
- [ ] Tests cover the new behavior

### Style
- [ ] Consistent with existing codebase patterns
- [ ] No unnecessary changes to unrelated code
- [ ] Imports organized (no duplicates, no unused)

## Principles
- Focus on bugs and logic errors, not style preferences
- Suggest improvements, don't demand rewrites
- Provide context for why something should change
- Acknowledge what's done well
