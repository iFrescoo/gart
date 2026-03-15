# Zasady — AntiGravity IDE

Odpowiadaj **wylacznie po polsku**, chyba ze kod, komendy lub nazwy techniczne wymagaja angielskiego.

---

## 1. Zasady pracy

- **NIGDY** nie generuj calego pliku dla malych zmian. Uzywaj `// ... reszta kodu bez zmian ...`
- Badz **zwiezly i konkretny** — bez zbednego wypelniacza
- Zanim wygenerujesz dlugie rozwiazanie — napisz plan w 2-3 zdaniach i zapytaj: _"Czy mam isc w tym kierunku?"_
- Nie halucynuj. Jesli czegos nie wiesz: `"Nie wiem, potrzebuje wiecej kontekstu o [X]"`
- Jedno konkretne pytanie gdy potrzebujesz clarification — nie lista pieciu
- **Terminal:** Przed wykonaniem komendy — pokaz ja uzytkownikowi. Na koncu daj gotowa liste krokow (copy-paste ready) ze wskazaniem gdzie uruchomic: WSL, PowerShell, CMD lub terminal projektu.
- Komendy destrukcyjne — **ZAWSZE** pytaj o zgode
- Nie instaluj paczek bez jawnej zgody
- Nie ma systemu lock plikow — dzialaj bezposrednio

---

## 2. Generowanie kodu

- Minimalne, celowe zmiany — nie przepisuj tego co dziala
- Sprawdzaj importy — nie dodawaj duplikatow, nie zostawiaj nieuzywanych
- `// PRZED:` -> `// PO:` dla krytycznych zmian logiki
- Czysty kod: male funkcje, czytelne nazwy, brak magicznych liczb
- SOLID — szczegolnie Single Responsibility i Dependency Inversion
- TypeScript: strict mode, brak `any`, explicit return types dla funkcji publicznych
- Conventional Commits: `feat:` / `fix:` / `docs:` / `refactor:` / `test:` / `chore:`

---

## 3. Nawigacja po kodzie

1. **`mgrep`** (MCP) — zawsze jako pierwsze. Semantyczna szukajka: rozumie znaczenie, nie tylko tekst. Jedno zapytanie zamiast czytania 20 plikow. **Widzi pliki z `.gitignore` ktorych grep nie widzi.**
2. **`lsp`** — go to definition, find references, call hierarchy. Uzywaj gdy znasz juz symbol.
3. **`grep`** — dokladny string/regex. Uwaga: nie widzi plikow z `.gitignore`.
4. **`glob`** / **`list`** — struktura katalogow, wzorce sciezek.
5. **`read`** — czytaj plik tylko gdy juz wiesz ktory to i musisz zobaczyc zawartosc.

> ZAKAZ: Nie czytaj plikow po kolei w poszukiwaniu czegos. Najpierw znajdz przez mgrep/grep, potem czytaj.

---

## 4. Narzedzia MCP

| Serwer         | Rola                                                       |
| -------------- | ---------------------------------------------------------- |
| `mgrep`        | Semantic code search po projekcie                          |
| `context-mode` | Ochrona context window — indeksuj duze outputy w sandboxie |
| `gh_grep`      | GitHub code search (przez `@gh-search`)                    |
| `MCP_DOCKER`   | Docker MCP Gateway — pelny zestaw serwerow                 |

> AntiGravity ma limit 100 narzedzi. Uzywaj `--servers` do filtrowania i `mcp-exec` zamiast `mcp-add` dla rzadko uzywanych serwerow.

### MCP Docker — meta-narzedzia (zawsze dostepne)

| Narzedzie  | Opis                                                         |
| ---------- | ------------------------------------------------------------ |
| `mcp-find` | Szukaj w katalogu 316+ serwerow MCP po nazwie/opisie         |
| `mcp-exec` | Wywolaj narzedzie z dowolnego serwera bez dodawania do sesji |
| `mcp-add`  | Dodaj serwer do biezacej sesji                               |

### Przydatne serwery Docker MCP

- **context7** — dokumentacja bibliotek (`resolve-library-id` -> `query-docs`). Uzywaj zamiast halucynowania o API.
- **playwright** — browser automation gdy fetch nie wystarczy (SPA, JS-rendered, Cloudflare)
- **github-official** — GitHub API (issues, PR, commits, code search)
- **memory** — pamiec miedzy sesjami (`memory_store` / `memory_retrieve`)
- **sequential-thinking** — rozumowanie krok-po-kroku przy zlozonych problemach
- **docker-hub** — Docker Hub: obrazy, tagi, wersje

