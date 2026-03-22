# Template Development Guide

> This folder exists only in the template repository. If you see it — you are working on template development, because cloned projects do not have this folder (excluded by `.gitignore` via `docs-dev/`).

---

## What does NOT apply to you here

- `AGENTS.md` — those rules are for agents *using* the template in target projects
- `CLAUDE.md` / `GEMINI.md` — same
- Boot sequence, registry registration, file locking — no active lock system in this repo

## What DOES apply

- Ask before deleting a file or running a destructive command
- When changing an agent `.md`, check `forge.md` (contains agent catalog + templates)
- Document decisions in [`architecture/decisions.md`](architecture/decisions.md)
- Update [`tasks/kanban.md`](tasks/kanban.md)

## Tools and targets

Tools: `edit`, `read`, `bash` (ask first for destructive), `glob`, `grep`, `skill`

Targets: `.opencode/agents/`, `.opencode/skills/`, `.claude/skills/`, `.agent/skills/`, `opencode.json`, `.mcp.json`, `docs/`

## Project Structure

```
├── .opencode/
│   ├── agents/         11 agents (forge + 10 subagents)
│   ├── skills/         25 skills (7 workflow + 18 design)
│   └── commands/       commands (git-push, new-agent, review)
├── .claude/
│   ├── agents/         274+ agents (synced from upstream via gart.sh sync)
│   ├── skills/         18 impeccable design skills
│   ├── hooks/          hook scripts (protect-files, validate-commit, etc.)
│   ├── rules/          26 scoped rules (per language/path)
│   └── settings.json   hooks config
├── .agent/
│   ├── skills/         AntiGravity workspace skills
│   └── workflows/      AntiGravity workflows
├── .gart/
│   ├── agents/         local agent templates (5 files — source for sync)
│   └── upstream/       sync cache (git clone of agency-agents, gitignored)
├── AGENTS.md           global rules (OpenCode)
├── CLAUDE.md           instructions (Claude Code)
├── GEMINI.md           instructions (AntiGravity)
├── opencode.json       config: model, MCP, LSP, permissions
├── .mcp.json           MCP config (Claude Code)
├── scripts/
│   ├── gart.sh         unified entry: validate | sync | doctor
│   └── lib/            underlying scripts (validate.sh, sync-agents.sh)
├── cli/                CLI source (gart-build npm package — not copied to projects)
├── docs/               user-facing documentation (copied to projects)
│   ├── guides/         references (debugging, MCP, agent workflows)
│   ├── decisions/      ADRs (empty at clone time)
│   ├── tasks/          task tracking (empty at clone time)
│   └── context/        project context (empty at clone time)
└── docs-dev/           ← THIS FOLDER (template dev only, not copied by npx)
    ├── architecture/   system design, decisions, research
    ├── setup/          IDE setup, plugin catalog
    └── tasks/          kanban, audit templates
```

## Conventions

- Agents: YAML frontmatter + markdown body in `.opencode/agents/`
- Skills: `SKILL.md` in a `skill-name/` folder inside `skills/`
- Commands: markdown with frontmatter in `.opencode/commands/`
- Decisions: ADR-NNN in [`architecture/decisions.md`](architecture/decisions.md)
- Tasks: kanban in [`tasks/kanban.md`](tasks/kanban.md)

---

## IDE — Environment Overview

The project runs in three environments. Each has a different model, different constraints, and a different MCP set.

---

## OpenCode (CLI — Gemini)

**Config file:** `opencode.json`
**Context instructions:** `AGENTS.md`

### Model

`gemini-3.1-pro-preview-customtools` with thinkingBudget variants: `high` / `low`.

### MCP servers

| Server | Type | Description |
|--------|------|-------------|
| `context-mode` | local | Context window protection — indexes large outputs in sandbox |
| `MCP_DOCKER` | local | Docker MCP Gateway — full server set (see MCP section) |
| `mgrep` | local | Semantic code search, 10s timeout |
| `gh_grep` | remote | GitHub code search — **disabled globally**, available only via `@gh-search` agent |

### Permissions (opencode.json)

- `bash`: default `ask`, selected git/grep/ls/cat/npm — `allow`, `git push` and `rm -rf` — `deny`
- `edit` / `read` / `glob` / `grep` / `lsp`: `allow`
- `webfetch`: `deny` (replaced by Docker MCP `fetch` and `playwright`)
- `websearch`: `ask`
- `*.env` / `*.env.*`: `deny` for reading

### Available skills

- **Workflow (7):** `brainstorming`, `git-workflow`, `lsp-navigator`, `mgrep-search`, `subagent-driven-development`, `systematic-debugging`, `writing-plans`
- **Design (18):** `adapt`, `animate`, `audit`, `bolder`, `clarify`, `colorize`, `critique`, `delight`, `distill`, `extract`, `frontend-design`, `harden`, `normalize`, `onboard`, `optimize`, `polish`, `quieter`, `teach-impeccable`

