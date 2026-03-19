# Zasady — OpenCode

Jestes zaawansowanym asystentem AI. Twoim celem jest maksymalna efektywnosc i bezblednosc przy pracy **rownoleglej z innymi agentami**.

---

## 1. Zasady pracy

- **NIGDY** nie generuj calego pliku dla malych zmian. Uzywaj `// ... reszta kodu bez zmian ...`
- **Jezyk prosty:** Wyjasniaj krotko — **Co** zmieniles i **Co to robi**. Glebsze wyjasnienia tylko na prosbe.
- Zanim wygenerujesz dlugie rozwiazanie — napisz plan w 2-3 zdaniach i zapytaj: _"Czy mam isc w tym kierunku?"_
- Nie halucynuj. Jesli czegos nie wiesz: `"Nie wiem, potrzebuje wiecej kontekstu o [X]"`
- Zanim usuniesz plik lub wykonasz destrukcyjna komende — **zapytaj uzytkownika**
- Nie instaluj zaleznosci bez zgody
- Nie ma systemu lock plikow — dzialaj bezposrednio
- Narzedzie `question` — uzywaj do interaktywnych pytan zamiast listy w prozie
- `todowrite` / `todoread` — sledzenie krokow przy zlozonych zadaniach

---

## 2. Generowanie kodu

- Minimalne, celowe zmiany — nie przepisuj tego co dziala
- Sprawdzaj importy — nie dodawaj duplikatow, nie zostawiaj nieuzywanych
- `// PRZED:` -> `// PO:` dla krytycznych zmian logiki
- Czysty kod: male funkcje, czytelne nazwy, brak magicznych liczb
- TypeScript: strict mode, brak `any`, explicit return types dla funkcji publicznych
- Conventional Commits: `feat:` / `fix:` / `docs:` / `refactor:` / `test:` / `chore:`

---

## 3. Nawigacja po kodzie

1. **`mgrep`** (MCP) — zawsze jako pierwsze. Semantyczna szukajka: rozumie znaczenie, nie tylko tekst. Jedno zapytanie zamiast czytania 20 plikow. **Widzi pliki z `.gitignore` ktorych grep nie widzi.**
2. **`lsp`** — gdy znasz juz symbol: definicja, referencje, hierarchia wywolan. Wymaga `OPENCODE_EXPERIMENTAL_LSP_TOOL=true`.
3. **`grep`** — dokladny string/regex. Respektuje `.gitignore` — nie znajdzie kodu w `node_modules/`, `dist/`.
4. **`glob`** / **`list`** — wzorce sciezek, struktura folderow. Tez respektuje `.gitignore`.
5. **`read`** — gdy juz wiesz ktory plik i musisz zobaczyc zawartosc.
6. **`@gh-search`** (subagent) — GitHub code search przez gh_grep. Przyklady implementacji, wzorce. Narzedzia `gh_grep*` wylaczone globalnie — dostep tylko przez tego agenta.

> ZAKAZ: Nie czytaj plikow po kolei w poszukiwaniu czegos. Najpierw znajdz przez mgrep, potem czytaj.

---

## 4. Narzedzia MCP

| Serwer         | Rola                                                       |
| -------------- | ---------------------------------------------------------- |
| `context-mode` | Ochrona context window — indeksuj duze outputy w sandboxie |
| `mgrep`        | Semantic code search po projekcie                          |
| `gh_grep`      | GitHub code search (przez `@gh-search`)                    |
| `MCP_DOCKER`   | Docker MCP Gateway — pelny zestaw serwerow                 |

### MCP Docker — meta-narzedzia (zawsze dostepne)

| Narzedzie  | Opis                                                         |
| ---------- | ------------------------------------------------------------ |
| `mcp-find` | Szukaj w katalogu 316+ serwerow MCP po nazwie/opisie         |
| `mcp-exec` | Wywolaj narzedzie z dowolnego serwera bez dodawania do sesji |
| `mcp-add`  | Dodaj serwer do biezacej sesji                               |

Przyklad: `mcp-find "npm sentinel"` -> `mcp-exec "npmLatest" {name: "react"}`

### Przydatne serwery Docker MCP

- **context7** — dokumentacja bibliotek (`resolve-library-id` -> `query-docs`). Uzywaj zamiast halucynowania o API.
- **playwright** — browser automation gdy fetch nie wystarczy (SPA, JS-rendered, Cloudflare)
- **github-official** — GitHub API (issues, PR, commits, code search)
- **memory** — pamiec miedzy sesjami (`memory_store` / `memory_retrieve`)
- **sequential-thinking** — rozumowanie krok-po-kroku przy zlozonych problemach
- **docker-hub** — Docker Hub: obrazy, tagi, wersje

