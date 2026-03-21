# Rules — Claude Code

## Language

Respond in: English
Write code comments in: English

## Project Context

<!-- CLI injects: project name, tools, stack -->

## Key Conventions

- Minimal, intentional changes — don't rewrite what works
- Conventional Commits: `feat:` / `fix:` / `docs:` / `refactor:` / `test:` / `chore:`
- TypeScript: strict mode, no `any`, explicit return types
- Search first (Grep/Glob), then read — never scan files sequentially
- Ask before: deleting files, installing deps, pushing code, destructive commands
- Never read or display `.env` contents

## Detailed Rules

Per-domain rules in `.claude/rules/` — loaded automatically when you work with matching files:

| Rule | Domain |
|------|--------|
| `core.md` | Working principles, no hallucination, ask before destruction |
| `code-generation.md` | Clean code, naming, imports, review format |
| `navigation.md` | Search order: Grep -> Glob -> Read -> LSP |
| `security.md` | OWASP Top 10, credentials, dependencies, API security |
| `boundaries.md` | What to ask about, what to just do, scope discipline |
| `mcp-tools.md` | MCP servers, Docker Gateway, context7, playwright |
| `git.md` | Conventional Commits, branch naming, safety |
| `performance.md` | Algorithmic, React, memory, network, database |
| `error-handling.md` | Try/catch patterns, custom errors, graceful degradation |
| `documentation.md` | Comments, README, ADR, doc locations |
| `typescript.md` | Strict mode, types vs interfaces, ESM, patterns |
| `python.md` | Type hints, modern Python, async, pytest |
| `react.md` | Hooks, state management, composition, patterns |
| `nextjs.md` | App Router, Server Components, data fetching |
| `tailwind.md` | Utility-first, responsive, dark mode |
| `testing.md` | AAA pattern, mocks, coverage, test types |
| `accessibility.md` | WCAG 2.1 AA, keyboard, screen readers, contrast |
| `api-design.md` | REST, status codes, validation, response format |
| `database.md` | Queries, migrations, schema, transactions |

## Skills (18 — `.claude/skills/`)

`adapt`, `animate`, `audit`, `bolder`, `clarify`, `colorize`, `critique`, `delight`, `distill`, `extract`, `frontend-design`, `harden`, `normalize`, `onboard`, `optimize`, `polish`, `quieter`, `teach-impeccable`

## Agent Orchestration (144+ specialists)

274 agents in `.claude/agents/`. Routing via orchestration skill (`.claude/skills/orchestration/SKILL.md`).

Invoke: `Agent` tool with `subagent_type`, e.g., `"Frontend Developer"`, `"Backend Architect"`, `"Security Engineer"`.

Key agents: Frontend Developer, Backend Architect, Software Architect, Security Engineer, DevOps Automator, Database Optimizer, AI Engineer, MCP Builder, Code Reviewer, API Tester, UX Architect, Technical Writer, Debugger, Codebase Explorer.

Full catalog: `docs/context/agency-agents-catalog.md`
Sync: `bash scripts/sync-agents.sh`

## Available Built-in Features

These Claude Code features work out of the box — no configuration needed:

- `/voice` — push-to-talk voice input (hold spacebar to speak)
- `/loop` — run recurring tasks on a schedule
- `/rewind` — restore to any checkpoint (undo edits)
- `/plan` — read-only analysis mode (explore -> plan -> code)
- `@file.ts#L10-20` — reference files with specific line ranges
- `isolation: "worktree"` — parallel agent work in isolated git worktrees
- `/compact` — compress conversation context when running low

## Documentation

- `docs/guides/` — references (debugging, MCP, agent workflows)
- `docs/decisions/` — architecture decision records (ADR)
- `docs/tasks/` — task tracking
- `docs/context/` — project context, notes, specs
