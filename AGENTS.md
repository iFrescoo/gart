# Rules — OpenCode

## Language

Respond in: English
Write code comments in: English

You are an advanced AI assistant. Your goal is maximum efficiency and accuracy while working **in parallel with other agents**.

---

## 1. Working Principles

- **NEVER** generate an entire file for small changes. Use `// ... rest of the code unchanged ...`
- **Plain language:** Explain briefly — **What** you changed and **What it does**. Deeper explanations only on request.
- Before generating a long solution — write a plan in 2-3 sentences and ask: _"Should I go in this direction?"_
- Do not hallucinate. If you don't know something: `"I don't know, I need more context about [X]"`
- Before deleting a file or executing a destructive command — **ask the user**
- Do not install dependencies without approval
- There is no file lock system — work directly
- `question` tool — use it for interactive questions instead of listing them in prose
- `todowrite` / `todoread` — track steps for complex tasks

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

1. **`mgrep`** (MCP) — always use first. Semantic search: understands meaning, not just text. One query instead of reading 20 files. **Sees files in `.gitignore` that grep cannot see.**
2. **`lsp`** — when you already know the symbol: definition, references, call hierarchy. Requires `OPENCODE_EXPERIMENTAL_LSP_TOOL=true`.
3. **`grep`** — exact string/regex. Respects `.gitignore` — will not find code in `node_modules/`, `dist/`.
4. **`glob`** / **`list`** — path patterns, directory structure. Also respects `.gitignore`.
5. **`read`** — when you already know which file and need to see its contents.
6. **`@gh-search`** (subagent) — GitHub code search via gh_grep. Implementation examples, patterns. `gh_grep*` tools are disabled globally — access only through this agent.

> FORBIDDEN: Do not read files one by one searching for something. First find via mgrep, then read.

---

## 4. MCP Tools

| Server         | Role                                                       |
| -------------- | ---------------------------------------------------------- |
| `context-mode` | Context window protection — index large outputs in sandbox |
| `mgrep`        | Semantic code search across the project                    |
| `gh_grep`      | GitHub code search (via `@gh-search`)                      |
| `MCP_DOCKER`   | Docker MCP Gateway — full set of servers                   |

### MCP Docker — Meta-tools (always available)

| Tool       | Description                                                  |
| ---------- | ------------------------------------------------------------ |
| `mcp-find` | Search the catalog of 316+ MCP servers by name/description   |
| `mcp-exec` | Call a tool from any server without adding it to the session  |
| `mcp-add`  | Add a server to the current session                          |

Example: `mcp-find "npm sentinel"` -> `mcp-exec "npmLatest" {name: "react"}`

### Useful Docker MCP Servers

- **context7** — library documentation (`resolve-library-id` -> `query-docs`). Use instead of hallucinating about APIs.
- **playwright** — browser automation when fetch is not enough (SPA, JS-rendered, Cloudflare)
- **github-official** — GitHub API (issues, PR, commits, code search)
- **memory** — memory between sessions (`memory_store` / `memory_retrieve`)
- **sequential-thinking** — step-by-step reasoning for complex problems
- **docker-hub** — Docker Hub: images, tags, versions

---

## 5. Skills and Agents

### Workflow Skills (7 — `.opencode/skills/`)

`brainstorming`, `git-workflow`, `lsp-navigator`, `mgrep-search`, `subagent-driven-development`, `systematic-debugging`, `writing-plans`

### Impeccable Design Skills (18 — `.opencode/skills/` + `.claude/skills/`)

`adapt`, `animate`, `audit`, `bolder`, `clarify`, `colorize`, `critique`, `delight`, `distill`, `extract`, `frontend-design`, `harden`, `normalize`, `onboard`, `optimize`, `polish`, `quieter`, `teach-impeccable`

### Orchestration Architecture (`.opencode/agents/`)

#### Primary agents (tabs in OpenCode)

| Agent | Role | Invocation |
|-------|------|------------|
| `orchestrator` | CTO-level — analyzes task, delegates to ALL 144+ agents | `@orchestrator` |
| `team-engineering` | Division lead: ~35 eng specialists + local agents | `@team-engineering` |
| `team-design` | Division lead: ~10 design specialists | `@team-design` |
| `team-qa` | Division lead: ~8 QA specialists + test-runner | `@team-qa` |
| `team-product` | Division lead: ~5 product specialists | `@team-product` |
| `team-project-mgmt` | Division lead: ~6 project mgmt specialists | `@team-project-mgmt` |
| `team-marketing` | Division lead: ~20 marketing specialists | `@team-marketing` |
| `team-sales` | Division lead: ~10 sales specialists | `@team-sales` |
| `team-paid-media` | Division lead: ~7 paid media specialists | `@team-paid-media` |
| `team-game-dev` | Division lead: ~19 game dev specialists | `@team-game-dev` |
| `team-spatial` | Division lead: ~5 spatial computing specialists | `@team-spatial` |
| `team-specialized` | Division lead: ~20 specialized+support+integrations | `@team-specialized` |
| `forge` | Meta-agent — INDEPENDENT from orchestration, creates agents/skills/commands | `@forge` |

