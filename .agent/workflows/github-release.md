# GitHub Release Workflow

## Trigger
When user says: "release", "publish", "new version", "bump version", "create release"

## Pre-conditions
- You are on `main` branch
- Working tree is clean (no uncommitted changes)
- CI has passed on latest commit

## Steps

### 1. Verify State
```bash
# Must be on main
git branch --show-current  # should output: main

# Must be clean
git status --porcelain  # should be empty

# Check latest CI status
gh run list --limit 1 --json status --jq '.[0].status'  # should be: completed
```

### 2. Determine Version
Ask user what kind of release:
- **patch** (1.0.0 → 1.0.1): bug fixes only
- **minor** (1.0.0 → 1.1.0): new features, backward compatible
- **major** (1.0.0 → 2.0.0): breaking changes

Read current version from `cli/package.json` → compute new version.

### 3. Bump Version
Update version in `cli/package.json`.
Commit: `chore: bump version to v{new_version}`

### 4. Generate Changelog
```bash
git log --oneline $(git describe --tags --abbrev=0)..HEAD
```
Review the commits that will be in this release.

### 5. Tag and Push
```bash
git tag v{new_version}
git push origin main --tags
```

### 6. Verify
GitHub Actions will automatically:
- Run CI quality gate
- Publish to npm with provenance
- Create GitHub Release with auto-generated notes

Verify:
```bash
gh release view v{new_version}
npm view gart-build version
```

## Rollback (if needed)
```bash
# Delete tag locally and remotely
git tag -d v{new_version}
git push origin --delete v{new_version}
# npm unpublish is NOT recommended — publish a patch fix instead
```
