# Rules — AntiGravity IDE

## Language

Respond in: English
Write code comments in: English

---

## 1. Working Principles

- **NEVER** generate an entire file for small changes. Use `// ... rest of the code unchanged ...`
- Be **concise and specific** — no unnecessary filler
- Before generating a lengthy solution — write a plan in 2-3 sentences and ask: _"Should I go in this direction?"_
- Do not hallucinate. If you don't know something: `"I don't know, I need more context about [X]"`
- One specific question when you need clarification — not a list of five
- **Terminal:** Before executing a command — show it to the user. At the end, provide a ready list of steps (copy-paste ready) indicating where to run them: WSL, PowerShell, CMD, or project terminal.
- Destructive commands — **ALWAYS** ask for permission
- Do not install packages without explicit permission
- There is no file lock system — work directly

---

## 2. Code Generation

- Minimal, intentional changes — do not rewrite what already works
- Check imports — do not add duplicates, do not leave unused ones
- `// BEFORE:` -> `// AFTER:` for critical logic changes
- Clean code: small functions, readable names, no magic numbers
- SOLID — especially Single Responsibility and Dependency Inversion
- TypeScript: strict mode, no `any`, explicit return types for public functions
- Conventional Commits: `feat:` / `fix:` / `docs:` / `refactor:` / `test:` / `chore:`

---

## 3. Code Navigation

1. **`mgrep`** (MCP) — always use first. Semantic search: understands meaning, not just text. One query instead of reading 20 files. **Sees files in `.gitignore` that grep cannot see.**
2. **`lsp`** — go to definition, find references, call hierarchy. Use when you already know the symbol.
3. **`grep`** — exact string/regex. Note: does not see files in `.gitignore`.
4. **`glob`** / **`list`** — directory structure, path patterns.
5. **`read`** — read a file only when you already know which one and need to see its contents.

> PROHIBITED: Do not read files one by one searching for something. First find via mgrep/grep, then read.

---

## 4. MCP Tools

| Server         | Role                                                       |
| -------------- | ---------------------------------------------------------- |
| `mgrep`        | Semantic code search across the project                    |
| `context-mode` | Context window protection — index large outputs in sandbox |
| `gh_grep`      | GitHub code search (via `@gh-search`)                      |
| `MCP_DOCKER`   | Docker MCP Gateway — full set of servers                   |

> AntiGravity has a limit of 100 tools. Use `--servers` for filtering and `mcp-exec` instead of `mcp-add` for rarely used servers.

### MCP Docker — Meta-Tools (Always Available)

| Tool       | Description                                                  |
| ---------- | ------------------------------------------------------------ |
| `mcp-find` | Search the catalog of 316+ MCP servers by name/description   |
| `mcp-exec` | Invoke a tool from any server without adding it to the session |
| `mcp-add`  | Add a server to the current session                          |

### Useful Docker MCP Servers

- **context7** — library documentation (`resolve-library-id` -> `query-docs`). Use instead of hallucinating about APIs.
- **playwright** — browser automation when fetch is not enough (SPA, JS-rendered, Cloudflare)
- **github-official** — GitHub API (issues, PR, commits, code search)
- **memory** — memory between sessions (`memory_store` / `memory_retrieve`)
- **sequential-thinking** — step-by-step reasoning for complex problems
- **docker-hub** — Docker Hub: images, tags, versions

---

## 5. Skills and Agents

### Three Levels of AntiGravity Automation

1. **Rules** (`.agent/rules/`) — instructions per language/path, loaded automatically
2. **Skills** (`.agent/skills/`) — one-off actions invoked per task
3. **Workflows** (`.agent/workflows/`) — multi-step flows combining skills

### Workflow Skills (7 — `.opencode/skills/`)

`brainstorming`, `git-workflow`, `lsp-navigator`, `mgrep-search`, `subagent-driven-development`, `systematic-debugging`, `writing-plans`

### Impeccable Design Skills (18 — `.opencode/skills/` + `.claude/skills/`)

`adapt`, `animate`, `audit`, `bolder`, `clarify`, `colorize`, `critique`, `delight`, `distill`, `extract`, `frontend-design`, `harden`, `normalize`, `onboard`, `optimize`, `polish`, `quieter`, `teach-impeccable`

### Agents and Orchestration

**Orchestration workflow:** `.agent/workflows/orchestrate.md` — activate when a task requires multiple specialists.

