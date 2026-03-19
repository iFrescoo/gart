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

---

#### Sync agents — aktualizacja i regeneracja

Skrypt `sync-agents.sh` pobiera najnowszych agentów z GitHub i regeneruje:
- Pliki agentów dla 3 IDE (`.claude/agents/`, `.opencode/agents/`, `.agent/skills/`)
- Team-* taby (11 dywizji) + Orchestrator
- Orchestration skill + AntiGravity workflow

##### Wymagania

Przed uruchomieniem sprawdź, czy masz zainstalowane:

| Narzędzie | Sprawdź wersję | Jak zainstalować |
|-----------|---------------|-----------------|
| **Git** | `git --version` | https://git-scm.com/downloads |
| **Python 3** | `python3 --version` | https://www.python.org/downloads/ lub `winget install Python.Python.3.12` |
| **Bash** | `bash --version` | Windows: Git Bash (instaluje się razem z Git) |

> **Windows:** Wszystkie komendy uruchamiaj w **Git Bash** (nie PowerShell, nie CMD).
> Git Bash instaluje się automatycznie z Git for Windows.

##### Krok po kroku

**1. Otwórz Git Bash w folderze projektu**

Kliknij prawym przyciskiem na folder projektu → "Open Git Bash here".
Albo otwórz Git Bash i wpisz:

```bash
cd /g/agentic-coding-template
```

(Zamień ścieżkę na swoją. W Git Bash dysk `G:\` to `/g/`.)

**2. Napraw końcówki linii (tylko za pierwszym razem na Windows)**

Windows zapisuje pliki z końcówkami `\r\n` (CRLF), a skrypt wymaga `\n` (LF). Napraw raz:

```bash
sed -i 's/\r//' scripts/sync-agents.sh
```

Musisz to zrobić **tylko raz** — po naprawie plik zostaje z LF.

**3. Uruchom sync**

```bash
bash scripts/sync-agents.sh
```

Skrypt przechodzi przez 11 kroków. Powinien zakończyć się bez błędów:

```
Step 1:  Fetching upstream agency-agents repo      → [OK]
Step 2:  Running upstream convert.sh               → [OK]
Step 3:  Collecting agent data by division         → [OK]
Step 4:  Copying agents to .claude/agents/         → [OK]  ~132 agents
Step 5:  Post-processing OpenCode agents           → [OK]  ~132 agents
Step 6:  Generating local agents                   → [OK]  5 agents
Step 7:  Generating team-* division agents         → [OK]  11 teams
Step 8:  Generating orchestrator.md                → [OK]
Step 9:  Generating orchestration skill            → [OK]
Step 10: Generating AntiGravity workflow           → [OK]
Step 11: Copying AntiGravity skills                → [OK]

Sync complete!
```

**4. Zweryfikuj wynik**

Skopiuj i wklej te komendy do Git Bash:

```bash
echo "--- Weryfikacja sync ---"
echo "Team agents (oczekiwane: 11):"
ls .opencode/agents/team-*.md 2>/dev/null | wc -l

echo "Orchestrator:"
ls .opencode/agents/orchestrator.md 2>/dev/null && echo "OK" || echo "BRAK!"

echo "Claude agents (oczekiwane: >130):"
ls .claude/agents/agency-*.md 2>/dev/null | wc -l

echo "Local agents (oczekiwane: 5):"
ls scripts/local-agents/*.md 2>/dev/null | wc -l

echo "Orchestration skill:"
ls .opencode/skills/orchestration/SKILL.md 2>/dev/null && echo "OK" || echo "BRAK!"

echo "Trigger phrases (oczekiwane: >0):"
grep -l "USE THIS AGENT" .claude/agents/*.md 2>/dev/null | wc -l

echo "Stare duplikaty (oczekiwane: 0):"
ls .opencode/agents/{debugger,test-runner,dependency-agent,explorer,gh-search}.md 2>/dev/null | wc -l
echo "--- Koniec ---"
```

Oczekiwany wynik:

```
--- Weryfikacja sync ---
Team agents (oczekiwane: 11):
11
Orchestrator:
.opencode/agents/orchestrator.md
OK
Claude agents (oczekiwane: >130):
137
Local agents (oczekiwane: 5):
5
Orchestration skill:
.opencode/skills/orchestration/SKILL.md
OK
Trigger phrases (oczekiwane: >0):
137
Stare duplikaty (oczekiwane: 0):
0
--- Koniec ---
```

##### Rozwiązywanie problemów

| Błąd | Przyczyna | Rozwiązanie |
|------|-----------|-------------|
| `$'\r': command not found` | Końcówki linii CRLF (Windows) | `sed -i 's/\r//' scripts/sync-agents.sh` |
| `set: pipefail: invalid option` | Jak wyżej — CRLF | Jak wyżej |
| `python3: command not found` | Brak Pythona 3 | Zainstaluj: `winget install Python.Python.3.12` lub https://www.python.org/downloads/ |
| Microsoft Store się otwiera zamiast Pythona | Windows alias python → Store | Ustawienia → "Aliasy wykonywania aplikacji" → wyłącz "python.exe" i "python3.exe", potem zainstaluj Pythona normalnie |
| `git: command not found` | Brak Gita | https://git-scm.com/downloads |
| Step 4 zatrzymuje się bez błędu | Python nie działa poprawnie | Sprawdź: `python3 -c "print('OK')"` — jeśli nie wypisze OK, napraw instalację |
| `printf: invalid option` | Stara wersja skryptu | Uruchom `git pull` lub pobierz nową wersję `sync-agents.sh` |
| Brak team-*.md po sync | Upstream repo się zmieniło | Uruchom z flagą: `bash scripts/sync-agents.sh --force` |

##### Jak działa sync (dla zainteresowanych)

```
GitHub (agency-agents repo)
    ↓ git clone / pull
.agency-agents-upstream/          ← kopia upstream (gitignored)
    ↓ convert.sh
    ↓ enrich trigger phrases
    ↓ set permissions, model, temperature
.opencode/agents/agency-*.md      ← 132+ agentów z tabami
.opencode/agents/team-*.md        ← 11 team leadów (primary = Tab)
.opencode/agents/orchestrator.md  ← CTO-level coordinator
.claude/agents/agency-*.md        ← 132+ agentów z trigger phrases
.agent/skills/agency-*/SKILL.md   ← AntiGravity skills
.opencode/skills/orchestration/   ← routing table
.claude/skills/orchestration/     ← routing table (kopia)
.agent/workflows/orchestrate.md   ← AntiGravity workflow
```

Sync jest idempotentny — można uruchamiać wielokrotnie. Każde uruchomienie czyści stare pliki i generuje od nowa.

Full agent catalog: `docs/context/agency-agents-catalog.md`

---

*Wypelnij sekcje powyzej informacjami o projekcie.*
