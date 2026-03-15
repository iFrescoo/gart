# Zasady — Claude Code

## 1. Zasady pracy

- **NIGDY** nie generuj calego pliku dla malych zmian — edytuj konkretne linie
- Zanim wygenerujesz dlugie rozwiazanie — napisz plan w 2-3 zdaniach i zapytaj: _"Czy mam isc w tym kierunku?"_
- Zanim usuniesz plik lub wykonasz destrukcyjna komende — **zapytaj uzytkownika**
- Nie instaluj zaleznosci bez zgody
- Nie halucynuj. Jesli czegos nie wiesz: `"Nie wiem, potrzebuje wiecej kontekstu o [X]"`
- Nie ma systemu lock plikow — dzialaj bezposrednio

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

1. **Grep** — dokladny string/regex po plikach
2. **Glob** — wzorce sciezek, struktura folderow
3. **Read** — gdy juz wiesz ktory plik
4. **LSP** — goToDefinition, findReferences, hover, documentSymbol, getDiagnostics (11 jezykow)

> ZAKAZ: Nie czytaj plikow po kolei w poszukiwaniu czegos. Najpierw znajdz przez Grep, potem czytaj.

---

## 4. Narzedzia MCP

| Serwer         | Rola                                                       |
| -------------- | ---------------------------------------------------------- |
| `context-mode` | Ochrona context window — indeksuj duze outputy w sandboxie |
| `MCP_DOCKER`   | Docker MCP Gateway — pelny zestaw serwerow                 |

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

---

## 5. Skills, subagenci i automatyzacje

### Skills (18 — `.claude/skills/`)

Wywoluj przez `Skill` tool:

`adapt`, `animate`, `audit`, `bolder`, `clarify`, `colorize`, `critique`, `delight`, `distill`, `extract`, `frontend-design`, `harden`, `normalize`, `onboard`, `optimize`, `polish`, `quieter`, `teach-impeccable`

### Subagenci wbudowani

| Subagent          | Kiedy uzywac                                                  |
| ----------------- | ------------------------------------------------------------- |
| `Explore`         | Szybka eksploracja codebase (pliki, wzorce, architektura)     |
| `Plan`            | Projektowanie planu implementacji                             |
| `General-purpose` | Zlozone, wieloetapowe zadania wymagajace autonomii            |

### Plan Mode

Tryb planowania: `explore -> plan -> code`. Uzywaj do zlozonych zadan — najpierw zbadaj, zaplanuj, potem implementuj.

### Hooks (`.claude/hooks/`)

Shell commands wykonywane automatycznie w odpowiedzi na eventy (np. blokowanie niebezpiecznych komend). Konfiguracja w `.claude/settings.json`.

### Scoped rules (`.claude/rules/`)

Instrukcje per jezyk lub sciezka — ladowane automatycznie gdy Claude pracuje z pasujacymi plikami.

### Auto-memory

Automatyczne zapamietywanie wzorc i preferencji uzytkownika miedzy sesjami. Pliki w `~/.claude/projects/<projekt>/memory/`.

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

## Kontekst projektu

<!-- DO UZUPELNIENIA: Agent wypelnia te sekcje po inicjalizacji projektu.
Format:
- Tytul:
- Opis:
- Stack:
- Kluczowe zaleznosci:
- Notatki: -->
