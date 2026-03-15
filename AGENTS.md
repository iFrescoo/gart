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

### Agenci (11 — `.opencode/agents/`)

| Agent              | Rola                                         | Wywolanie        |
| ------------------ | -------------------------------------------- | ---------------- |
| `forge`            | Meta-agent — tworzy agentow, skille, komendy | `/agent forge`   |
| `code-reviewer`    | Code review: jakosc, wzorce, DRY, SOLID      | `@code-reviewer` |
| `debugger`         | Analiza bledow, stack traces                 | `@debugger`      |
| `git-agent`        | Git workflow: commity, branching, PR          | `@git-agent`     |
| `test-runner`      | Testy: unit, integration, coverage           | `@test-runner`   |
| `refactor-agent`   | Refactoring: ekstrakcja, upraszczanie        | `@refactor-agent`|
| `security-auditor` | OWASP, secrets, SQL injection                | `@security-auditor` |
| `dependency-agent` | Aktualizacje, bezpieczenstwo zaleznosci      | `@dependency-agent` |
| `docs-writer`      | JSDoc, README, komentarze                    | `@docs-writer`   |
| `explorer`         | Research, websearch z cytowaniami            | `@explorer`      |
| `gh-search`        | GitHub code search                           | `@gh-search`     |

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

## Kontekst projektu

<!-- DO UZUPELNIENIA: Agent wypelnia te sekcje po inicjalizacji projektu.
Format:
- Tytul:
- Opis:
- Stack:
- Kluczowe zaleznosci:
- Notatki: -->