---

## 5. Skills i agenci

### Workflow Skills (7 — `.opencode/skills/`)

`brainstorming`, `git-workflow`, `lsp-navigator`, `mgrep-search`, `subagent-driven-development`, `systematic-debugging`, `writing-plans`

### Impeccable Design Skills (18 — `.opencode/skills/` + `.claude/skills/`)

`adapt`, `animate`, `audit`, `bolder`, `clarify`, `colorize`, `critique`, `delight`, `distill`, `extract`, `frontend-design`, `harden`, `normalize`, `onboard`, `optimize`, `polish`, `quieter`, `teach-impeccable`

### Architektura orkiestracji (`.opencode/agents/`)

#### Primary agents (taby w OpenCode)

| Agent | Rola | Wywolanie |
|-------|------|-----------|
| `orchestrator` | CTO-level — analizuje zadanie, deleguje do ALL 144+ agentow | `@orchestrator` |
| `team-engineering` | Division lead: ~35 eng specjalistow + lokalni agenci | `@team-engineering` |
| `team-design` | Division lead: ~10 design specjalistow | `@team-design` |
| `team-qa` | Division lead: ~8 QA specjalistow + test-runner | `@team-qa` |
| `team-product` | Division lead: ~5 product specjalistow | `@team-product` |
| `team-project-mgmt` | Division lead: ~6 project mgmt specjalistow | `@team-project-mgmt` |
| `team-marketing` | Division lead: ~20 marketing specjalistow | `@team-marketing` |
| `team-sales` | Division lead: ~10 sales specjalistow | `@team-sales` |
| `team-paid-media` | Division lead: ~7 paid media specjalistow | `@team-paid-media` |
| `team-game-dev` | Division lead: ~19 game dev specjalistow | `@team-game-dev` |
| `team-spatial` | Division lead: ~5 spatial computing specjalistow | `@team-spatial` |
| `team-specialized` | Division lead: ~20 specialized+support+integrations | `@team-specialized` |
| `forge` | Meta-agent — NIEZALEZNY od orkiestracji, tworzy agentow/skille/komendy | `@forge` |

#### Lokalni agenci (project-specific, `scripts/local-agents/`)

| Agent | Rola | Wywolanie |
|-------|------|-----------|
| `agency-debugger` | Analiza bledow, root-cause diagnosis (read-only) | `@agency-debugger` |
| `agency-test-runner` | Uruchamianie testow + analiza wynikow | `@agency-test-runner` |
| `agency-dependency-auditor` | npm/bun audit, outdated, bezpieczenstwo zaleznosci | `@agency-dependency-auditor` |
| `agency-codebase-explorer` | Eksploracja codebase + websearch | `@agency-codebase-explorer` |
| `agency-github-code-searcher` | GitHub code search (gh_grep) | `@agency-github-code-searcher` |

Agenci zastapieni przez agency-agents:

| Stary agent | Uzyj zamiast |
|-------------|--------------|
| `debugger`, `explorer`, `gh-search` | `@agency-debugger`, `@agency-codebase-explorer`, `@agency-github-code-searcher` |
| `code-reviewer` | `@agency-code-reviewer` |
| `git-agent` | `@agency-git-workflow-master` |
| `security-auditor` | `@agency-security-engineer` |
| `docs-writer` | `@agency-technical-writer` |

### Praca rownolegla

- Przed edycja pliku — sprawdz czy inny agent go nie modyfikuje
- Przy konflikcie edycji — opisz problem i poczekaj na decyzje uzytkownika
- Git push — zawsze przez `/git-push [branch]` lub po zatwierdzeniu

---

## 6. Bezpieczenstwo i jakosc

**Bezpieczenstwo — sprawdzaj proaktywnie:**

- SQL Injection (zapytania bez parametryzacji)
- XSS (innerHTML, dangerouslySetInnerHTML bez sanityzacji)
- CSRF (brakujace tokeny)
- Hardcoded credentials / API keys w kodzie
- Dane wrazliwe w logach lub odpowiedziach API
- Pliki `.env` — nigdy nie commituj, nigdy nie czytaj na glos zawartosci

**Wydajnosc — wskazuj konkretnie:**

- Petle O(n^2) gdzie mozna O(n)
- N+1 queries do bazy danych
- Zbedne re-rendery w React (brakujace memo/useMemo/useCallback)
- Memory leaks (nieoczyszczone event listenery, timery, subscriptions)

**Code review — format:**

```
OK — [co jest dobrze]
Do poprawy — [plik:linia] -> [sugerowany fix]
Krytyczne — [plik:linia] -> [sugerowany fix]
```

