# CI/CD Conventions

## Applies When
CI/CD pipeline files (`.github/workflows/**`, `.gitlab-ci.yml`, `Jenkinsfile`)

## Rules

### Pipeline Structure
1. **Lint** — ESLint, Prettier, ruff (fast feedback)
2. **Type Check** — `tsc --noEmit` or equivalent
3. **Unit Tests** — with coverage report
4. **Build** — compile/bundle
5. **Integration Tests** — API, database
6. **Security Scan** — `npm audit`, dependency check
7. **Deploy** — only on main/release branches

### GitHub Actions Specifics
- Pin action versions with SHA: `uses: actions/setup-node@v4` (or full SHA)
- Use `npm ci` (not `npm install`) for reproducible builds
- Cache `node_modules` or `.npm` between runs
- Set `timeout-minutes` on all jobs (prevent hung builds)
- Use `concurrency` to cancel outdated runs

### Branch Protection
- Require CI pass before merge
- Require at least 1 review for PRs to main
- Don't allow force push to main/master

### Secrets
- Store in GitHub Secrets / CI environment variables
- Never log secret values
- Rotate secrets regularly
- Use OIDC for cloud deployments (no long-lived credentials)

### Don'ts
- No deployment from feature branches (only main/release)
- No skipping tests in CI (if tests are flaky, fix them)
- No manual steps in deployment (everything automated)
- No `--no-verify` or `--force` flags in CI scripts
