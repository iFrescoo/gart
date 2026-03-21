---
name: deploy
description: Production deployment workflow with pre-deploy validation gate. Auto-runs validate.sh, detects platform (Vercel/Netlify/Docker/AWS), builds, deploys, and verifies. Chains to github-release workflow for npm publishing.
---

# Deploy Workflow

## When to Activate

- User says "deploy", "ship", "go live", "push to production", "release"
- Ready to ship code to production or staging environment
- Publishing a package to npm

## Phase 1: Pre-Deploy Gate (Auto — BLOCKS on failure)

Run validation automatically before any deployment:

```bash
bash scripts/validate.sh --quick
```

| Result            | Action                                                     |
| ----------------- | ---------------------------------------------------------- |
| Exit 0 (all pass) | Proceed to Phase 2                                         |
| Exit 1 (any fail) | **STOP** — show failures, ask user to fix before deploying |

Additional pre-deploy checks:

- [ ] Git working tree is clean (`git status --porcelain` is empty)
- [ ] On correct branch (main, release/\*, or deploy branch)
- [ ] No uncommitted changes
- [ ] All tests pass

## Phase 2: Build

Detect and run the appropriate build command:

| Framework  | Build Command                       |
| ---------- | ----------------------------------- |
| Next.js    | `npm run build` (runs `next build`) |
| Vite       | `npm run build` (runs `vite build`) |
| TypeScript | `tsc && npm run build`              |
| Docker     | `docker build -t app:latest .`      |
| Custom     | Read `package.json` scripts.build   |

Verify build output exists and is valid.

## Phase 3: Deploy

Auto-detect platform and deploy:

| Platform    | Detection                            | Deploy Command                         |
| ----------- | ------------------------------------ | -------------------------------------- |
| **Vercel**  | `vercel.json` or `.vercel/`          | `vercel --prod`                        |
| **Netlify** | `netlify.toml`                       | `netlify deploy --prod`                |
| **Docker**  | `Dockerfile`                         | `docker push` / `docker-compose up -d` |
| **AWS**     | `serverless.yml` or `cdk.json`       | `serverless deploy` / `cdk deploy`     |
| **npm**     | `package.json` with `main`/`exports` | Chain to `/github-release` workflow    |
| **Manual**  | None detected                        | Ask user for deployment target         |

## Phase 4: Health Check

After deployment:

1. Verify the deployed URL responds (HTTP 200)
2. Check critical endpoints (API health, homepage load)
3. Verify no error logs in first 60 seconds
4. Report deployment status: SUCCESS or FAILED

## Phase 5: Post-Deploy

- If npm publish → chain to `.agent/workflows/github-release.md`
- Tag the deployment: `git tag -a v{version} -m "Deploy {date}"`
- Notify: summarize what was deployed, where, and any issues