---

## 5. Skills i agenci

### Trzy poziomy automatyzacji AntiGravity

1. **Rules** (`.agent/rules/`) — instrukcje per jezyk/sciezka, ladowane automatycznie
2. **Skills** (`.agent/skills/`) — jednorazowe akcje wywolywane na zadanie
3. **Workflows** (`.agent/workflows/`) — wieloetapowe przeplywy laczace skille

### Workflow Skills (7 — `.opencode/skills/`)

`brainstorming`, `git-workflow`, `lsp-navigator`, `mgrep-search`, `subagent-driven-development`, `systematic-debugging`, `writing-plans`

### Impeccable Design Skills (18 — `.opencode/skills/` + `.claude/skills/`)

`adapt`, `animate`, `audit`, `bolder`, `clarify`, `colorize`, `critique`, `delight`, `distill`, `extract`, `frontend-design`, `harden`, `normalize`, `onboard`, `optimize`, `polish`, `quieter`, `teach-impeccable`

### Agenci (11 — `.opencode/agents/`)

| Agent              | Rola                                         |
| ------------------ | -------------------------------------------- |
| `forge`            | Meta-agent — tworzy agentow, skille, komendy |
| `code-reviewer`    | Code review: jakosc, wzorce, DRY, SOLID      |
| `debugger`         | Analiza bledow, stack traces                 |
| `git-agent`        | Git workflow: commity, branching, PR          |
| `test-runner`      | Testy: unit, integration, coverage           |
| `refactor-agent`   | Refactoring: ekstrakcja, upraszczanie        |
| `security-auditor` | OWASP, secrets, SQL injection                |
| `dependency-agent` | Aktualizacje, bezpieczenstwo zaleznosci      |
| `docs-writer`      | JSDoc, README, komentarze                    |
| `explorer`         | Research, websearch z cytowaniami            |
| `gh-search`        | GitHub code search                           |

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

**Debugowanie:** Pelny protokol w `docs/guides/debugging.md` (6 krokow: reprodukcja -> izolacja -> inspekcja -> hipoteza -> fix -> prewencja).

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

1. Sprawdz `package.json`, `requirements.txt`, `pyproject.toml`, `Dockerfile`, `.env.example` i strukture folderow
2. Wywnioskuj cel biznesowy projektu
3. Napisz raport w czacie: Tytul, Opis, Stack, Kluczowe zaleznosci
4. Dolacz liste pytan o brakujace informacje
5. Zapytaj: _"Czy zatwierdzasz ten opis?"_
6. **Dopiero po akceptacji** — edytuj sekcje Kontekst projektu

---

## 9. Dokumentacja

- `docs/guides/` — referencje (debugging, MCP, agent workflows)
- `docs/decisions/` — decyzje architektoniczne (ADR)
- `docs/tasks/` — zadania i tracking
- `docs/context/` — kontekst projektu, notatki, specki

---

## 10. Agency Agents (144+ specjalistow)

Zintegrowano 144+ agentow z [agency-agents](https://github.com/msitarzewski/agency-agents). Dostepni jako skills w `.agent/skills/agency-*/SKILL.md`.

| Dywizja | Przyklady agentow | Kiedy uzywac |
|---------|-------------------|--------------|
| Engineering | Frontend Developer, Backend Architect, Software Architect, DevOps, Security Engineer | Implementacja, architektura |
| Design | UX Architect, UI Designer, Brand Guardian, Accessibility Auditor | Projektowanie UI/UX |
| QA/Testing | API Tester, Performance Benchmarker, Reality Checker | Testowanie, audyty |
| Product | Sprint Prioritizer, Product Manager, Trend Researcher | Planowanie produktu |
| Project Mgmt | Project Shepherd, Studio Producer | Zarzadzanie projektem |
| Marketing | SEO Specialist, Content Creator, Growth Hacker | Marketing, content |
| Game Dev | Unity/Unreal/Godot Engineers, Game Designer | Tworzenie gier |

Pelny katalog: `docs/context/agency-agents-catalog.md`

Sync: `bash scripts/sync-agents.sh`

---

## Kontekst projektu

<!-- DO UZUPELNIENIA: Agent wypelnia te sekcje po inicjalizacji projektu.
Format:
- Tytul:
- Opis:
- Stack:
- Kluczowe zaleznosci:
- Notatki: -->
