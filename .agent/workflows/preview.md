---
name: preview
description: Local preview and verification workflow. Auto-detects framework, starts dev server, verifies pages load, and tests critical user flows. Use before deploying or demoing.
---

# Preview Workflow

## When to Activate

- User says "preview", "show me", "run locally", "demo", "let me see it"
- After implementing a feature — verify it works visually
- Before deploying — final local verification
- During code review — see the change in action

## Phase 1: Start Server (Auto-detect)

Detect the framework and start the appropriate dev server:

| Framework            | Detection               | Start Command                            |
| -------------------- | ----------------------- | ---------------------------------------- |
| **Next.js**          | `next.config.*`         | `npm run dev`                            |
| **Vite**             | `vite.config.*`         | `npm run dev`                            |
| **Create React App** | `react-scripts` in deps | `npm start`                              |
| **Nuxt**             | `nuxt.config.*`         | `npm run dev`                            |
| **SvelteKit**        | `svelte.config.*`       | `npm run dev`                            |
| **Astro**            | `astro.config.*`        | `npm run dev`                            |
| **Express/Fastify**  | `app.listen` in source  | `npm run dev` or `node src/index.js`     |
| **Static HTML**      | `index.html` in root    | `npx serve .` or `python -m http.server` |

Wait for server to be ready (watch for "ready" or "listening" in output).

## Phase 2: Verify

1. Check that the main page loads without errors (HTTP 200)
2. Open browser console — verify no JavaScript errors
3. Check network tab — verify no failed requests (4xx, 5xx)
4. Verify the specific feature/change the user implemented

## Phase 3: Test Critical Flows

If the project has defined user flows, walk through them:

- Navigation between pages
- Form submissions
- Authentication flow (if applicable)
- Data loading and display
- Error states (disconnect network, invalid input)

## Phase 4: Visual Check

Describe the current state of the application:

1. What renders on the main page
2. Layout and responsiveness (check mobile/tablet/desktop)
3. Any visual issues (broken images, overflow, misalignment)
4. Dark mode (if supported)

## Phase 5: Report

Summarize findings:

```
Preview Report
==============
Server:    Next.js dev on http://localhost:3000
Status:    Running, no errors
Pages:     3/3 load successfully
Console:   Clean (no errors or warnings)
Feature:   [description of what was verified]
Issues:    [any problems found, or "None"]
```
