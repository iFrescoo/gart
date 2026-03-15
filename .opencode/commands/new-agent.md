---
description: Stwórz nowego agenta przez Forge. Użycie: /new-agent [opis specjalizacji]
agent: forge
subtask: true
model: google/gemini-3.1-pro-preview-customtools
---

Stwórz nowego agenta OpenCode o specjalizacji: $ARGUMENTS

Aktualna lista agentów żeby uniknąć duplikatów:
!`ls .opencode/agents/`

Postępuj zgodnie z procedurą tworzenia agenta z Twojego system promptu:

1. Na podstawie opisu "$ARGUMENTS" zaproponuj nazwę, mode (primary/subagent), temperaturę i kolor
2. Sprawdź czy podobny agent już istnieje na liście powyżej
3. Stwórz plik w `.opencode/agents/[nazwa].md` używając szablonu z Twojego systemu
4. Pokaż mi tylko nagłówek YAML gotowego agenta
