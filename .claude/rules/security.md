# Security

## Applies When
All files (`**/*`)

## Proactive Checks

### OWASP Top 10
- **SQL Injection** — always use parameterized queries, never string concatenation
- **XSS** — never use raw HTML injection without sanitization (use DOMPurify or equivalent)
- **CSRF** — verify CSRF tokens on state-changing requests
- **Broken Auth** — validate sessions server-side, use secure cookie flags

### Credentials & Secrets
- **Never** hardcode API keys, passwords, tokens, or connection strings
- **Never** commit `.env` files — use `.env.example` with placeholder values
- **Never** log sensitive data (passwords, tokens, PII)
- Use environment variables for all secrets
- Rotate credentials if accidentally exposed

### Dependencies
- Prefer well-maintained packages with active security patches
- Run `npm audit` after adding dependencies
- Pin major versions to avoid breaking changes

### File System
- Validate file paths — prevent path traversal attacks
- Sanitize user-provided filenames
- Set appropriate file permissions (no world-writable)

### API Security
- Rate limit all endpoints
- Validate and sanitize all input at system boundaries
- Return generic error messages to clients (detailed errors in server logs only)
- Use HTTPS everywhere
