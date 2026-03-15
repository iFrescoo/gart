# MCP — Docker Gateway Reference

Centralny gateway łączący IDE z ekosystemem MCP.

**Komenda:** `docker-mcp.exe gateway run --verify-signatures`

## Aktywne serwery

| Serwer               | Tools    | Opis                                   |
| -------------------- | -------- | -------------------------------------- |
| `ast-grep`           | 1        | AST-based structural code search       |
| `atlas-docs`         | 5        | MongoDB Atlas dokumentacja             |
| `context7`           | 2        | Dokumentacja bibliotek na żywo         |
| `docker-hub`         | 13       | Docker Hub — obrazy, tagi, wersje      |
| `fetch`              | 1+1p     | Pobieranie stron, web scraping         |
| `filesystem`         | 11       | Operacje na plikach                    |
| `git`                | 12       | Git operacje                           |
| `github-official`    | 41+2p+5r | GitHub API                             |
| `hugging-face`       | 10+4p    | Hugging Face hub                       |
| `markdownify`        | 11       | Konwersja do markdown                  |
| `memory`             | 9        | Persystentna pamięć (knowledge graph)  |
| `npm-sentinel`       | 19+2r    | NPM analiza paczek                     |
| `paper-search`       | 8        | Wyszukiwanie publikacji naukowych      |
| `playwright`         | 22       | Browser automation (headless)          |
| `ref`                | —        | Dokumentacja (API key wymagany)        |
| `semgrep`            | —        | SAST — code security scanning          |
| `sequentialthinking` | 1        | Strukturalne rozumowanie krok-po-kroku |
| `sqlite-mcp-server`  | —        | SQLite operacje                        |
| `wolfram-alpha`      | —        | Obliczenia matematyczne                |
| `youtube_transcript` | —        | Transkrypcje YouTube                   |

## Dynamic MCP (meta-narzędzia)

Gateway eksponuje 5 meta-narzędzi zawsze dostępnych:

| Narzędzie        | Opis                                                              |
| ---------------- | ----------------------------------------------------------------- |
| `mcp-find`       | Szukaj w katalogu 316+ serwerów po nazwie/opisie                  |
| `mcp-exec`       | Wywołaj narzędzie z dowolnego serwera bez dodawania do sesji      |
| `mcp-add`        | Dodaj serwer do bieżącej sesji (zwiększa liczbę tools)           |
| `mcp-remove`     | Usuń serwer z sesji                                               |
| `mcp-config-set` | Ustaw wartość konfiguracyjną serwera                              |

`mcp-exec` — kluczowe dla IDE z limitem narzędzi (omija limit bez dodawania do sesji).

## Flagi gateway

| Flaga                 | Opis                                             |
| --------------------- | ------------------------------------------------ |
| `--verify-signatures` | Weryfikacja podpisów i attestacji obrazów Docker  |
| `--servers <nazwa>`   | Filtruje serwery — ogranicza liczbę tools         |
| `--log-calls`         | Audit log wywołań narzędzi (domyślnie on)         |

## Znane problemy

| Problem                         | Rozwiązanie                                                       |
| ------------------------------- | ----------------------------------------------------------------- |
| "Failed to connect" w IDE       | Użyj pełnej ścieżki `docker-mcp.exe`, dodaj env vars Windows     |
| Timeout >30s                    | `MCP_TIMEOUT=60000` jako zmienna środowiskowa użytkownika Windows |
| "N tools exceeds limit"         | Użyj `--servers` do filtrowania; `mcp-exec` dla rzadko używanych  |
| Serwer crashuje z EOF           | Sprawdź wymagane API keys w Docker Desktop → Configure            |
