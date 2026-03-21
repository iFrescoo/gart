# GART Roadmap

## Planned

- [x] Gitignore opcja podczas instalacji npx gart-build. Uzytkownik wprowadzajc to do projektu pewnie nie chce aby mu sie dodalo to wszytsko do repozytorium. Powinna byc opcja podczas instalacji "czy chcesz dodac to do gitignore?" z opcjami Tak/Nie".
- [ ] VS Code `extensions.json` — recommend Claude Code extension on project open
- [ ] JetBrains plugin configuration guide
- [ ] `gart sync` command — update agents to latest version without full re-scaffold
- [ ] `gart update` command — update GART CLI itself to latest version
- [ ] `gart doctor` command — diagnose project setup issues (missing deps, broken hooks, MCP connectivity)
- [ ] Division-based scoped rules — auto-generated rules per agent division (engineering, design, marketing) via `sync-agents.sh`

### AntiGravity

- [ ] Standalone AGENTS.md generation for AntiGravity-only setups (cross-tool rules without OpenCode)
- [ ] MCP config guide — document `~/.gemini/antigravity/mcp_config.json` setup with recommended servers
- [ ] Browser URL allowlist template — hardened default allowlist (remove webhook.site, add common docs domains)
- [ ] Terminal allow/deny list presets — exportable security presets for different project types

### Research-Driven (from `docs/context/research-foundation.md`)

- [ ] 2-tier routing formalization — orchestrator routes to teams only (11 targets), team leads route to specialists. Reduces decision space from 206→11. [Source 1: MAS Survey, DIRECT]
- [ ] Structured handoff schemas — define what context each agent needs and must produce per workflow phase. [Source 1: MAS Survey, ANALOGICAL]
- [ ] Coopetition formalization — make `reality-checker` adversarial review a mandatory pipeline phase. [Source 1: MAS Survey, DIRECT]

### AntiGravity Enhancement (Future)

- [ ] Skill composition — `skills:` field in agency-\* SKILL.md linking related skills
- [ ] App builder templates — `.agent/skills/app-builder/templates/` for web/mobile/API scaffolding
- [ ] ARCHITECTURE.md generation — auto-generate from project analysis
- [ ] Advanced UI skill (AG-Kit ui-ux-pro-max parity) — 50 styles, 21 palettes, 50 fonts
- [ ] Per-skill validators — bash scripts attached to individual skills

### GitHub Integration (Future)

- [ ] GitHub Models as free AI fallback — endpoint `https://models.inference.ai.azure.com`, auth via `GITHUB_TOKEN`, 1000 req/day (GPT-4o, Llama, DeepSeek). Prototyping tier only, not production.
- [ ] Full GitHub App — when Actions rate limits aren't enough (5000 req/hr per installation). Overkill while Actions suffice.
- [ ] GitHub Pages agent catalog — searchable `https://ifrescoo.github.io/gart/` with 274+ agents, filterable by division/platform. Requires static site generator + maintenance.
- [ ] Devcontainer / Codespaces — one-click dev environment in browser for contributors. Needs GitHub Pro/Team for private repos.
- [ ] GitHub Discussions templates — "Request new agent", "Setup help", "Showcase your project" forms for community.
- [ ] GitHub Sponsors integration — funding tiers with badges and exclusive agent access.
- [ ] CONTRIBUTING.md — step-by-step guide for adding agents, hooks, rules, and skills.
- [ ] Copilot integration guide — compatibility matrix (Claude Code / OpenCode / AntiGravity / Copilot), document that GART skills work with GitHub Copilot.

## manual

- [ ] Posto GART on marketplace as a plugin

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
