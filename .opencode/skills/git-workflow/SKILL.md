---
name: git-workflow
description: Procedura commitowania i pushowania przy równoległej pracy wielu agentów. Załaduj ten skill zanim wykonasz jakąkolwiek operację git która modyfikuje zdalny branch.
---

## Problem który rozwiązuje ten skill

Gdy dwa agenty w dwóch terminalach pracują jednocześnie i oba spróbują zrobić `git push` na ten sam branch — jeden nadpisze pracę drugiego lub dostaniesz konflikt merge. Ten skill definiuje kolejkę przez `GIT LOCK` w `status.md`.

## Procedura przed git push (OBOWIĄZKOWA)

```
1. Odczytaj sekcję GIT LOCK w .opencode/status.md
2. Czy branch jest WOLNY?
   TAK → dopisz blokadę i przejdź do kroku 3
   NIE → STOP. Poczekaj aż Agent-[N] ustawi status FREE. Nie pushuj.
3. Dodaj wpis do GIT LOCK:
   | main | Agent-[N] | [timestamp] | LOCKED |
4. Wykonaj: git add → git commit → git push
5. Po udanym push zmień status na FREE lub usuń wiersz
```

## Format GIT LOCK w status.md

```markdown
# GIT LOCK

| Branch | Agent   | Od       | Status |
| ------ | ------- | -------- | ------ |
| main   | Agent-1 | 10:32:05 | LOCKED |
```

## Zasady commitowania

- Jeden agent = jeden commit = jedno konkretne zadanie
- Format commita: `[Agent-N] krótki opis co zrobiono`
- Przykład: `[Agent-2] fix: walidacja formularza logowania`
- Nigdy nie commituj plików które są LOCKED w FILE LOCK TABLE przez innego agenta

## Co robić gdy branch jest zajęty

Nie czekaj bezczynnie. Kontynuuj pracę lokalnie — commituj do lokalnego repo (`git commit` bez `push`). Gdy GIT LOCK się zwolni, pushnij wszystkie zalegające commity naraz.
