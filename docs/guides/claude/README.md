# Claude Code Guide

Configuration and capabilities for Claude Code in this project.

**Entry point:** `CLAUDE.md` — project instructions, loaded automatically on every session.

## Agent Workflows

### Invoking Specialist Agents

Use the `Agent` tool with `subagent_type` to delegate to specialists:

| Agent                | Role                                 | Invocation                            |
| -------------------- | ------------------------------------ | ------------------------------------- |
| `Frontend Developer` | UI implementation, React, CSS        | `subagent_type: "Frontend Developer"` |
| `Backend Architect`  | APIs, databases, system design       | `subagent_type: "Backend Architect"`  |
| `Security Engineer`  | Threat modeling, secure code review  | `subagent_type: "Security Engineer"`  |
| `DevOps Automator`   | CI/CD, infrastructure, Docker        | `subagent_type: "DevOps Automator"`   |
| `AI Engineer`        | ML pipelines, model integration      | `subagent_type: "AI Engineer"`        |
| `MCP Builder`        | Custom MCP server development        | `subagent_type: "MCP Builder"`        |
| `Code Reviewer`      | Code quality, bugs, maintainability  | `subagent_type: "Code Reviewer"`      |
| `Debugger`           | Error analysis, root cause diagnosis | `subagent_type: "Debugger"`           |
| `Technical Writer`   | Docs, READMEs, API references        | `subagent_type: "Technical Writer"`   |

Full catalog: 274+ agents across Engineering, Design, Game Dev, Marketing, and Specialized divisions.

### Orchestration Patterns

- **Sequential:** Agent A completes → Agent B starts
- **Parallel:** Multiple agents in one message using `isolation: "worktree"` for isolated git worktrees
- **Delegation:** Orchestrator agent breaks task into subtasks → delegates to specialists

## Skills (18)

Located in `.claude/skills/`. Invoke with `/skill-name`:

| Category     | Skills                                                                 |
| ------------ | ---------------------------------------------------------------------- |
| Code quality | `critique`, `harden`, `optimize`, `polish`                             |
| UI/Design    | `adapt`, `animate`, `bolder`, `colorize`, `distill`, `frontend-design` |
| Content      | `clarify`, `quieter`, `extract`, `normalize`                           |
| Learning     | `teach-impeccable`, `onboard`, `delight`, `audit`                      |

## Hooks (11)

Located in `.claude/hooks/`. Run automatically on tool events:

| Hook                  | Trigger                | Purpose                                          |
| --------------------- | ---------------------- | ------------------------------------------------ |
| `protect-files.sh`    | PreToolUse: Edit/Write | Block sensitive file edits (`.env`, credentials) |
| `prevent-env-leak.sh` | PreToolUse: Read       | Block reading `.env` contents                    |
| `validate-commit.sh`  | PreToolUse: Bash       | Enforce Conventional Commits format              |
| `require-tests.sh`    | PostToolUse: Edit      | Remind to add tests after logic changes          |

## Rules (26)

Located in `.claude/rules/`. Auto-loaded based on file type:

| Rule file        | Domain                                                       |
| ---------------- | ------------------------------------------------------------ |
| `core.md`        | Working principles, no hallucination, ask before destruction |
| `security.md`    | OWASP Top 10, credentials, injection prevention              |
| `typescript.md`  | Strict mode, types, ESM patterns                             |
| `react.md`       | Hooks, state, composition                                    |
| `testing.md`     | AAA pattern, coverage, mocks                                 |
| `git.md`         | Conventional Commits, branch naming, safety                  |
| `performance.md` | Algorithmic, React, memory, network                          |
| `api-design.md`  | REST conventions, status codes, validation                   |

## MCP Servers

Pre-configured in `.mcp.json`:

| Server       | Tools | Description                                |
| ------------ | ----- | ------------------------------------------ |
| `github`     | 40+   | GitHub API — issues, PRs, code search      |
| `memory`     | 9     | Persistent knowledge graph across sessions |
| `playwright` | 22    | Browser automation for JS-rendered pages   |
