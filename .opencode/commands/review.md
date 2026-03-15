---
description: Uruchom code-review na aktualnych zmianach lub wskazanym pliku
agent: code-reviewer
subtask: true
model: google/gemini-3.1-pro-preview-customtools
---

Przeprowadź code review.

Ostatnie zmiany w repo:
!`git diff --stat HEAD`

Szczegółowy diff:
!`git diff HEAD`

Zbadaj powyższe zmiany i zwróć raport w formacie:

## ✅ OK
[co jest dobrze]

## ⚠️ Do poprawy
[plik:linia] — opis problemu → sugerowany fix

## 🔴 Krytyczne
[plik:linia] — opis problemu → sugerowany fix

Jeśli przekazano argument, skup się tylko na tym pliku: $ARGUMENTS