| Skill | Role |
|-------|------|
| `agency-codebase-explorer` | Codebase exploration, research |
| `agency-github-code-searcher` | GitHub code search |
| `agency-debugger` | Error analysis, root cause |
| `agency-test-runner` | Running tests |
| `agency-dependency-auditor` | npm/bun audit |
| `agency-frontend-developer` | Frontend implementation |
| `agency-backend-architect` | Backend / API |
| `agency-software-architect` | System architecture |
| `agency-security-engineer` | Security review |
| `agency-code-reviewer` | Code review |
| `agency-technical-writer` | Documentation |
| `forge` | Creating agents/skills/commands (independent) |

---

## 6. Security and Quality

**Security — check proactively:**

- SQL Injection (queries without parameterization)
- XSS (innerHTML, dangerouslySetInnerHTML without sanitization)
- CSRF (missing tokens)
- Hardcoded credentials / API keys in code
- Sensitive data in logs or API responses
- `.env` files — never commit, never read contents aloud

**Performance — point out specifically:**

- O(n^2) loops where O(n) is possible
- N+1 database queries
- Unnecessary re-renders in React (missing memo/useMemo/useCallback)
- Memory leaks (uncleaned event listeners, timers, subscriptions)

**Code review — format:**

```
OK — [what is good]
Needs improvement — [file:line] -> [suggested fix]
Critical — [file:line] -> [suggested fix]
```

**Debugging:** Full protocol in `docs/guides/debugging.md` (6 steps: reproduce -> isolate -> inspect -> hypothesize -> fix -> prevent).

---

## 7. Boundaries

| Action                                 | Rule               |
| -------------------------------------- | ------------------ |
| File editing                           | No — just do it    |
| File deletion                          | YES — ask first    |
| `rm -rf`, `DROP TABLE`, reset --hard   | YES — ask first    |
| Installing new dependencies            | YES — ask first    |
| Changing CI/CD / deployment config     | YES — ask first    |
| Commit or push                         | Show what and ask  |
| Reading / printing `.env` contents     | Never              |

---

## 8. Project Initialization

When the PROJECT CONTEXT section is empty:

1. Check `package.json`, `requirements.txt`, `pyproject.toml`, `Dockerfile`, `.env.example` and the folder structure
2. Infer the business goal of the project
3. Write a report in chat: Title, Description, Stack, Key dependencies
4. Include a list of questions about missing information
5. Ask: _"Do you approve this description?"_
6. **Only after approval** — edit the Project Context section

---

## 9. Documentation

- `docs/guides/` — references (debugging, MCP, agent workflows)
- `docs/decisions/` — architectural decisions (ADR)
- `docs/tasks/` — tasks and tracking
- `docs/context/` — project context, notes, specs

---

## 10. Agency Agents — Orchestration (144+ Specialists)

Available as skills in `.agent/skills/agency-*/SKILL.md`. Orchestration workflow: `.agent/workflows/orchestrate.md`.

### When to Delegate to Specialists

Activate the `orchestrate` workflow when:
- The task requires expertise from multiple domains
- There are many independent subtasks (can run in parallel)
- The task has phases: research → implementation → review → tests

### Delegation Patterns

**Sequential:** `agency-software-architect → agency-backend-architect → agency-code-reviewer`

**Parallel:** `agency-frontend-developer + agency-backend-architect (simultaneously)`

**Research first:** `agency-codebase-explorer → agency-[specialist] → agency-reality-checker`

### Routing per Task Type

| Task | Activate skill |
|------|----------------|
| Frontend code | agency-frontend-developer |
| Backend / API | agency-backend-architect |
| Architecture | agency-software-architect |
| Security | agency-security-engineer |
| DevOps / CI | agency-devops-automator |
| Database | agency-database-optimizer |
| AI/ML | agency-ai-engineer |
| Code review | agency-code-reviewer |
| API tests | agency-api-tester |
| UX design | agency-ux-architect |
| Documentation | agency-technical-writer |
| Code exploration | agency-codebase-explorer |
| Debugging | agency-debugger |
| Dependencies | agency-dependency-auditor |

Full catalog: `docs/context/agency-agents-catalog.md`

Sync: `bash scripts/sync-agents.sh` (regenerates workflow, routing table)

---

## Project Context

<!-- TO BE FILLED: Agent fills this section after project initialization.
Format:
- Title:
- Description:
- Stack:
- Key dependencies:
- Notes: -->
