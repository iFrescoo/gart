# Agent Workflows — jak agenci współpracują

## Dostępni agenci (`.opencode/agents/`)

| Agent              | Rola                                          | Wywołanie           |
| ------------------ | --------------------------------------------- | ------------------- |
| `forge`            | Meta-agent — tworzy agentów, skille, komendy  | `/agent forge`      |
| `code-reviewer`    | Code review: jakość, wzorce, DRY, SOLID       | `@code-reviewer`    |
| `debugger`         | Debugowanie: analiza błędów, stack traces      | `@debugger`         |
| `git-agent`        | Git workflow: commity, branching, opisy PR     | `@git-agent`        |
| `test-runner`      | Testy: unit, integration, coverage             | `@test-runner`      |
| `refactor-agent`   | Refactoring: ekstrakcja, upraszczanie          | `@refactor-agent`   |
| `security-auditor` | Bezpieczeństwo: OWASP, secrets, SQL injection  | `@security-auditor` |
| `dependency-agent` | Zależności: aktualizacje, bezpieczeństwo        | `@dependency-agent` |
| `docs-writer`      | Dokumentacja: JSDoc, README, komentarze        | `@docs-writer`      |
| `explorer`         | Research: websearch z cytowaniami              | `@explorer`         |
| `gh-search`        | GitHub code search                             | `@gh-search`        |

## Skills

### Workflow (7) — `.opencode/skills/`

| Skill                         | Kiedy użyć                                     |
| ----------------------------- | ---------------------------------------------- |
| `brainstorming`               | Przed rozpoczęciem nowej funkcjonalności        |
| `git-workflow`                | Commity, branching, PR                          |
| `lsp-navigator`               | Nawigacja po kodzie przez LSP                   |
| `mgrep-search`                | Semantyczne wyszukiwanie w kodzie               |
| `subagent-driven-development` | Delegowanie zadań do subagentów                 |
| `systematic-debugging`        | Strukturalne debugowanie                        |
| `writing-plans`               | Planowanie implementacji                        |

### Impeccable Design (18) — `.opencode/skills/` + `.claude/skills/`

`adapt`, `animate`, `audit`, `bolder`, `clarify`, `colorize`, `critique`, `delight`, `distill`, `extract`, `frontend-design`, `harden`, `normalize`, `onboard`, `optimize`, `polish`, `quieter`, `teach-impeccable`

## Delegowanie zadań

1. **Forge** deleguje do subagentów — nie wykonuje pracy sam
2. Subagent otrzymuje konkretne zadanie i zakres plików
3. Subagent raportuje wynik w chacie
4. Forge integruje wyniki i raportuje użytkownikowi

## Praca równoległa

- Przed edycją pliku — sprawdź czy inny agent go nie modyfikuje
- Przy konflikcie edycji — opisz problem i poczekaj na decyzję użytkownika
- Git push — zawsze po zatwierdzeniu użytkownika