#### Local agents (project-specific, `scripts/local-agents/`)

| Agent | Role | Invocation |
|-------|------|------------|
| `agency-debugger` | Error analysis, root-cause diagnosis (read-only) | `@agency-debugger` |
| `agency-test-runner` | Running tests + result analysis | `@agency-test-runner` |
| `agency-dependency-auditor` | npm/bun audit, outdated, dependency security | `@agency-dependency-auditor` |
| `agency-codebase-explorer` | Codebase exploration + web search | `@agency-codebase-explorer` |
| `agency-github-code-searcher` | GitHub code search (gh_grep) | `@agency-github-code-searcher` |

Agents replaced by agency-agents:

| Old agent | Use instead |
|-----------|-------------|
| `debugger`, `explorer`, `gh-search` | `@agency-debugger`, `@agency-codebase-explorer`, `@agency-github-code-searcher` |
| `code-reviewer` | `@agency-code-reviewer` |
| `git-agent` | `@agency-git-workflow-master` |
| `security-auditor` | `@agency-security-engineer` |
| `docs-writer` | `@agency-technical-writer` |

### Parallel Work

- Before editing a file — check if another agent is modifying it
- On edit conflict — describe the problem and wait for the user's decision
- Git push — always via `/git-push [branch]` or after approval

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
- Memory leaks (uncleared event listeners, timers, subscriptions)

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
| File deletion                          | YES — ask first    |
| `rm -rf`, `DROP TABLE`, reset --hard   | YES — ask first    |
| Installing new dependencies            | YES — ask first    |
| Changing CI/CD / deployment config     | YES — ask first    |
| Commit or push                         | Show what and ask  |
| Reading / displaying `.env` contents   | Never              |

---

## 8. Project Initialization

When the PROJECT CONTEXT section is empty:

1. Run `/init` — OpenCode will automatically scan the project and suggest content
2. If `/init` is unavailable: check `package.json`, `requirements.txt`, `pyproject.toml`, `Dockerfile`, `.env.example` and directory structure
3. Infer the business purpose of the project
4. **Do NOT edit** `AGENTS.md` right away
5. Write a report in chat: Title, Description, Stack, Key dependencies
6. Include a list of questions about missing information
7. Ask: _"Do you approve this description?"_
8. **Only after approval** — edit the Project Context section

---

## 9. Documentation

- `docs/guides/` — references (debugging, MCP, agent workflows)
- `docs/decisions/` — architectural decisions (ADR)
- `docs/tasks/` — tasks and tracking
- `docs/context/` — project context, notes, specs

---

## 10. Agency Agents — Orchestration (144+ specialists)

### Architecture

```
[Orchestrator]  [team-engineering]  [team-design]  [team-qa]  ...  [Forge]
  (CTO-level)      (div. lead)        (div. lead)   (div. lead)   (independent)
       |                |                  |
   ALL agents      eng agents +       design agents
                  debugger, explorer
```

**Orchestrator** — analyzes the task CTO-style and delegates to team-* or directly to @agency-*. Invocation: `@orchestrator`.

**Team-* agents** — division leads who know ONLY their own agents. Invocation: `@team-engineering`, `@team-design`, etc.

**Forge** — independent meta-agent for creating new agents/skills/commands. NOT subject to orchestration.

### Delegation Patterns

**Sequential:** `@agency-software-architect → @agency-backend-architect → @agency-code-reviewer → @agency-api-tester`

**Parallel:** `@agency-frontend-developer + @agency-backend-architect (simultaneously)`

**Research first:** `@agency-codebase-explorer → @agency-[specialist] → @agency-reality-checker`

### Divisions

| Team agent | Division | Example agents |
|------------|----------|----------------|
| @team-engineering | Engineering | Frontend Developer, Backend Arch, Software Arch, Security Eng, DevOps, AI Engineer |
| @team-design | Design | UX Architect, UI Designer, Brand Guardian, Accessibility Auditor |
| @team-qa | QA/Testing | API Tester, Performance Benchmarker, Reality Checker |
| @team-product | Product | Sprint Prioritizer, Feedback Synthesizer, Trend Researcher |
| @team-project-mgmt | Project Mgmt | Project Shepherd, Studio Producer, Senior PM |
| @team-marketing | Marketing | SEO Specialist, Content Creator, Growth Hacker |
| @team-sales | Sales | Deal Strategist, Sales Engineer, Pipeline Analyst |
| @team-paid-media | Paid Media | PPC Strategist, Paid Social Strategist, Ad Creative |
| @team-game-dev | Game Dev | Unity Architect, Unreal Eng, Godot Scripter, Game Designer |
| @team-spatial | Spatial | visionOS Spatial Eng, XR Developer, XR Interface Arch |
| @team-specialized | Specialized+Support | MCP Builder, AI Engineer, Technical Writer |

Full catalog: `docs/context/agency-agents-catalog.md`

Sync: `bash scripts/sync-agents.sh` (fetches latest version + regenerates team-* and orchestrator)

---

## Project Context

<!-- TO BE FILLED: Agent fills these sections after project initialization.
Format:
- Title:
- Description:
- Stack:
- Key dependencies:
- Notes: -->
