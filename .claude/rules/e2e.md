# E2E Testing Conventions

## Applies When
End-to-end test files (`e2e/**`, `cypress/**`, `playwright/**`, `**/*.e2e.ts`)

## Rules

### Scope
- Test critical user journeys only (sign up, purchase, key workflows)
- Don't duplicate unit test coverage
- Keep E2E suite small and fast — every test adds maintenance cost

### Selectors (priority order)
1. `data-testid="submit-button"` — most stable, purpose-built
2. ARIA roles: `getByRole('button', { name: 'Submit' })`
3. Text content: `getByText('Submit')`
4. **Never** use CSS classes or DOM structure — too fragile

### Test Data
- Create fresh test data per test run
- Clean up after tests (database, files, state)
- Use factories/fixtures for consistent test data
- Never rely on shared state between tests

### Network
- Mock external APIs (payment gateways, email services)
- Allow internal API calls (test the real integration)
- Set reasonable timeouts (5-10s for page loads)
- Handle flaky network conditions explicitly

### Patterns

**Page Object Model:**
```typescript
class LoginPage {
  async login(email: string, password: string) {
    await page.fill('[data-testid="email"]', email);
    await page.fill('[data-testid="password"]', password);
    await page.click('[data-testid="submit"]');
  }
}
```

### Don'ts
- No `sleep()` — use explicit waits (`waitForSelector`, `waitForResponse`)
- No browser-specific tests (unless testing browser compatibility)
- No visual regression tests without baseline management
- Don't test third-party services (mock them)
