---
description: Security audit workflow. Use when reviewing code for vulnerabilities, checking dependencies, or hardening an application.
agent: build
---


# Security Audit Workflow

## When to Activate

- User asks for a security review or audit
- Before deploying to production
- After adding authentication, payment, or data handling features

## Phase 1: OWASP Top 10 Check

For each applicable category, scan the codebase:

- [ ] **Injection** — SQL/NoSQL injection, command injection, LDAP injection
- [ ] **Broken Auth** — weak passwords, missing MFA, session fixation
- [ ] **Sensitive Data** — unencrypted PII, secrets in logs, missing HTTPS
- [ ] **XXE** — XML external entity processing
- [ ] **Broken Access Control** — missing authorization checks, IDOR
- [ ] **Misconfiguration** — default credentials, verbose errors in production, CORS wildcards
- [ ] **XSS** — unescaped user input rendered in HTML, unsafe DOM manipulation
- [ ] **Insecure Deserialization** — untrusted data deserialization
- [ ] **Known Vulnerabilities** — outdated dependencies with CVEs
- [ ] **Insufficient Logging** — missing audit trail for security events

## Phase 2: Dependency Audit

```bash
npm audit --audit-level=high
```

- Check for known CVEs in dependencies
- Verify license compliance
- Flag outdated packages with security patches available

## Phase 3: Secrets & Environment

- [ ] No hardcoded API keys, tokens, or passwords in code
- [ ] `.env` files in `.gitignore`
- [ ] No secrets in git history
- [ ] Environment variables used for all credentials
- [ ] `.env.example` has placeholder values only

## Phase 4: Report

```
PASS — [category]: [what is secure]
WARN — [category]: [file:line] -> [potential risk + recommendation]
FAIL — [category]: [file:line] -> [vulnerability + fix required]
```

Priority: Fix all FAIL items before deployment. Address WARN items in next sprint.
