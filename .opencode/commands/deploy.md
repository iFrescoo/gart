---
description: Production deployment with validation gate — blocks on failure
agent: build
---

# Deploy

## When to Use

- User says "deploy", "ship", "go live", "push to production"
- Ready to ship code to production or staging

## Process

### 1. Pre-Deploy Gate (Auto — BLOCKS on failure)

```bash
bash scripts/validate.sh --quick
```

| Result            | Action                                    |
| ----------------- | ----------------------------------------- |
| Exit 0 (all pass) | Proceed to build                          |
| Exit 1 (any fail) | **STOP** — show failures, ask user to fix |

Additional checks:

- Git working tree is clean
- On correct branch (main, release/\*)
- All tests pass

### 2. Build

Detect and run build command:

| Framework  | Build Command                  |
| ---------- | ------------------------------ |
| Next.js    | `npm run build`                |
| Vite       | `npm run build`                |
| TypeScript | `tsc && npm run build`         |
| Docker     | `docker build -t app:latest .` |

### 3. Deploy

Auto-detect platform:

| Platform    | Detection                   | Deploy Command             |
| ----------- | --------------------------- | -------------------------- |
| **Vercel**  | `vercel.json`               | `vercel --prod`            |
| **Netlify** | `netlify.toml`              | `netlify deploy --prod`    |
| **Docker**  | `Dockerfile`                | `docker push`              |
| **npm**     | `package.json` with exports | Chain to `/github-release` |

### 4. Health Check

Verify deployed URL responds (HTTP 200), check critical endpoints, verify no error logs.

### 5. Post-Deploy

Tag deployment, summarize what was deployed and where.
