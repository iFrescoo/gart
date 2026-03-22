# Architecture Decision Records

> Log of key architectural decisions.
> Add a new entry for every significant change in direction.

---

| ID | Date | Decision | Rationale | Status |
|----|------|----------|-----------|--------|
| ADR-001 | 2026-03-09 | Agent coordination via `status.md` (lock system) | Enables parallel work without conflicts | ABANDONED — `status.md` removed |
| ADR-002 | 2026-03-12 | Removed `MCP_DOCKER` | Unused, slowed startup, caused OAuth errors | ACTIVE |
| ADR-003 | 2026-03-13 | `context-mode` as MCP server, not plugin | Not an npm OpenCode plugin | ACTIVE |
| ADR-004 | 2026-03-13 | Impeccable skills in `.claude/skills/` and `.opencode/skills/` | Dual-IDE: Claude Code uses `.claude/`, OpenCode uses `.opencode/` | ACTIVE |
| ADR-005 | 2026-03-13 | `plugin:` only in global config | OpenCode ignores `plugin:` in project-level `opencode.json` | ACTIVE |
| ADR-006 | 2026-03-13 | `websearch-cited` pinned to `1.2.0` | OpenCode does not auto-update; pinning prevents breaking changes | ACTIVE |
| ADR-007 | 2026-03-13 | Dual-role README | Agent reading README because user pointed to it = template-dev agent, not project-using agent | ACTIVE |
| ADR-008 | 2026-03-13 | Three IDEs — switching by tokens | OpenCode/AntiGravity (Gemini, same subscription) + Claude Code (Anthropic Pro) — selection depends on available tokens | ACTIVE |
| ADR-009 | 2026-03-13 | Removed status.md / lock files system | Costs tokens, impedes work. Coordination via chat. | ACTIVE |
| ADR-010 | 2026-03-13 | Removed `impeccable/` folder from project | Skills copied to .claude/skills/ and .opencode/skills/ — original repo unnecessary in workspace | ACTIVE |
| ADR-011 | 2026-03-13 | Added CLAUDE.md | Claude Code needs its own rules file — AGENTS.md is for OpenCode | ACTIVE |
| ADR-012 | 2026-03-13 | Renamed CodeReviewer.md → code-reviewer.md | Consistency with `agent: code-reviewer` in commands and `task: "code-reviewer": "allow"` in forge.md | ACTIVE |
| ADR-013 | 2026-03-13 | Agency-agents globally, project agents separately | 274+ agency-agents in global catalogs per IDE; 11 project agents in `.opencode/agents/` — no conflicts | ACTIVE |
| ADR-014 | 2026-03-13 | `.mcp.json` for Claude Code project-level MCP | Claude Code does not read `opencode.json` — needs its own `.mcp.json`. Without `ref` (API key) and `gh_grep` (remote). | ACTIVE |
| ADR-015 | 2026-03-13 | `GEMINI.md` as AntiGravity instructions | AntiGravity auto-loads `GEMINI.md` from project root — equivalent of `CLAUDE.md` and `AGENTS.md` | ACTIVE |
| ADR-016 | 2026-03-13 | API key removed from `opencode.json` | ref MCP URL changed to `${REF_API_KEY}` placeholder — key inserted from `.env` or global config | ACTIVE |
| ADR-017 | 2026-03-13 | `.agent/` folder for AntiGravity workspace skills | AntiGravity looks for workspace skills in `.agent/skills/`. Bulk skills via Skill Custom Paths → `.opencode/skills` | ACTIVE |
| ADR-018 | 2026-03-13 | Claude Code PreToolUse hook — dangerous command blocker | `.claude/hooks/block-dangerous-commands.sh` blocks rm -rf, git push --force, DROP TABLE. Deterministic protection independent of LLM | ACTIVE |
| ADR-019 | 2026-03-13 | Setup script instead of manual copying | `scripts/setup.sh` automates copying template to a new project. Does not overwrite existing files. | ACTIVE |
| ADR-020 | 2026-03-13 | Context7 + sequential-thinking MCP in OpenCode | Added to opencode.json. Context7 provides current library documentation, sequential-thinking supports complex reasoning. | ACTIVE |
| ADR-021 | 2026-03-13 | Developer guide in CONTRIBUTING.md | Moved from README to separate file. README = user guide, CONTRIBUTING.md = template development guide | ACTIVE |
| ADR-022 | 2026-03-13 | MCP instructions in AGENTS.md and explorer.md | memory, context7, playwright, sequential-thinking — agents know when and how to use them | ACTIVE |
| ADR-023 | 2026-03-22 | Unified `scripts/gart.sh` entry point | Merged validate.sh + sync-agents.sh → single entry: `gart.sh validate\|sync\|doctor` | ACTIVE |
| ADR-024 | 2026-03-22 | Local agents moved to `.gart/agents/` | Cleaner location for local agent templates; `.gart/upstream/` for sync cache | ACTIVE |
| ADR-025 | 2026-03-22 | `tsup define` for version injection | Eliminates hardcoded version in CLI source; `__VERSION__` injected at build time from package.json | ACTIVE |
| ADR-026 | 2026-03-22 | MCP_DOCKER generated dynamically per OS | `transform.ts` generates OS-appropriate paths instead of deleting the entry | ACTIVE |
| ADR-027 | 2026-03-22 | SETUP.md generated post-install | CLI generates SETUP.md in target directory with environment setup, Docker MCP, and verification checklist | ACTIVE |
| ADR-028 | 2026-03-22 | `.github/workflows/` opt-in during npx install | Workflows not copied by default; user prompted to opt in during scaffold | ACTIVE |
| ADR-029 | 2026-03-22 | `docs-dev/` restructured into architecture/setup/tasks/ | Cleaner dev docs organization; Polish translated to English; audit → reusable template | ACTIVE |
