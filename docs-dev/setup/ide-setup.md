# IDE Setup — Plugins and Configuration

Guide for developers cloning this template. Describes required and recommended plugins for each IDE and their configuration.

---

## General Requirements

| Tool | Version | Installation |
|------|---------|-------------|
| Node.js | >= 18.0.0 | https://nodejs.org |
| npm | >= 9.0.0 | bundled with Node |
| bun | >= 1.0.0 | `npm install -g bun` |
| Docker Desktop | latest | https://docker.com/products/docker-desktop |

---

## Claude Code

### Installation

```bash
npm install -g @anthropic-ai/claude-code
```

### Claude Code Plugins (installed)

| Plugin | What it does |
|--------|-------------|
| `context-mode` | Context window protection — indexes large outputs in sandbox, prevents context overflow |
| `impeccable` | 18 UX/UI/design skills (adapt, animate, audit, bolder, clarify...) |
| `superpowers` | Workflow skills (brainstorming, debugging, git, plans, TDD, code review) |
| `hookify` | Hook creation — blocking dangerous commands, automation |
| `claude-md-management` | CLAUDE.md management — audit, update, improve |
| `code-review` | Code review PR via subagent |
| `feature-dev` | Feature development with codebase analysis |
| `commit-commands` | Commit, push, PR in one command |
| `claude-code-setup` | Automation recommendations (hooks, subagents, skills, MCP) |
| `huggingface-skills` | Hugging Face Hub integration (models, datasets, jobs) |

### Hooks (`.claude/hooks/`)

- `protect-files.sh` — blocks edits to `.env.*` files (except `.env.example`), credential files
- `prevent-env-leak.sh` — blocks reading `.env` contents
- `validate-commit.sh` — enforces Conventional Commits format
- `require-tests.sh` — reminds to add tests after logic changes

### Scoped rules (`.claude/rules/`)

26 per-language/per-path instruction files — auto-loaded based on the file being edited.

---

## OpenCode

### Installation

```bash
npm install -g opencode-ai
# or: bun install -g opencode-ai
```

### Configuration

`opencode.json` in project root — model, MCP servers, permissions, skills.

### Agents (`.opencode/agents/`)

11 agents: `forge` (meta), `code-reviewer`, `debugger`, `git-agent`, `test-runner`, `refactor-agent`, `security-auditor`, `dependency-agent`, `docs-writer`, `explorer`, `gh-search`

### Skills (`.opencode/skills/`)

25 skills: 7 workflow + 18 Impeccable Design

### Plugin installation

```bash
cd .opencode && bun install
```

Installs `@opencode-ai/plugin` — required for agents and skills to work.

> **Note:** `plugin:` in `opencode.json` is ignored. Plugins only work in global config `~/.config/opencode/opencode.json`.

---

## AntiGravity IDE

### Installed plugins (in this project)

| Plugin | What it does | Why we use it |
|--------|-------------|--------------|
| `context-mode` | Context window protection | Prevents context overflow with large outputs |
| MCP Docker Gateway | 316+ MCP servers | GitHub API, Playwright, Memory, SQLite, paper search... |

### Skills configuration

```
Settings -> Skill Custom Paths -> add: .opencode/skills
```

This gives AntiGravity access to all 25 skills from `.opencode/skills/`.

### Three automation levels

1. **Rules** (`.agent/rules/`) — per-language/per-path instructions
2. **Skills** (`.agent/skills/`) — single-step actions
3. **Workflows** (`.agent/workflows/`) — multi-step automated flows

---

## MCP Docker Gateway

All 3 IDEs use Docker MCP Gateway as a central hub.

### Required API keys (`.env`)

```env
GITHUB_PERSONAL_ACCESS_TOKEN=  # repo scope
REF_API_KEY=                   # ref.tools (optional)
OPENCODE_EXPERIMENTAL_LSP_TOOL=true
```

### Key servers

| Server | Function |
|--------|---------|
| `github-official` | GitHub API — issues, PRs, code search |
| `memory` | Persistent agent memory (JSONL knowledge graph) |
| `playwright` | Browser automation — SPA, screenshots |
| `context7` | Current library documentation |
| `sqlite-mcp-server` | SQL queries on project databases |
| `sequential-thinking` | Step-by-step structured reasoning |

Full catalog: `docs/guides/mcp-reference.md`

---

## VS Code / Cursor

### Recommended settings

File `.vscode/settings.json` contains:
- `editor.formatOnSave: true`
- `tabSize: 2`, `insertSpaces: true`
- `files.trimTrailingWhitespace`, `files.insertFinalNewline`
- `typescript.preferences.importModuleSpecifier: "relative"`
- `organizeImports` on save

### Recommended VS Code extensions

| Extension | ID | Purpose |
|-----------|-----|---------|
| Claude Code | `anthropic.claude-code` | Official Claude Code VS Code integration |
| Prettier | `esbenp.prettier-vscode` | Code formatting |
| ESLint | `dbaeumer.vscode-eslint` | Linting |
| GitLens | `eamodio.gitlens` | Git blame, history, diff |
| Error Lens | `usernamehw.errorlens` | Inline errors in editor |
| Pretty TypeScript Errors | `yoavbls.pretty-ts-errors` | Readable TypeScript errors |
