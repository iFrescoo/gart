# Rules — Claude Code

## Language

Respond in: English
Write code comments in: English

## 1. Working Rules

- **NEVER** generate an entire file for small changes — edit specific lines
- Before generating a long solution — write a plan in 2-3 sentences and ask: _"Should I go in this direction?"_
- Before deleting a file or executing a destructive command — **ask the user**
- Do not install dependencies without approval
- Do not hallucinate. If you don't know something: `"I don't know, I need more context about [X]"`
- There is no file lock system — work directly

---

## 2. Code Generation

- Minimal, intentional changes — do not rewrite what already works
- Check imports — do not add duplicates, do not leave unused ones
- `// BEFORE:` -> `// AFTER:` for critical logic changes
- Clean code: small functions, readable names, no magic numbers
- TypeScript: strict mode, no `any`, explicit return types for public functions
- Conventional Commits: `feat:` / `fix:` / `docs:` / `refactor:` / `test:` / `chore:`

---

## 3. Code Navigation

1. **Grep** — exact string/regex search across files
2. **Glob** — path patterns, folder structure
3. **Read** — when you already know which file
4. **LSP** — goToDefinition, findReferences, hover, documentSymbol, getDiagnostics (11 languages)

> FORBIDDEN: Do not read files one by one searching for something. First find via Grep, then read.

---

## 4. MCP Tools

| Server         | Role                                                       |
| -------------- | ---------------------------------------------------------- |
| `context-mode` | Context window protection — index large outputs in sandbox |
| `MCP_DOCKER`   | Docker MCP Gateway — full set of servers                   |

### MCP Docker — meta-tools (always available)

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

---

## 5. Skills, Subagents, and Automations

### Skills (18 — `.claude/skills/`)

Invoke via `Skill` tool:

`adapt`, `animate`, `audit`, `bolder`, `clarify`, `colorize`, `critique`, `delight`, `distill`, `extract`, `frontend-design`, `harden`, `normalize`, `onboard`, `optimize`, `polish`, `quieter`, `teach-impeccable`

### Built-in Subagents

| Subagent          | When to use                                                   |
| ----------------- | ------------------------------------------------------------- |
| `Explore`         | Quick codebase exploration (files, patterns, architecture)    |
| `Plan`            | Designing an implementation plan                              |
| `General-purpose` | Complex, multi-step tasks requiring autonomy                  |

### Plan Mode

Planning mode: `explore -> plan -> code`. Use for complex tasks — first investigate, plan, then implement.

### Hooks (`.claude/hooks/`)

Shell commands executed automatically in response to events (e.g., blocking dangerous commands). Configuration in `.claude/settings.json`.

### Scoped rules (`.claude/rules/`)

Instructions per language or path — loaded automatically when Claude works with matching files.

### Auto-memory

Automatic memorization of user patterns and preferences between sessions. Files in `~/.claude/projects/<project>/memory/`.

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
- N+1 queries to the database
- Unnecessary re-renders in React (missing memo/useMemo/useCallback)
- Memory leaks (uncleaned event listeners, timers, subscriptions)

**Code review — format:**

```
OK — [what is good]
Needs improvement — [file:line] -> [suggested fix]
Critical — [file:line] -> [suggested fix]
```

---

## 7. Boundaries

| Action                                 | Rule               |
| -------------------------------------- | ------------------ |
| File editing                           | No — just do it    |
| File deletion                          | YES — ask          |
| `rm -rf`, `DROP TABLE`, reset --hard   | YES — ask          |
| Installing new dependencies            | YES — ask          |
| Changing CI/CD / deployment config     | YES — ask          |
| Commit or push                         | Show what and ask  |
| Reading / printing `.env` contents     | Never              |

---

## 8. Project Initialization

When the PROJECT CONTEXT section is empty:

1. Check `package.json`, `requirements.txt`, `pyproject.toml`, `Dockerfile`, `.env.example` and folder structure
2. Infer the business purpose of the project
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

## 10. Agency Agents (144+ specialists)

Integrated 144+ agents from [agency-agents](https://github.com/msitarzewski/agency-agents). Available as `subagent_type` in Agent tool. Full list in `.claude/agents/`.

### Auto-dispatch (Claude Code has no tabs — uses LLM reasoning)

**Invocation:** `Agent` tool with `subagent_type`, e.g., `"Frontend Developer"`. Claude automatically selects an agent when:
1. The agent description contains a **trigger phrase**: `"USE THIS AGENT when: implementing code..."` — Claude matches it to the task
2. It uses the **orchestration skill** in `.claude/skills/orchestration/SKILL.md` — full routing table

**Orchestration skill** — loads the routing table and delegation patterns. Claude uses it when deciding whom to delegate to.

### Routing table (key agents)

| Task | subagent_type |
|---------|--------------|
| Frontend code (React, Vue) | `"Frontend Developer"` |
| Backend / API | `"Backend Architect"` |
| System architecture | `"Software Architect"` |
| Security review | `"Security Engineer"` |
| DevOps / CI/CD | `"DevOps Automator"` |
| Database | `"Database Optimizer"` |
| AI/ML | `"AI Engineer"` |
| MCP server | `"MCP Builder"` |
| Code review | `"Code Reviewer"` |
| API testing | `"API Tester"` |
| Performance | `"Performance Benchmarker"` |
| UX design | `"UX Architect"` |
| Documentation | `"Technical Writer"` |
| Code exploration | `"Codebase Explorer"` |
| GitHub examples | `"GitHub Code Searcher"` |
| Debugging | `"Debugger"` |
| npm dependencies | `"Dependency Auditor"` |
| Sprint planning | `"Sprint Prioritizer"` |
| Content | `"Content Creator"` |
| SEO | `"SEO Specialist"` |

### Local agents (project-specific)

| subagent_type | Role |
|---------------|------|
| `"Debugger"` | Root cause analysis, diagnosing errors |
| `"Test Runner"` | Running tests, analyzing results |
| `"Dependency Auditor"` | npm/bun audit |
| `"Codebase Explorer"` | Codebase exploration + websearch |
| `"GitHub Code Searcher"` | GitHub code search |

Full catalog: `docs/context/agency-agents-catalog.md`

Sync: `bash scripts/sync-agents.sh` (regenerates agents, trigger phrases, orchestration skill)

---

## Project Context

<!-- TO BE FILLED: The agent fills this section after project initialization.
Format:
- Title:
- Description:
- Stack:
- Key dependencies:
- Notes: -->
