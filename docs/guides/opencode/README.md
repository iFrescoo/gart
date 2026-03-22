# OpenCode Guide

Configuration and capabilities for OpenCode in this project.

**Entry points:** `AGENTS.md` (instructions) + `opencode.json` (MCP config + plugins).

## Agent Workflows

### Available Agents (`.opencode/agents/`)

| Agent              | Role                                              | Invocation          |
| ------------------ | ------------------------------------------------- | ------------------- |
| `forge`            | Meta-agent — creates agents, skills, commands     | `/agent forge`      |
| `code-reviewer`    | Code review: quality, patterns, DRY, SOLID        | `@code-reviewer`    |
| `debugger`         | Debugging: error analysis, stack traces           | `@debugger`         |
| `git-agent`        | Git workflow: commits, branching, PR descriptions | `@git-agent`        |
| `test-runner`      | Tests: unit, integration, coverage                | `@test-runner`      |
| `refactor-agent`   | Refactoring: extraction, simplification           | `@refactor-agent`   |
| `security-auditor` | Security: OWASP, secrets, SQL injection           | `@security-auditor` |
| `dependency-agent` | Dependencies: updates, security                   | `@dependency-agent` |
| `docs-writer`      | Documentation: JSDoc, README, comments            | `@docs-writer`      |
| `explorer`         | Research: web search with citations               | `@explorer`         |
| `gh-search`        | GitHub code search                                | `@gh-search`        |

### Task Delegation

1. **Forge** delegates to subagents — does not perform work itself
2. A subagent receives a specific task and file scope
3. The subagent reports results back in chat
4. Forge integrates results and reports to the user

### Parallel Work

- Before editing a file — check if another agent is modifying it
- On edit conflicts — describe the problem and wait for user decision
- Git push — always after user approval

## Skills (`.opencode/skills/`)

### Workflow Skills (7)

| Skill                         | When to Use                   |
| ----------------------------- | ----------------------------- |
| `brainstorming`               | Before starting a new feature |
| `git-workflow`                | Commits, branching, PRs       |
| `lsp-navigator`               | Code navigation via LSP       |
| `mgrep-search`                | Semantic code search          |
| `subagent-driven-development` | Delegating tasks to subagents |
| `systematic-debugging`        | Structured debugging          |
| `writing-plans`               | Implementation planning       |

### Design Skills (18)

`adapt`, `animate`, `audit`, `bolder`, `clarify`, `colorize`, `critique`, `delight`, `distill`, `extract`, `frontend-design`, `harden`, `normalize`, `onboard`, `optimize`, `polish`, `quieter`, `teach-impeccable`

## MCP Configuration (`opencode.json`)

Pre-configured MCP servers via Docker Gateway. See [`../mcp-reference.md`](../mcp-reference.md) for the full server list.

Key servers:

| Server       | Description                                              |
| ------------ | -------------------------------------------------------- |
| `MCP_DOCKER` | Docker MCP Gateway — 316+ servers via single entry point |
| `github`     | GitHub API — issues, PRs, code search                    |
| `memory`     | Persistent knowledge graph                               |
| `playwright` | Browser automation                                       |

## LSP Tools

Set `OPENCODE_EXPERIMENTAL_LSP_TOOL=true` in `.env` to enable:

- `go-to-definition` — jump to symbol definition
- `find-references` — find all usages
- `hover` — inline type/doc information
- `get-diagnostics` — real-time type errors and linter warnings
