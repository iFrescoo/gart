# [Nazwa projektu]

> [Jednozdaniowy opis projektu]

---

## Stack

| Komponent | Technologia | Wersja |
|-----------|------------|--------|
| | | |

## Architektura

<!-- Opisz architekturę: moduły, serwisy, przepływ danych -->

## Start

### Wymagania

<!-- Lista narzędzi i wersji -->

### Instalacja

```bash
# kroki instalacji
```

### Uruchomienie

```bash
# jak uruchomić projekt
```

## Struktura projektu

```
<!-- kluczowe foldery i ich rola -->
```

## Komendy

| Komenda | Opis |
|---------|------|
| | |

## Standardy kodowania

<!-- Linting, formatowanie, konwencja commitów -->

---

## AI Agent Setup

### 1. Wymagania

| Narzedzie | Minimalna wersja | Po co |
|-----------|-----------------|-------|
| Node.js | >= 18.0.0 | MCP servers (GitHub, Memory, Playwright, SQLite) |
| npm | >= 9.0.0 | Instalacja MCP servers |
| bun | >= 1.0.0 | OpenCode plugin (`bun install`) |
| Docker Desktop | latest | MCP Docker Gateway (316+ serwerow) |

Instalacja bun: `npm install -g bun`

### 2. Instalacja zaleznosci

```bash
npm install
# Automatycznie instaluje tez OpenCode plugin przez postinstall
```

### 3. Konfiguracja srodowiska

```bash
cp .env.example .env
# Edytuj .env — wstaw swoje klucze API:
# - GITHUB_PERSONAL_ACCESS_TOKEN
# - REF_API_KEY (opcjonalny — ref.tools dokumentacja)
# - OPENCODE_EXPERIMENTAL_LSP_TOOL=true
```

### 4. Uruchomienie IDE

```bash
opencode        # OpenCode (czyta AGENTS.md + opencode.json)
claude          # Claude Code (czyta CLAUDE.md)
# AntiGravity: otworz folder w IDE (czyta GEMINI.md)
```

Po uruchomieniu agent automatycznie wypelni sekcje **Kontekst projektu** w plikach MD.

Pelna dokumentacja: `docs/guides/`

### 5. Agent Orchestration (144+ specialists)

144+ specialized agents from [agency-agents](https://github.com/msitarzewski/agency-agents) are **pre-included** — no setup needed after `git clone`.

#### How auto-invocation works per IDE

| IDE | Orchestration mechanism |
|-----|------------------------|
| **OpenCode** | `Tab` key switches between division tabs: **Orchestrator**, **team-engineering**, **team-design**, **team-qa**, etc. Each team-* delegates to its ~10-30 specialists. **Forge** tab is independent — for creating new agents/skills. |
| **Claude Code** | No tabs. Claude auto-dispatches via `Agent` tool based on trigger phrases in agent descriptions (`USE THIS AGENT when: ...`) and the orchestration skill in `.claude/skills/orchestration/`. |
| **AntiGravity** | Activate the `orchestrate` workflow (`.agent/workflows/orchestrate.md`) for multi-agent tasks. Skills auto-loaded from `.agent/skills/agency-*/`. |

#### OpenCode tabs structure

```
[Orchestrator]  ← CTO-level: delegates to ALL 144+ agents
[team-engineering]  ← ~35 eng specialists + debugger, explorer
[team-design]       ← ~10 design specialists
[team-qa]           ← ~8 QA specialists + test-runner
[team-product]      ← ~5 product specialists
[team-project-mgmt] ← ~6 project management specialists
[team-marketing]    ← ~20 marketing specialists
[team-sales]        ← ~10 sales specialists
[team-paid-media]   ← ~7 paid media specialists
[team-game-dev]     ← ~19 game dev specialists
[team-spatial]      ← ~5 spatial computing specialists
[team-specialized]  ← ~20 MCP, AI/ML, blockchain, docs specialists
[Forge]             ← Independent: create new agents/skills/commands
```

#### Forge — independent meta-agent

**Forge** is not part of orchestration. It is a standalone tab for creating and managing the AI agent ecosystem itself:
- Scaffold new agents (`@forge`)
- Create new skills and commands
- Helpers available: `@agency-codebase-explorer`, `@agency-github-code-searcher`, `@agency-technical-writer`

#### Update agents

```bash
bash scripts/sync-agents.sh
```

Pulls latest agents from upstream, regenerates team-* agents, orchestrator, and orchestration skills with full agent rosters.

Full agent catalog: `docs/context/agency-agents-catalog.md`

---

*Wypelnij sekcje powyzej informacjami o projekcie.*
