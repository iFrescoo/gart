---
name: github-operations
description: GitHub platform best practices, workflow patterns, API usage, and automated flows for PR creation, releases, and repository management. Auto-loaded when working with .github/ files.
---

# GitHub Operations Skill

## When This Skill Activates
When working with `.github/**` files, GitHub Actions workflows, or any GitHub platform integration.

## GitHub Actions Workflow Checklist
Before creating or modifying a workflow, verify:
- [ ] Triggers are explicit (`push` with branch filter, `pull_request`, `workflow_dispatch`)
- [ ] `concurrency` group set (prevents duplicate runs)
- [ ] `timeout-minutes` on every job
- [ ] `permissions:` block with least privilege
- [ ] Action versions pinned (`@v4` minimum)
- [ ] `npm ci` used (not `npm install`)
- [ ] Dependencies cached (`actions/setup-node` with `cache: npm`)
- [ ] Secrets via `${{ secrets.NAME }}` (never hardcoded)

## Repository Security Checklist
- [ ] `.github/dependabot.yml` configured for npm + actions ecosystems
- [ ] Secret scanning enabled with custom patterns (AI API keys)
- [ ] Branch protection on `main` (required reviews + status checks)
- [ ] `CODEOWNERS` file for automatic review routing
- [ ] No `--no-verify` or `--force` in CI scripts

## Release Flow (Automated)
When user says "do a release" or "publish new version":

1. **Pre-check**: Verify on `main`, CI green, no uncommitted changes
2. **Version**: Bump version in `package.json` (follow semver)
3. **Changelog**: `git log --oneline $(git describe --tags --abbrev=0)..HEAD`
4. **Tag**: `git tag v{version}`
5. **Push**: `git push origin main --tags`
6. **Verify**: GitHub Actions publishes to npm, creates GitHub Release
7. **Confirm**: `gh release view v{version}` + `npm view {package} version`

## PR Creation Flow (Automated)
When finishing a feature or when user says "create a PR":

1. **Pre-check**: Verify on feature branch (not `main`), changes committed
2. **Push**: `git push -u origin {branch}`
3. **Create**: `gh pr create --title "type: description" --body "## Summary\n- changes"`
4. **Labels**: Add relevant labels (`--label enhancement`)
5. **Link**: Reference issue if applicable (`Closes #123`)
6. **Monitor**: `gh pr checks {number}` to verify CI passes

## GitHub CLI (`gh`) Quick Reference

### PRs
```bash
gh pr create --title "feat: X" --body "summary"
gh pr list --state open
gh pr merge 123 --squash --delete-branch
gh pr checks 123
```

### Issues
```bash
gh issue create --title "Bug: X" --label bug
gh issue list --label enhancement --state open
gh issue close 123 --reason completed
```

### Releases
```bash
gh release create v1.0.0 --generate-notes
gh release list
```

### Actions
```bash
gh run list --limit 5
gh run view 12345 --log-failed
gh workflow run ci.yml
```

### API (Raw)
```bash
gh api repos/{owner}/{repo}/pulls --jq '.[].title'
gh api graphql -f query='{ repository(owner:"X", name:"Y") { issues(first:10) { nodes { title } } } }'
```

## GitHub API Patterns

### Rate Limit Management
- Use ETags: `If-None-Match` header → 304 responses don't count against limits
- Paginate with `per_page=100` and `Link` header
- GitHub App: 5000 req/hr per installation
- GITHUB_TOKEN in Actions: 1000 req/hr

### Projects v2 (GraphQL)
```graphql
mutation {
  addProjectV2ItemById(input: {
    projectId: "PVT_xxx"
    contentId: "I_xxx"
  }) { item { id } }
}
```

## Common Pitfalls
- Missing `id-token: write` permission for npm provenance
- Using `npm install` instead of `npm ci` (non-reproducible builds)
- No `timeout-minutes` → stuck jobs run for 6 hours
- `@latest` action tags → breaking changes in CI
- Secrets logged via `echo` or error messages
- Missing `concurrency` → 5 duplicate runs on rapid pushes
