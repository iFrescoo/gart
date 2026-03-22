# GART Roadmap

> Single source of truth for what's planned, what's in progress, what's done, and what was ruled out.
> Also contains the periodic audit checklist — run before every release.

## Status Legend

| Symbol | Meaning                                             |
| ------ | --------------------------------------------------- |
| ✅     | Done — shipped                                      |
| 🚧     | Open — actionable, no blocker                       |
| 📌     | Planned — confirmed, not started                    |
| 🔭     | Research-driven — grounded in architecture research |
| 💭     | Considered — not committed                          |
| ❌     | Rejected — ruled out with reason                    |

---

## 🚧 Open Tasks

Tasks confirmed but not yet done. Ordered by priority.

- **`HIGH`** — Install `opencode-worktree` plugin
  Git worktrees — each agent on a separate branch.
  OCX doesn't work on Windows without WSL. Manual: copy `src/` → `.opencode/plugins/` + `npm install jsonc-parser`.
  Details: [docs-dev/setup/plugins.md](docs-dev/setup/plugins.md)

- **`MEDIUM`** — Install `opencode-google-antigravity-auth`
  OAuth AntiGravity + `google_search` tool + multi-account rotation.
  Before install: change `webfetch: deny` → `ask` in `opencode.json`, then add BEFORE DCP in global plugin array.

- **`LOW`** — Impeccable skills for AntiGravity
  AntiGravity Skill Custom Paths → `.opencode/skills` already gives access to 25 skills.
  Alternative: copy to `~/.gemini/antigravity/skills/`

- **`LOW`** — Add `@mohak34/opencode-notifier` to global config
  Plugin downloaded to cache, not added to config. Add before DCP in plugin array.
  Only `.wav` files supported; full paths required on Windows (`C:/Users/...`).

---

## 📌 Planned

NEW: czy mozesz dodac w soihc ustawieniach (claude) abym nie musial caly czas potwierdzac twoicgh dzilaan w roznych sesjach i proiejktach? ze czy mzoesz np. uzyc mcp docker albo wykonac bash? chce abys byl zautomatyzowany i zeby te potwierdzenia byly tylko w wyjatkowych sytuacjach i zeby bylo to tez w GART tym proejkcie. innych userów tez to pewnie wkurza ale trzeb abedzie to zaznaczyc w readmie.

### CLI & Scaffold

- [ ] `gart doctor` command — diagnose project setup issues (missing deps, broken hooks, MCP connectivity)
- [ ] `gart update` command — update GART CLI itself to latest version
- [ ] VS Code `extensions.json` — recommend Claude Code extension on project open
- [ ] JetBrains plugin configuration guide
- [ ] Division-based scoped rules — auto-generated rules per agent division (engineering, design, marketing) via `gart.sh sync`

### AntiGravity

- [ ] Standalone `AGENTS.md` generation for AntiGravity-only setups (cross-tool rules without OpenCode)
- [ ] MCP config guide — document `~/.gemini/antigravity/mcp_config.json` setup with recommended servers
- [ ] Browser URL allowlist template — hardened default allowlist (remove webhook.site, add common docs domains)
- [ ] Terminal allow/deny list presets — exportable security presets for different project types

### AntiGravity Enhancement

- [ ] Skill composition — `skills:` field in agency-\* SKILL.md linking related skills
- [ ] App builder templates — `.agent/skills/app-builder/templates/` for web/mobile/API scaffolding
- [ ] ARCHITECTURE.md generation — auto-generate from project analysis
- [ ] Advanced UI skill (AG-Kit ui-ux-pro-max parity) — 50 styles, 21 palettes, 50 fonts
- [ ] Per-skill validators — bash scripts attached to individual skills

### 🔭 Research-Driven

Grounded in [architecture/research.md](docs-dev/architecture/research.md) — Source 1 (MAS Survey, arxiv 2501.06322).

- [ ] **2-tier routing formalization** — orchestrator routes to teams only (11 targets), team leads route to specialists. Reduces decision space 206→11. [DIRECT mapping]
- [ ] **Structured handoff schemas** — define what context each agent needs and must produce per workflow phase. [ANALOGICAL mapping]
- [ ] **Coopetition formalization** — make `reality-checker` adversarial review a mandatory pipeline phase. [DIRECT mapping]

