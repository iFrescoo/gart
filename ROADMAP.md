# GART Roadmap

## Planned

- [ ] VS Code `extensions.json` — recommend Claude Code extension on project open
- [ ] JetBrains plugin configuration guide
- [ ] `gart sync` command — update agents to latest version without full re-scaffold
- [ ] `gart update` command — update GART CLI itself to latest version
- [ ] `gart doctor` command — diagnose project setup issues (missing deps, broken hooks, MCP connectivity)
- [ ] Division-based scoped rules — auto-generated rules per agent division (engineering, design, marketing) via `sync-agents.sh`

## Considered

- [ ] Agent SDK examples/templates — programmatic agent building (JS/TS)
- [ ] Custom MCP server template — starter boilerplate for building own MCP servers
- [ ] Slack/Discord notification hooks — team alerts when Claude needs attention or finishes long tasks
- [ ] TTS (text-to-speech) notification hooks — audio alerts on task completion
- [ ] Session context loader hook (SessionStart) — auto-load git status, open issues, recent commits on every session start
- [ ] Pre-compact transcript backup hook — save full conversation before context compression
- [ ] License compliance hook — check new dependencies against approved license list (MIT, Apache-2.0, BSD)
- [ ] Auto-test hook (PostToolUse) — run test suite after code changes
- [ ] Project template variants — pre-configured templates for common stacks (Next.js, FastAPI, etc.)

## Rejected (with reasons)

- **Agent SDK examples** — too complex for a scaffold template, SDK API changes frequently, 95% of users don't need programmatic agent building
- **Git worktree scaffolding** — built-in Claude Code feature, no project-level configuration needed
- **Checkpointing configuration** — built-in feature, works automatically
- **Voice mode configuration** — built-in feature, activated via `/voice` command
- **`/loop` configuration** — built-in feature, no config files involved
