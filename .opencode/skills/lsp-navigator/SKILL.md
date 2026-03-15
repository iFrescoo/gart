---
name: lsp-navigator
description: Jak używać narzędzia LSP do inteligentnej nawigacji po kodzie. Załaduj gdy potrzebujesz znaleźć definicję funkcji, wszystkie miejsca gdzie coś jest używane, lub prześledzić hierarchię wywołań.
---

## Czym jest LSP w OpenCode

LSP (Language Server Protocol) to narzędzie które rozumie **strukturę kodu** — nie szuka tekstu, tylko rozumie typy, klasy, importy i zależności między symbolami. Dostępne jako narzędzie `lsp` w OpenCode.

**Wymóg:** Musi być ustawiona zmienna środowiskowa `OPENCODE_EXPERIMENTAL_LSP_TOOL=true` (lub `OPENCODE_EXPERIMENTAL=true`).

## Kiedy używać LSP (po mgrep, przed grep)

| Cel                                        | Operacja LSP         |
| ------------------------------------------ | -------------------- |
| Gdzie jest zdefiniowana ta funkcja/klasa   | `goToDefinition`     |
| Gdzie jest UŻYWANY ten symbol w projekcie  | `findReferences`     |
| Co ta funkcja przyjmuje i zwraca           | `hover`              |
| Jakie metody/właściwości ma ten plik/klasa | `documentSymbol`     |
| Znajdź wszystkie symbole pasujące do nazwy | `workspaceSymbol`    |
| Gdzie jest zaimplementowany ten interfejs  | `goToImplementation` |
| Co wywołuje tę funkcję (kto jej używa)     | `incomingCalls`      |
| Co ta funkcja wywołuje wewnątrz            | `outgoingCalls`      |

## Typowy workflow przy refaktoringu (równoległa praca)

```
1. mgrep → znajdź plik który chcesz zmienić
2. lsp goToDefinition → sprawdź pełną definicję
3. lsp findReferences → znajdź WSZYSTKIE miejsca które używają tego symbolu
4. lsp incomingCalls → kto wywołuje tę funkcję (żeby wiedzieć co się posypie)
5. Dopiero teraz: zablokuj pliki w FILE LOCK TABLE i edytuj
```

## Dlaczego to ważne przy równoległej pracy

Jeśli Agent-1 i Agent-2 pracują jednocześnie nad różnymi plikami, a oba wywołują tę samą funkcję — `lsp findReferences` pokaże Ci wszystkie zależności zanim zaczniesz edycję. Bez tego ryzykujesz że zmiana w jednym pliku posypie pracę drugiego agenta.

## Jak wywołać

```
użyj lsp żeby znaleźć wszystkie referencje do: AuthService.login
użyj lsp żeby przejść do definicji: UserRepository
użyj lsp żeby pokazać incoming calls dla: processPayment
```
