# Testing Conventions

## Applies When
Test files (`**/*.test.ts`, `**/*.spec.ts`, `**/*.test.tsx`, `**/*.test.js`, `tests/**`)

## Rules

### Structure (AAA Pattern)
```
describe('ComponentName', () => {
  it('should handle specific behavior', () => {
    // Arrange — set up test data
    // Act — perform the action
    // Assert — check the result
  });
});
```

### Naming
- `describe` = unit under test (component, function, class)
- `it`/`test` = specific behavior being tested
- Use clear, readable descriptions: `it('should return null when user is not found')`

### Coverage
- Target: 80%+ for critical business logic
- Don't chase 100% — diminishing returns after 80%
- Cover: happy path, edge cases, error cases
- Skip: trivial getters/setters, framework boilerplate

### Mocks
- Mock external dependencies (APIs, databases, file system)
- Don't mock the unit under test
- Reset mocks between tests (`afterEach`)
- Prefer dependency injection over module mocking when possible

### Don'ts
- No test interdependence — each test must run independently
- No `sleep`/`setTimeout` in tests — use proper async patterns (`waitFor`, `findBy`)
- No snapshot tests for complex/dynamic components (too fragile)
- No testing implementation details — test behavior and outputs
- Don't use `index` as test identifier

### Test Types
| Type | What | When |
|------|------|------|
| Unit | Single function/component | Always |
| Integration | Multiple modules together | Key workflows |
| E2E | Full user flow | Critical paths only |