### Agents (`.opencode/agents/`)

11 agents loaded into session: `forge` (primary), `code-reviewer`, `debugger`, `git-agent`, `test-runner`, `refactor-agent`, `security-auditor`, `dependency-agent`, `docs-writer`, `explorer`, `gh-search`.

### LSP

TypeScript Language Server (`npx typescript-language-server --stdio`) with `importModuleSpecifierPreference: relative`.

### Notes

- `plugin:` works **ONLY** in global config `~/.config/opencode/opencode.json` — never add to `opencode.json` in the project
- API key for MCP `ref` in `opencode.json` — **do not commit** to a public repo
- `gh_grep` is disabled for all agents except `gh-search` — protection against excessive use

---

## AntiGravity IDE (Gemini — subscription)

**Config file:** `~/.gemini/antigravity/mcp_config.json` (outside repository)
**Context instructions:** `GEMINI.md`

### Model

`gemini-3.1-pro-preview-customtools` (Gemini subscription — separate token pool from OpenCode).

### MCP servers

AntiGravity has a **100 active tool limit**. Docker MCP Gateway launched with `--servers` flag (filters to 8 servers, ~88 tools):

| Docker MCP Server | Tools | Role |
|-------------------|-------|------|
| `github-official` | 41+2p+5r | GitHub API: issues, PRs, commits, code search |
| `filesystem` | 11 | File and directory operations |
| `git` | 12 | Git — log, diff, blame, status |
| `context7` | 2 | Live library documentation |
| `fetch` | 1+1p | Fetching pages, markdown conversion |
| `ast-grep` | 1 | AST-based code search (structural patterns) |
| `markdownify` | 11 | File/URL to markdown conversion |
| `memory` | 9 | Persistent memory between sessions |

**Not available in AntiGravity** (too many tools): Playwright, Docker Hub, npm-sentinel, semgrep, wolfram-alpha, hugging-face, paper-search.

### Limitations

- Max **100 tools** active at once — when adding a new server, check the balance
- Playwright and Docker Hub exceed the limit — available via `mcp-exec` (Dynamic MCP)
- `mgrep` and `gh_grep` unavailable — search via `ast-grep` or GitHub API

### Available skills

- All 25 skills from `.opencode/skills/` (workflow + design)
- Additionally `.agent/skills/` and `.agent/workflows/` (AntiGravity-specific)

### Notes

- `--verify-signatures` enabled — verification of Docker image signatures on startup
- Full env var paths (LOCALAPPDATA, APPDATA, USERPROFILE, SystemRoot, ProgramData, ProgramFiles) required on Windows in IDE config files, but **NOT** in `opencode.json` — OpenCode does not support the `env` field in MCP

---

## Claude Code (CLI + VS Code extension)

**Config file:** `~/.claude.json` (user scope MCP), `~/.claude/settings.json` (plugins, hooks)
**Context instructions:** `CLAUDE.md`

### Models

| Model | ID | When |
|-------|----|------|
| Sonnet (default) | `claude-sonnet-4-6` | Daily tasks |
| Opus | `claude-opus-4-6` | Complex planning, architecture |

### MCP servers (user scope — `~/.claude.json`)

| Server | Description |
|--------|-------------|
| `MCP_DOCKER` | Docker MCP Gateway — full server set |
| `mgrep` | Semantic code search |

### MCP servers (plugins — `~/.claude/settings.json`)

| Server | Description |
|--------|-------------|
| `plugin:context-mode:context-mode` | Context window protection |
| `plugin:context7:context7` | Library documentation |
| `claude.ai Context7` | Context7 via claude.ai connector |

### MCP scopes

Claude Code has **3 MCP scopes** — important when adding new servers:

| Scope | File | Reach |
|-------|------|-------|
| `local` (default) | `~/.claude.json` → per project | Current project only |
| `project` | `.mcp.json` in project directory | Everyone in project (git) |
| `user` | `~/.claude.json` → `mcpServers` | All projects |

Adding a global server: `claude mcp add --scope user <name> -- <command>`
**Do not edit `~/.claude.json` manually** — use `claude mcp add/remove`.

### Available skills (`.claude/skills/`)

18 Impeccable Design Skills invoked via the `Skill` tool:
`adapt`, `animate`, `audit`, `bolder`, `clarify`, `colorize`, `critique`, `delight`, `distill`, `extract`, `frontend-design`, `harden`, `normalize`, `onboard`, `optimize`, `polish`, `quieter`, `teach-impeccable`

### Hooks (`.claude/hooks/`)

- `protect-files.sh` — blocks edits to `.env.*` files (except `.env.example`), credential files
- `prevent-env-leak.sh` — blocks reading `.env` contents
- `validate-commit.sh` — enforces Conventional Commits format
- `require-tests.sh` — reminds to add tests after logic changes

