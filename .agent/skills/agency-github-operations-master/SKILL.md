---
name: agency-github-operations-master
description: "Expert GitHub platform specialist covering Actions workflows, REST/GraphQL API, CLI automation, Issues/Projects v2, PRs, Releases, Packages, Security, Webhooks, and Pages."
risk: low
source: local
date_added: '2026-03-21'
---

# GitHub Operations Master

Expert in the GitHub platform ecosystem — Actions CI/CD, REST/GraphQL API, CLI automation, Issues/Projects v2, PRs, Releases, Packages, Security, Webhooks, and Pages.

## When to Use
- Creating or debugging GitHub Actions workflows
- Managing issues/PRs via API or `gh` CLI
- Setting up CI/CD pipelines
- Configuring repository security (Dependabot, secret scanning, CodeQL)
- Publishing releases or packages
- Working with GitHub Projects v2 (GraphQL)

## GitHub Actions Best Practices
- Pin action versions (`actions/checkout@v4`, full SHA for production)
- Set `timeout-minutes` on every job
- Use `concurrency` groups to prevent duplicate runs
- Use `npm ci` (not `npm install`) for reproducible builds
- Cache dependencies via `actions/setup-node` with `cache: npm`
- Use least-privilege `permissions:` block
- Use OIDC (`id-token: write`) for cloud deployments

## GitHub CLI Quick Reference

### PR Lifecycle
```bash
gh pr create --title "feat: description" --body "summary"
gh pr view 123
gh pr merge 123 --squash --delete-branch
```

### Issue Management
```bash
gh issue create --title "Bug: description" --label bug
gh issue list --state open --label enhancement
gh issue close 123 --reason completed
```

### Releases
```bash
gh release create v1.2.0 --generate-notes --title "v1.2.0"
gh release list
gh release view v1.2.0
```

### Actions Monitoring
```bash
gh run list --limit 5
gh run view 12345
gh run watch 12345
```

### Raw API Calls
```bash
gh api repos/{owner}/{repo}/issues --jq '.[].title'
gh api graphql -f query='{ viewer { login } }'
```

## Repository Security Checklist
- [ ] `.github/dependabot.yml` — automated dependency updates
- [ ] Secret scanning enabled with custom patterns for AI API keys
- [ ] Branch protection on `main` — required reviews, status checks
- [ ] `CODEOWNERS` file for automatic review assignment
- [ ] No hardcoded secrets in workflow files

## Release Flow
1. Ensure `main` branch is clean and CI passes
2. Bump version in `package.json`
3. Generate changelog from git log since last tag
4. Create git tag: `git tag v{version}`
5. Push: `git push origin main --tags`
6. GitHub Actions publishes to npm automatically
7. Verify release on npm and GitHub Releases page

## PR Creation Flow
1. Verify you're on a feature branch (not `main`)
2. Push branch to remote
3. Create PR with `gh pr create`
4. Add labels and link to related issue
5. Request reviewers if configured
6. Monitor CI status and address failures
