---
description: Local preview — auto-detect framework, start dev server, verify pages load
agent: build
---

# Preview

## When to Use

- User says "preview", "show me", "run locally", "demo"
- After implementing a feature — verify it works
- Before deploying — final local verification

## Process

### 1. Start Server (Auto-detect)

| Framework     | Detection               | Start Command                        |
| ------------- | ----------------------- | ------------------------------------ |
| **Next.js**   | `next.config.*`         | `npm run dev`                        |
| **Vite**      | `vite.config.*`         | `npm run dev`                        |
| **CRA**       | `react-scripts` in deps | `npm start`                          |
| **Nuxt**      | `nuxt.config.*`         | `npm run dev`                        |
| **SvelteKit** | `svelte.config.*`       | `npm run dev`                        |
| **Astro**     | `astro.config.*`        | `npm run dev`                        |
| **Express**   | `app.listen` in source  | `npm run dev` or `node src/index.js` |
| **Static**    | `index.html` in root    | `npx serve .`                        |

Wait for server to be ready.

### 2. Verify

- Main page loads (HTTP 200)
- No JavaScript errors in console
- No failed network requests
- Specific feature/change works

### 3. Test Critical Flows

Navigation, form submissions, authentication, data loading, error states.

### 4. Report

```
Preview Report
==============
Server:    Next.js dev on http://localhost:3000
Status:    Running, no errors
Pages:     3/3 load successfully
Console:   Clean
Feature:   [verified description]
Issues:    None
```