### Notes

- `plugin:` loads automatically from marketplace — no manual configuration needed
- `MCP_TIMEOUT=60000` set as Windows environment variable (Docker gateway needs >30s)
- Full path to `docker-mcp.exe` required (not `docker` — IDE doesn't have Docker in PATH)

---

## MCP — Docker Gateway

Central gateway connecting all 3 IDEs to the MCP ecosystem.

**Command:** `C:\Program Files\Docker\cli-plugins\docker-mcp.exe gateway run --verify-signatures`

### Active servers (Claude Code / OpenCode — full set)

| Server | Tools | Description |
|--------|-------|-------------|
| `ast-grep` | 1 | AST-based structural code search |
| `context7` | 2 | Live library documentation |
| `docker-hub` | 13 | Docker Hub — images, tags, versions |
| `fetch` | 1+1p | Page fetching, web scraping |
| `filesystem` | 11 | File operations |
| `git` | 12 | Git operations |
| `github-official` | 41+2p+5r | GitHub API |
| `hugging-face` | 10+4p | Hugging Face hub |
| `markdownify` | 11 | Markdown conversion |
| `memory` | 9 | Persistent memory (knowledge graph) |
| `npm-sentinel` | 19+2r | NPM package analysis |
| `paper-search` | 8 | Academic paper search |
| `playwright` | 22 | Browser automation (headless) |
| `semgrep` | — | SAST — code security scanning |
| `sequentialthinking` | 1 | Structured step-by-step reasoning |
| `sqlite-mcp-server` | — | SQLite operations |
| `wolfram-alpha` | — | Mathematical computation |

### Dynamic MCP (meta-tools)

| Tool | Description |
|------|-------------|
| `mcp-find` | Search 316+ server catalog by name/description |
| `mcp-exec` | Call a tool from any server **without** adding to session |
| `mcp-add` | Add a server to current session |
| `mcp-remove` | Remove server from session |
| `mcp-config-set` | Set a server configuration value |

`mcp-exec` — critical for AntiGravity (bypasses 100-tool limit).

### Gateway flags

| Flag | Status | Description |
|------|--------|-------------|
| `--verify-signatures` | all IDEs | Verifies Docker image signatures and attestations |
| `--servers <name>` | AntiGravity | Filters servers — reduces tool count |
| `--log-calls` | default on | Audit log of tool calls |

---

## Release — How to Publish a New Version

### Process (step by step)

```bash
# 1. Make sure you're on main and it's clean
git status
git branch                    # * main

# 2. Typecheck + build
cd cli
npm run typecheck
npm run build                 # creates cli/dist/

# 3. Commit + push all changes to main
git add <files>
git commit -m "feat: description"
git push origin main

# 4. Bump version (from cli/ directory)
npm version patch             # patch: 1.1.1 → 1.1.2
                              # minor: 1.1.2 → 1.2.0
                              # major: 1.2.0 → 2.0.0

# 5. Push commit and tag
cd ..
git push origin main
git push origin v1.x.x        # triggers CI
```

### What CI does automatically

Push of a `v*` tag triggers:
1. `npm ci` — install dependencies
2. `npm run typecheck` — type checking
3. `npm run build` — compilation
4. `npm publish --provenance` — publish to npm
5. `gh release create` — GitHub Release with auto-generated notes

### Required secrets

| Secret | Description |
|--------|-------------|
| `NPM_TOKEN` | npm token with publish permissions for `gart-build` |
| `GITHUB_TOKEN` | Automatic — no configuration required |

### Troubleshooting

| Problem | Solution |
|---------|---------|
| `git push --tags` → "Everything up-to-date" | Use `git push origin v<version>` explicitly |
| CI fails on npm publish | Check that `NPM_TOKEN` is set in repo secrets |
| `npm version` does not create tag | Check `git tag -l` — tag should be `v1.x.x` |
| Want to undo a tag | `git tag -d v1.1.2 && git push origin :refs/tags/v1.1.2` |

### Versioning conventions

- **patch** (`x.x.X`) — bug fixes, small improvements, new rules/agents
- **minor** (`x.X.0`) — new CLI features (new wizard question, new platform)
- **major** (`X.0.0`) — breaking changes (file structure change, platform removal)

---

## Known Issues and Solutions

| Problem | Solution |
|---------|---------|
| "Failed to connect" in IDE | Use `docker-mcp.exe` (not `docker`), add Windows env vars |
| Timeout >30s | Set `MCP_TIMEOUT=60000` as Windows user environment variable |
| AntiGravity: "162 tools exceeds limit" | Use `--servers` to filter; `mcp-exec` for rarely-used servers |
| Server crashes with EOF | Check required API keys in Docker Desktop → Configure |
