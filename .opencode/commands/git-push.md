---
description: Bezpieczny git push po zatwierdzeniu przez użytkownika
agent: git-agent
subtask: true
model: google/gemini-3.1-pro-preview-customtools
---

Wykonaj git push zgodnie z procedurą z skills/git-workflow.

Aktualny stan repo:
!`git status`

Ostatnie commity do wypchnięcia:
!`git log --oneline origin/HEAD..HEAD`

Instrukcja:
1. Sprawdź powyższy status i listę commitów
2. Potwierdź z użytkownikiem które commity pushować
3. Branch do pusha: $ARGUMENTS (jeśli puste — użyj aktualnego brancha)
4. Wykonaj push po zatwierdzeniu
