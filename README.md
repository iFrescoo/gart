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

### 5. Agency Agents (144+ specialists)

144+ specialized agents from [agency-agents](https://github.com/msitarzewski/agency-agents) are **pre-included in this repo** — no additional setup needed after `git clone`.

Available across all IDEs:

| IDE | How to invoke |
|-----|---------------|
| OpenCode | `@agency-frontend-developer`, `@agency-backend-architect`, etc. |
| Claude Code | Agent tool with `subagent_type: "Frontend Developer"` etc. |
| AntiGravity | Skills auto-loaded from `.agent/skills/agency-*/` |

**To update agents** (sync latest from upstream repo):

```bash
bash scripts/sync-agents.sh
```

Run this occasionally — it pulls the newest agents and improvements. Your existing project agents are never overwritten.

Full agent catalog: `docs/context/agency-agents-catalog.md`

---

*Wypelnij sekcje powyzej informacjami o projekcie.*