---

## 7. Granice

| Akcja                                  | Zasada             |
| -------------------------------------- | ------------------ |
| Edycja pliku                           | Nie — dzialaj      |
| Usuniecie pliku                        | TAK — zapytaj      |
| `rm -rf`, `DROP TABLE`, reset --hard   | TAK — zapytaj      |
| Instalacja nowych zaleznosci           | TAK — zapytaj      |
| Zmiana konfiguracji CI/CD / deploymentu | TAK — zapytaj      |
| Commit lub push                        | Pokaz co i zapytaj |
| Odczyt / wypisanie zawartosci `.env`   | Nigdy              |

---

## 8. Inicjalizacja projektu

Gdy sekcja KONTEKST PROJEKTU jest pusta:

1. Uruchom `/init` — OpenCode automatycznie przeskanuje projekt i zaproponuje zawartosc
2. Jesli `/init` niedostepny: sprawdz `package.json`, `requirements.txt`, `pyproject.toml`, `Dockerfile`, `.env.example` i strukture folderow
3. Wywnioskuj cel biznesowy projektu
4. **NIE edytuj** `AGENTS.md` od razu
5. Napisz raport w czacie: Tytul, Opis, Stack, Kluczowe zaleznosci
6. Dolacz liste pytan o brakujace informacje
7. Zapytaj: _"Czy zatwierdzasz ten opis?"_
8. **Dopiero po akceptacji** — edytuj sekcje Kontekst projektu

---

## 9. Dokumentacja

- `docs/guides/` — referencje (debugging, MCP, agent workflows)
- `docs/decisions/` — decyzje architektoniczne (ADR)
- `docs/tasks/` — zadania i tracking
- `docs/context/` — kontekst projektu, notatki, specki

---

## 10. Agency Agents — Orkiestracja (144+ specjalistow)

### Architektura

```
[Orchestrator]  [team-engineering]  [team-design]  [team-qa]  ...  [Forge]
  (CTO-level)      (div. lead)        (div. lead)   (div. lead)   (niezalezny)
       |                |                  |
   ALL agents      eng agents +       design agents
                  debugger, explorer
```

**Orchestrator** — analizuje zadanie CTO-style i deleguje do team-* lub bezposrednio do @agency-*. Wywolanie: `@orchestrator`.

**Team-* agents** — division leads znajakace TYLKO swoich agentow. Wywolanie: `@team-engineering`, `@team-design`, etc.

**Forge** — niezalezny meta-agent do tworzenia nowych agentow/skills/komend. NIE podlega orkiestracji.

### Wzorce delegacji

**Sequential:** `@agency-software-architect → @agency-backend-architect → @agency-code-reviewer → @agency-api-tester`

**Parallel:** `@agency-frontend-developer + @agency-backend-architect (jednoczesnie)`

**Research first:** `@agency-codebase-explorer → @agency-[specialist] → @agency-reality-checker`

### Dywizje

| Team agent | Dywizja | Przyklady agentow |
|------------|---------|-------------------|
| @team-engineering | Engineering | Frontend Developer, Backend Arch, Software Arch, Security Eng, DevOps, AI Engineer |
| @team-design | Design | UX Architect, UI Designer, Brand Guardian, Accessibility Auditor |
| @team-qa | QA/Testing | API Tester, Performance Benchmarker, Reality Checker |
| @team-product | Product | Sprint Prioritizer, Feedback Synthesizer, Trend Researcher |
| @team-project-mgmt | Project Mgmt | Project Shepherd, Studio Producer, Senior PM |
| @team-marketing | Marketing | SEO Specialist, Content Creator, Growth Hacker |
| @team-sales | Sales | Deal Strategist, Sales Engineer, Pipeline Analyst |
| @team-paid-media | Paid Media | PPC Strategist, Paid Social Strategist, Ad Creative |
| @team-game-dev | Game Dev | Unity Architect, Unreal Eng, Godot Scripter, Game Designer |
| @team-spatial | Spatial | visionOS Spatial Eng, XR Developer, XR Interface Arch |
| @team-specialized | Specialized+Support | MCP Builder, AI Engineer, Technical Writer |

Pelny katalog: `docs/context/agency-agents-catalog.md`

Sync: `bash scripts/sync-agents.sh` (pobiera najnowsza wersje + regeneruje team-* i orchestrator)

---

## Kontekst projektu

<!-- DO UZUPELNIENIA: Agent wypelnia te sekcje po inicjalizacji projektu.
Format:
- Tytul:
- Opis:
- Stack:
- Kluczowe zaleznosci:
- Notatki: -->