### Skills & Marketplace Integration

- [ ] `gart.sh skills` subcommand — wrapper for `npx skills add` with GART-aware paths (auto-install to correct `.claude/skills/`, `.opencode/skills/`, or `.agent/skills/`)
- [ ] `find-skills` integration — bundle [vercel-labs/find-skills](https://skills.sh) meta-skill so users can discover and install skills on demand (661K installs)
- [ ] `verification-before-completion` skill — force verification step before marking tasks done, reduces hallucination ([obra/superpowers](https://skills.sh))
- [ ] Document generation skills — evaluate Anthropic's `pdf`/`docx`/`pptx`/`xlsx` skills for inclusion (~50K installs each)
- [ ] SETUP.md marketplace section — point users to [skillsmp.com](https://skillsmp.com) (280K+ skills) and [skills.sh](https://skills.sh) (89K+ skills) for self-service skill discovery

### AI Model Architecture & Multi-Agent Routing

> Based on research in [nvidia-nim.md](docs-dev/architecture/nvidia-nim.md) and [llm-comparison.md](docs-dev/architecture/llm-comparison.md) — strategic cost-to-performance routing between free (NVIDIA NIM) and paid APIs.

- [ ] **Complexity Estimator** — classify incoming tasks by tier before routing: `MICRO` (linting, docs, <500 LOC) → NIM free; `STANDARD` (RAG, code gen) → NIM with paid fallback; `CRITICAL` (macro-architecture, legal RAG, Computer Use) → paid API. This is the core of a cost-optimized orchestrator
- [ ] **NVIDIA NIM integration guide** — document free endpoint setup (`build.nvidia.com`). Key models: Nemotron 3 Super 120B (reasoning + RAG, 1M ctx), MiniMax-M2.5 (coding, 89.6% HumanEval), Llama 4 Scout (linting, TTFT ~0.33s), Mistral Large 3 (multilingual dispatcher), Cosmos Reason 2 8B (Vision RAG), Phi-4-multimodal (OCR). Rate limit: ~40 RPM/model. Source: [nvidia-nim.md](docs-dev/architecture/nvidia-nim.md)
- [ ] **Paid API fallback gates** — document when NIM is insufficient and escalation is mandatory: macro-engineering (Claude Opus 4.6, SWE-bench 80.8%), tier-0 reasoning (GPT-5.4, HLE 41.6%), Computer Use / RPA (GPT-5.4, OSWorld 75%), long-form video (Gemini 3.1 Pro, MMMU-Pro 80.5%), legal RAG / MRCR v2 (Claude Opus 4.6, 76%). Source: [llm-comparison.md](docs-dev/architecture/llm-comparison.md)
- [ ] **GART agent division routing table** — map each of GART's 274 agent divisions to optimal model tier: Engineering agents → Opus/Codex for macro, MiniMax for micro; Design agents → Gemini for vision; Research agents → Sonnet for RAG
- [ ] **`.env.example` model provider section** — add `NVIDIA_NIM_API_KEY`, commented routing config, and links to `build.nvidia.com` free tier

### Free LLM Providers & Model Discovery

> Resources for running GART on free/low-cost models — especially useful for OpenCode which accepts any OpenAI-compatible endpoint.

- [ ] **OpenCode free model guide** — document OpenRouter as drop-in free key: one API key, 50+ models including Qwen3-Coder and Llama 4 Scout, OpenAI-compatible. Set `OPENROUTER_API_KEY` in `.env`, configure base URL in `opencode.json`. Sources: [free-llm-api-resources](https://github.com/cheahjs/free-llm-api-resources), [openrouter.ai](https://openrouter.ai)
- [ ] **Groq integration guide** — fastest free inference (LPU hardware, sub-second responses). Free tier: Llama 4 Scout (30K tokens/min), Kimi K2, Qwen3-32B, 1K–14K req/day. OpenAI-compatible at `https://api.groq.com/openai/v1`. Best for speed-sensitive agentic loops. Source: [console.groq.com](https://console.groq.com)
- [ ] **`free-coding-models` in SETUP.md** — CLI tool that pings 174 free models across 23 providers in real-time, ranks by stability score (latency + jitter + uptime), auto-writes config for OpenCode. Install: `npm install -g free-coding-models`. Does not yet support Claude Code or AntiGravity natively. Source: [vava-nessa/free-coding-models](https://github.com/vava-nessa/free-coding-models)
- [ ] **`.env.example` free provider section** — add commented-out `OPENROUTER_API_KEY`, `GROQ_API_KEY`, `CEREBRAS_API_KEY` entries with links to free signup, so users have a ready checklist for zero-cost setup

### GitHub Integration

- [ ] GitHub Pages agent catalog — searchable `https://ifrescoo.github.io/gart/` with 274+ agents, filterable by division/platform
- [ ] GitHub Discussions templates — "Request new agent", "Setup help", "Showcase your project" forms for community
- [ ] CONTRIBUTING.md — step-by-step guide for adding agents, hooks, rules, and skills
- [ ] Copilot integration guide — compatibility matrix (Claude Code / OpenCode / AntiGravity / Copilot)
- [ ] Devcontainer / Codespaces — one-click dev environment in browser for contributors
- [ ] GitHub Sponsors integration — funding tiers with badges and exclusive agent access
- [ ] GitHub Models as free AI fallback — endpoint `https://models.inference.ai.azure.com`, auth via `GITHUB_TOKEN`, 1000 req/day. Prototyping tier only.
- [ ] Full GitHub App — when Actions rate limits aren't enough. Overkill while Actions suffice.

### Manual

- [ ] Post GART on marketplace as a plugin

---

## ✅ Completed

### Milestone 3 — Documentation Overhaul (March 2026)

- [x] `docs/guides/` restructured with tool subfolders (`claude/`, `opencode/`, `antigravity/`) + `plugins.md`
- [x] Template files added to `docs/` subfolders (`requirements.md`, `session-template.md`, `ADR-000-template.md`, `backlog.md`, `sprint-001.md`)
- [x] `docs-dev/` translated from Polish to English and reorganized into `architecture/`, `setup/`, `tasks/`
- [x] Architecture Decision Records updated through ADR-029
- [x] `Acknowledgements` section added to `README.md`

### Milestone 2 — CLI & Scaffold Restructure (March 2026)

- [x] Unified `scripts/gart.sh` entry point — `validate | sync | doctor` subcommands
- [x] Local agents moved to `.gart/agents/`, sync cache to `.gart/upstream/`
- [x] `tsup define` for automated version injection — no more hardcoded version strings
- [x] MCP_DOCKER generated dynamically per OS in `transform.ts`
- [x] `SETUP.md` generated post-install with environment setup, Docker MCP, and verification checklist
- [x] `.github/workflows/` opt-in during `npx gart-build` (not copied by default)
- [x] `protect-files.sh` hook fixed — `.env.example` whitelisted, real `.env.*` blocked
- [x] `.env.example` translated to English, all Polish comments removed
- [x] `.agency-agents-upstream` → `.gart/upstream` path updated everywhere

### Milestone 1 — Three-IDE Foundation (March 2026)

- [x] `.mcp.json` created for Claude Code project-level MCP (github, memory, playwright, sequential-thinking)
- [x] `GEMINI.md` created for AntiGravity with full project context and tool permissions
- [x] `.agent/` folder created for AntiGravity workspace skills and workflows
- [x] API key removed from `opencode.json` → `${REF_API_KEY}` placeholder
- [x] Global path reference (`~/.config/opencode/plugin/...`) removed from project config
- [x] Context7 + sequential-thinking MCP added to OpenCode
- [x] Claude Code hooks implemented (dangerous command blocker)
- [x] Setup script `scripts/setup.sh` for bootstrapping new projects
- [x] Prerequisites and per-IDE setup instructions added to README
- [x] `CLAUDE.md` created for Claude Code
- [x] Developer guide moved to `CONTRIBUTING.md` (README = user guide only)
- [x] MCP instructions documented in `AGENTS.md` and `explorer.md`
- [x] 26 scoped rules added to `.claude/rules/`
- [x] `status.md` / lock file system removed
- [x] Gitignore option during `npx gart-build` installation ✅

---

## 💭 Considered

Not committed. Revisit when relevant.

- [ ] Agent SDK examples/templates — programmatic agent building (JS/TS)
- [ ] Custom MCP server template — starter boilerplate for building own MCP servers
- [ ] Slack/Discord notification hooks — team alerts when Claude needs attention
- [ ] TTS (text-to-speech) notification hooks — audio alerts on task completion
- [ ] Session context loader hook (`SessionStart`) — auto-load git status, open issues, recent commits
- [ ] Pre-compact transcript backup hook — save full conversation before context compression
- [ ] License compliance hook — check new dependencies against approved license list
- [ ] Auto-test hook (`PostToolUse`) — run test suite after code changes
- [ ] Project template variants — pre-configured templates for common stacks (Next.js, FastAPI, etc.)

---

## ❌ Rejected

Ruled out. Don't revisit without a strong new reason.

| Item                        | Reason                                                                                      |
| --------------------------- | ------------------------------------------------------------------------------------------- |
| Agent SDK examples          | Too complex for a scaffold template; SDK API changes frequently; 95% of users don't need it |
| Git worktree scaffolding    | Built-in Claude Code feature — no project-level configuration needed                        |
| Checkpointing configuration | Built-in feature, works automatically                                                       |
| Voice mode configuration    | Built-in feature, activated via `/voice`                                                    |
| `/loop` configuration       | Built-in feature, no config files involved                                                  |

---

## 🔍 Periodic Audit Checklist

Run before every release or after significant changes. Mark each item ✅ DONE, ⚠️ PARTIAL, or ❌ MISSING.

### A — Critical (blocks "copy and it works")

| #   | Check                                                            | How to verify                                                               |
| --- | ---------------------------------------------------------------- | --------------------------------------------------------------------------- |
| A1  | `.mcp.json` exists with github, memory, playwright servers       | `ls .mcp.json`                                                              |
| A2  | `GEMINI.md` exists with project context and tool permissions     | `ls GEMINI.md`                                                              |
| A3  | `.agent/skills/` and `.agent/workflows/` both exist with content | `ls .agent/skills/ .agent/workflows/`                                       |
| A4  | No secrets hardcoded in committed files                          | `grep -r "apiKey=" opencode.json .mcp.json` → must be empty                 |
| A5  | No global/machine-specific paths in project config               | `grep -r "C:/" opencode.json AGENTS.md CLAUDE.md GEMINI.md` → must be empty |

### B — Missing (completeness)

| #   | Check                                                                       | How to verify                        |
| --- | --------------------------------------------------------------------------- | ------------------------------------ |
| B1  | `scripts/gart.sh` exists and `npx gart-build` generates `SETUP.md`          | `ls scripts/gart.sh` + test scaffold |
| B2  | `.claude/hooks/` has at minimum `protect-files.sh` and `validate-commit.sh` | `ls .claude/hooks/`                  |
| B3  | `.env.example` documents all required variables with English comments       | Review `.env.example`                |
| B4  | SQLite and other DB files are in `.gitignore`                               | `grep -i sqlite .gitignore`          |
| B5  | `docs/guides/claude/`, `opencode/`, `antigravity/` all exist                | `ls docs/guides/`                    |

### C — Quality

| #   | Check                                                   | How to verify                                         |
| --- | ------------------------------------------------------- | ----------------------------------------------------- |
| C1  | `README.md` contains no developer/template instructions | Review README — user-facing only                      |
| C2  | No deprecated files in `docs/`                          | `ls docs/` — no files marked deprecated               |
| C3  | All user-facing docs in English                         | `grep -r "^\(# \|## \)" docs/` — all headings English |
| C4  | Open tasks in this roadmap reviewed and current         | Review 🚧 section above                               |

### D — Unused features (opportunities)

| #   | Check                                           | How to verify                                              |
| --- | ----------------------------------------------- | ---------------------------------------------------------- |
| D1  | Context7 available in all three IDEs            | Check `.mcp.json`, `opencode.json`, AntiGravity mcp_config |
| D2  | Sequential Thinking available in all three IDEs | Same as D1                                                 |
| D3  | `.agent/workflows/` has key workflows           | `ls .agent/workflows/`                                     |
| D4  | Agents have memory MCP usage instructions       | `grep -r "memory" CLAUDE.md AGENTS.md GEMINI.md`           |
| D5  | At least one agent/skill references Playwright  | `grep -r "playwright" .claude/agents/ .opencode/agents/`   |
