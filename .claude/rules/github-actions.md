# GitHub Actions Conventions

## Applies When
GitHub Actions files (`.github/workflows/**`, `.github/actions/**`)

## Rules

### Workflow Structure
- **Triggers**: Be explicit — `push` with branch filter, `pull_request`, `workflow_dispatch`
- **Concurrency**: Always set `concurrency` group to prevent duplicate runs
- **Timeout**: Set `timeout-minutes` on every job (default is 6 hours — too long)
- **Permissions**: Use least-privilege `permissions:` block (don't rely on defaults)

### Actions
- Pin versions: `uses: actions/checkout@v4` (minimum), full SHA for production
- Never use `@latest` or `@main` — breaking changes will break your CI
- Prefer official actions (`actions/*`) over community when available

### Build Steps
- Use `npm ci` (not `npm install`) — reproducible, respects lockfile
- Cache dependencies: `actions/setup-node` with `cache: npm`
- Run lint before build, build before test (fail fast)

### Matrix Strategies
```yaml
strategy:
  matrix:
    node-version: [18, 20, 22]
  fail-fast: false  # don't cancel other matrix jobs on failure
```

### Secrets & Security
- Store in GitHub Secrets — never hardcode in workflow files
- Never `echo` or log secret values
- Use OIDC (`id-token: write`) for cloud deployments (no long-lived credentials)
- Use `--provenance` flag for npm publish (supply chain security)

### Concurrency Pattern
```yaml
concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: true  # cancel outdated PR runs
```

### Caching
- Cache `node_modules` or `.npm` directory between runs
- Cache Docker layers for container builds
- Set `cache` option on `actions/setup-node` instead of manual cache step

### Don'ts
- No `continue-on-error: true` without good reason (hides failures)
- No deployment from feature branches (only main/release)
- No `--no-verify` or `--force` in CI scripts
- No manual approval steps in automated pipelines (use environment protection rules instead)
- No storing secrets in workflow file comments
