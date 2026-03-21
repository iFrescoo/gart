# Rules — AntiGravity IDE

## Language

Respond in: English
Write code comments in: English

## Key Conventions

- Minimal, intentional changes — do not rewrite what already works
- TypeScript: strict mode, no `any`, explicit return types for public functions
- Conventional Commits: `feat:` / `fix:` / `docs:` / `refactor:` / `test:` / `chore:`
- Clean code: small functions, readable names, no magic numbers
- Terminal: show commands before executing, indicate where to run (WSL, PowerShell, CMD)

## Detailed Rules

Per-domain rules in `.agent/rules/` — loaded automatically when working with matching files:

| Category       | Rules                                                                                                               |
| -------------- | ------------------------------------------------------------------------------------------------------------------- |
| **Base**       | core, code-generation, navigation, security, boundaries, mcp-tools, git, performance, error-handling, documentation |
| **Languages**  | typescript, python, css, html                                                                                       |
| **Frameworks** | react, nextjs, tailwind                                                                                             |
| **Testing**    | testing, e2e                                                                                                        |
| **API & DB**   | api-design, database                                                                                                |
| **DevOps**     | docker, ci-cd                                                                                                       |
| **Quality**    | accessibility, code-review                                                                                          |

## Skills, Workflows, and Agents

### Three Levels of Automation

1. **Rules** (`.agent/rules/`) — instructions per language/path, loaded automatically
2. **Skills** (`.agent/skills/`) — one-off actions invoked per task
3. **Workflows** (`.agent/workflows/`) — multi-step flows triggered via `/`

### Workflows (14)

| Workflow          | Trigger                                        |
| ----------------- | ---------------------------------------------- |
| `/orchestrate`    | Multi-agent task delegation                    |
| `/brainstorm`     | Structured ideation before implementation      |
| `/create`         | Scaffold new projects or features              |
| `/enhance`        | Route to optimize/harden/polish/distill skills |
| `/deploy`         | Production deployment with validation          |
| `/status`         | Project health dashboard                       |
| `/preview`        | Local preview and verification                 |
| `/code-review`    | Structured code review                         |
| `/testing`        | Test strategy and coverage                     |
| `/debugging`      | Systematic bug investigation                   |
| `/git-workflow`   | Branch, commit, PR workflow                    |
| `/security-audit` | OWASP + dependency security                    |
| `/pr-workflow`    | Create and manage pull requests                |
| `/github-release` | Version bump, tag, publish                     |

### Design Skills (18)

`adapt`, `animate`, `audit`, `bolder`, `clarify`, `colorize`, `critique`, `delight`, `distill`, `extract`, `frontend-design`, `harden`, `normalize`, `onboard`, `optimize`, `polish`, `quieter`, `teach-impeccable`

### Agent Orchestration (158 Specialists)

Orchestration workflow: `.agent/workflows/orchestrate.md` — activate when a task requires multiple specialists.

| Task             | Skill                     |
| ---------------- | ------------------------- |
| Frontend code    | agency-frontend-developer |
| Backend / API    | agency-backend-architect  |
| Architecture     | agency-software-architect |
| Security         | agency-security-engineer  |
| DevOps / CI      | agency-devops-automator   |
| Database         | agency-database-optimizer |
| AI/ML            | agency-ai-engineer        |
| Code review      | agency-code-reviewer      |
| API tests        | agency-api-tester         |
| UX design        | agency-ux-architect       |
| Documentation    | agency-technical-writer   |
| Code exploration | agency-codebase-explorer  |
| Debugging        | agency-debugger           |
| Dependencies     | agency-dependency-auditor |

Full catalog: `docs/context/agency-agents-catalog.md`
Sync: `bash scripts/sync-agents.sh`

## Available Built-in Features

- **Task Groups** — spawn parallel agents across workspaces via Agent Manager
- **Browser Subagent** — automated web browsing, clicking, screenshots, video recording
- **Artifacts** — task lists, implementation plans, walkthroughs, screenshots for verification
- **Strict Mode** — maximum security: all commands require approval, network denied, sandbox enabled
- **Terminal Sandboxing** — kernel-level workspace isolation for agent commands
- **Playground** — ephemeral sandbox workspaces for experiments
- **AGENTS.md** — cross-tool rules (shared with Cursor, Claude Code) if file exists in project root

## Recommended Security Settings

**Terminal Deny List** (always block): `rm -rf /`, `sudo`, `curl | sh`, `git push --force`, `DROP TABLE`

**Terminal Allow List** (safe to auto-approve): `npm test`, `npm run build`, `ls`, `git status`, `git diff`, `tsc --noEmit`

**Browser URL Allowlist**: Only trusted domains (localhost, your project domains, official docs). **Remove `webhook.site` from defaults** — known prompt injection vector.

**Strict Mode**: Recommended for production codebases and unfamiliar repos.

## Documentation

- `docs/guides/` — references (debugging, MCP, agent workflows)
- `docs/decisions/` — architectural decisions (ADR)
- `docs/tasks/` — tasks and tracking
- `docs/context/` — project context, notes, specs

## Project Context

<!-- TO BE FILLED: Agent fills this section after project initialization.
Format:
- Title:
- Description:
- Stack:
- Key dependencies:
- Notes: -->
