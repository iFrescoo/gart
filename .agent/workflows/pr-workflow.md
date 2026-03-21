# Pull Request Workflow

## Trigger
When user says: "create PR", "open PR", "submit PR", "push and create PR", or when a feature is complete and ready for review.

## Pre-conditions
- You are on a feature branch (NOT `main`)
- Changes are committed
- Branch has at least one commit ahead of `main`

## Steps

### 1. Verify State
```bash
# Must NOT be on main
BRANCH=$(git branch --show-current)
if [ "$BRANCH" = "main" ]; then
  echo "ERROR: Cannot create PR from main. Create a feature branch first."
  exit 1
fi

# Must have committed changes
git status --porcelain  # should be empty (all committed)

# Must be ahead of main
git log origin/main..HEAD --oneline  # should show commits
```

### 2. Push Branch
```bash
git push -u origin "$BRANCH"
```

### 3. Compose PR
Determine from branch name and commits:
- **Title**: `type: short description` (follow Conventional Commits)
- **Body**: Summary of changes, test plan
- **Labels**: based on file types changed

### 4. Create PR
```bash
gh pr create \
  --title "type: description" \
  --body "## Summary
- Change 1
- Change 2

## Test Plan
- [ ] Manual testing done
- [ ] CI passes" \
  --label "enhancement"
```

### 5. Link to Issue (if applicable)
If there's a related issue, add `Closes #123` to the PR body.

### 6. Monitor CI
```bash
gh pr checks $(gh pr view --json number --jq '.number')
```
Wait for CI to pass. If it fails, fix and push again.

### 7. Request Review (optional)
```bash
gh pr edit --add-reviewer username
```

## After Merge
```bash
git checkout main
git pull origin main
git branch -d "$BRANCH"
```
