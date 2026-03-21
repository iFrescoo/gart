# Error Handling

## Applies When
All source files (`**/*`)

## Rules

### General
- **No silent failures** — every `catch` must log, re-throw, or handle meaningfully
- **No empty catch blocks** — at minimum, log the error
- **Specific catch** — catch specific error types, not generic `Error`
- **Fail fast** — validate inputs early, return/throw before deep nesting

### Patterns

**BAD:**
```
try { doSomething(); } catch (e) { /* ignore */ }
```

**GOOD:**
```
try {
  doSomething();
} catch (error) {
  logger.error('Failed to do something', { error, context });
  throw new AppError('Operation failed', { cause: error });
}
```

### Custom Errors
- Create domain-specific error classes for different failure modes
- Include context (what was being done, with what data)
- Distinguish user-facing errors from internal errors

### API Error Responses
- Return appropriate HTTP status codes (400, 401, 403, 404, 500)
- Return generic messages to clients
- Log detailed errors server-side with stack traces
- Include request IDs for correlation

### Graceful Degradation
- Provide fallback values for non-critical features
- Show meaningful error states in UI (not blank screens)
- Retry transient failures (network, rate limits) with exponential backoff
- Set timeouts on all external calls
