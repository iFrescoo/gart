---
description: Test strategy workflow. Use when planning tests, writing test suites, or improving coverage.
agent: build
---


# Testing Workflow

## When to Activate

- User asks to add tests or improve coverage
- After implementing a new feature
- When fixing a bug (add regression test)

## Test Pyramid Strategy

```
        /  E2E  \          Few — critical user flows only
       / Integration \      Moderate — API, DB, service boundaries
      /    Unit Tests   \   Many — pure logic, utilities, components
```

## Phase 1: Identify What to Test

1. List all new/changed functions and components
2. Identify critical paths (auth, payments, data mutations)
3. Check current coverage gaps

## Phase 2: Write Tests

### Unit Tests
- Test pure functions and utilities
- One assertion per test (ideally)
- AAA pattern: Arrange → Act → Assert
- Mock external dependencies, not internal logic

### Integration Tests
- Test API endpoints with real database (when possible)
- Test service interactions
- Verify error responses and edge cases

### E2E Tests
- Cover critical user journeys only
- Use stable selectors (data-testid, aria-label)
- Clean up test data after each run

## Phase 3: Coverage Targets

| Type | Target |
|------|--------|
| Unit | 80%+ line coverage |
| Integration | All API endpoints |
| E2E | Top 5 user flows |

## Phase 4: Verify

1. Run full test suite: `npm test`
2. Check coverage report: `npm run test:coverage`
3. Ensure no flaky tests (run 3x if suspect)
4. All CI checks pass
