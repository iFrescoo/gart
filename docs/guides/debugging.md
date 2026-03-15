# Protokół Debugowania

Przy trudnych bugach stosuj ten flow:

## Krok 1 — Reprodukcja

- Stwórz minimalny przypadek reprodukcji
- Udokumentuj dokładne kroki do wywołania buga
- Sprawdź wersje: OS, Node, framework, zależności

## Krok 2 — Izolacja

- Binary search: wyłącz połowę kodu/feature
- `git bisect` — kiedy bug został wprowadzony?
- Usuń zależności jedna po drugiej

## Krok 3 — Inspekcja

- Strategiczne `console.log` lub debugger statements
- Sprawdź network requests i responses
- Przejrzyj ostatnie zmiany w `git log`
- `lsp hover` dla typów, `lsp findReferences` dla przepływu danych

## Krok 4 — Hipoteza

- Sformułuj teorię — root cause, nie symptom
- Sprawdź race conditions i timing issues
- Przetestuj każde założenie osobno

## Krok 5 — Fix i Weryfikacja

- Przetestuj fix dokładnie
- Dodaj regression test
- Udokumentuj root cause w komentarzu lub commit message

## Krok 6 — Prewencja

- Lepszy error handling
- Lepsze logowanie
- Testy edge case'ów
