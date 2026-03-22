# Architecture Overview — Agentic Coding Template

> Read before making architectural changes. Contains gotchas, technical debt, and configuration rules.

---

## 1. Environment — Three IDEs, One Project

The user switches between IDEs depending on available tokens:

| IDE | Model | Access | When to use |
|-----|-------|--------|-------------|
| **OpenCode** (CLI) | `gemini-3.1-pro-preview-customtools` | AntiGravity subscription (Google/Cloud login) | Primary environment, full agent configuration |
| **AntiGravity IDE** | `gemini-3.1-pro-preview-customtools` | Same subscription | Alternative when OpenCode tokens are exhausted |
| **Claude Code** (CLI) | `claude-sonnet-4-6` | Anthropic Pro subscription | When Gemini tokens are exhausted or Claude-specific tasks |

All IDEs read project files. OpenCode/AntiGravity use `opencode.json` + YAML frontmatter agents. Claude Code uses `CLAUDE.md` + `.claude/skills/`.

---

## 2. System Architecture

```
agentic-coding-template/
├── AGENTS.md                    ← global rules (auto-loaded by all IDEs)
├── CLAUDE.md                    ← Claude Code instructions
├── GEMINI.md                    ← AntiGravity instructions
├── opencode.json                ← project config (model, MCP, LSP, permissions)
├── .mcp.json                    ← MCP config (Claude Code project-level)
├── .opencode/
│   ├── agents/                  ← 11 agents (YAML frontmatter + instructions)
│   ├── skills/                  ← 25 skills (7 workflow + 18 design)
│   └── commands/                ← project commands
├── .claude/
│   ├── agents/                  ← 274+ agents (synced from upstream)
│   ├── skills/                  ← 18 design skills (Claude Code only)
│   ├── hooks/                   ← safety hooks
│   └── rules/                   ← 26 scoped rules
├── .agent/
│   ├── skills/                  ← AntiGravity workspace skills
│   └── workflows/               ← AntiGravity workflows
└── docs/                        ← user-facing documentation
```

**Skills split:**

| Location | Available in | Contains |
|----------|-------------|---------|
| `.opencode/skills/` | OpenCode, AntiGravity | 7 workflow (brainstorming, git-workflow, lsp-navigator, mgrep-search, subagent-driven-development, systematic-debugging, writing-plans) + 18 design |
| `.claude/skills/` | Claude Code | 18 design skills |

---

## 3. Configuration — Two Levels

| File | Location | Contains |
|------|----------|---------|
| `opencode.json` | project root | model, MCP, LSP, permissions, instructions, commands |
| `~/.config/opencode/opencode.json` | global (Windows) | `plugin:` array — **plugins only work here** |

> `plugin:` in project-level `opencode.json` is ignored by OpenCode.

### MCP servers (project)

| Server | Type | Function |
|--------|------|---------|
| `context-mode` | local | Context window protection |
| `mgrep` | local | Semantic code search |
| `gh_grep` | remote | GitHub code search (only via `@gh-search` agent) |
| `ref` | remote | Current library documentation |

> **`ref` MCP has an inline API key in `opencode.json` — do not commit to a public repo.**

### BOM encoding — critical gotcha

Global config **MUST be UTF-8 without BOM**. Even one BOM causes MCP servers to show "failed".

```powershell
$bytes = [System.IO.File]::ReadAllBytes("$env:USERPROFILE\.config\opencode\opencode.json")
if ($bytes[0] -eq 0xEF) { "BOM DETECTED!" } else { "OK" }
```

Safe editor: VSCode → click "UTF-8" at the bottom → "Save with Encoding" → "UTF-8" (not BOM).

---

## 4. Technical Debt

### No worktree isolation

`opencode-worktree` is not deployed — agents work on the same branch. Installation details: [`setup/plugins.md`](../setup/plugins.md).

### External agent import — risk

An agent from outside (e.g. `msitarzewski/agency-agents`) **does not know the rules in `AGENTS.md`** and may use disallowed tools.

**Before importing:** The `forge` agent must inject a restrictive `permission:` block matched to the target project.

### Missing Gemini/AntiGravity skills config

`impeccable/dist/gemini/` does not exist — impeccable skills are not configured for AntiGravity as separate files. AntiGravity currently uses skills from `.opencode/skills/` via the skill tool.

---

## 5. Known Model Issues (Gemini 3.1)

### Deliberation loop in explorer

**Symptom:** Agent enters a "Wait..." loop and hallucinates a fake "CRITICAL INSTRUCTION".

**Cause:** Too large a "decision surface" — too many tools and sections in the prompt.

**Fix:** Max 5 items in tool hierarchy, remove long explanatory sections, add directive: `"Do not deliberate. Choose one tool, use it."`
