---
name: mgrep-search
description: Jak używać mgrep (semantyczny MCP) do szybkiego znajdowania kodu w projekcie. Załaduj ten skill zanim zaczniesz szukać czegokolwiek w codebase.
---

## Czym jest mgrep

mgrep to semantyczna wyszukiwarka kodu dostępna jako serwer MCP. W przeciwieństwie do zwykłego `grep` (który szuka dokładnego tekstu), mgrep rozumie **znaczenie** zapytania. Możesz zapytać "gdzie jest logika autoryzacji" zamiast zgadywać nazwę funkcji.

**Kluczowa przewaga nad wbudowanym grep:** mgrep widzi pliki które są w `.gitignore` (`node_modules/`, `dist/`, `build/`). Wbudowany `grep`, `glob` i `list` używają ripgrep który te foldery pomija. Jeśli szukasz czegoś co może być w zależnościach lub folderze build — tylko mgrep to znajdzie.

## Kiedy używać mgrep (ZAWSZE jako pierwsze)

- Nie wiesz w którym pliku jest dana logika
- Chcesz znaleźć wszystkie miejsca gdzie coś jest wywoływane
- Szukasz "błędów walidacji formularza" bez znajomości nazw funkcji
- Chcesz zrozumieć architekturę przed edycją

## Jak używać

Wywołaj narzędzie mgrep z zapytaniem w języku naturalnym lub technicznym:

```
użyj mgrep żeby znaleźć: "logika uwierzytelniania użytkownika"
użyj mgrep żeby znaleźć: "obsługa błędów płatności"
użyj mgrep żeby znaleźć: "AuthService"
```

## Hierarchia — kiedy co używać

| Sytuacja                                        | Narzędzie                            |
| ----------------------------------------------- | ------------------------------------ |
| Nie wiem gdzie to jest                          | **mgrep** najpierw                   |
| Znam symbol, chcę zobaczyć definicję/referencje | **lsp** (go to def, find references) |
| Znam dokładny string/regex                      | `grep`                               |
| Znam wzorzec ścieżki                            | `glob`                               |
| Znam już plik, chcę go przeczytać               | `read`                               |
| Szukam w node_modules / dist / build            | **mgrep** (grep tego nie widzi)      |

## Zasada

Nigdy nie czytaj plików po kolei w poszukiwaniu czegoś. Jeden mgrep zastępuje czytanie dziesiątek plików i oszczędza tokeny.
