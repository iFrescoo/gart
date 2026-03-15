---
name: project-context
description: Kontekst projektu — Agentic Coding Template
---

# Agentic Coding Template — Kontekst

Reużywalny workspace do orkiestracji agentów AI.
Działa z **OpenCode** (CLI), **Claude Code** (CLI) i **AntiGravity IDE**.

## Kluczowe zasady

- **NIGDY** nie generuj całego pliku dla małych zmian
- Zanim wygenerujesz długie rozwiązanie — napisz plan i zapytaj
- Zanim usuniesz plik — **zapytaj użytkownika**
- Nie instaluj zależności bez zgody
- Nie ma systemu status.md — działaj bezpośrednio

## Dostępne skills (workspace)

**Workflow (7):** brainstorming, git-workflow, lsp-navigator, mgrep-search, subagent-driven-development, systematic-debugging, writing-plans

**Impeccable Design (18):** adapt, animate, audit, bolder, clarify, colorize, critique, delight, distill, extract, frontend-design, harden, normalize, onboard, optimize, polish, quieter, teach-impeccable

Skills workspace znajdują się w `.opencode/skills/` — dodaj tę ścieżkę do AntiGravity Skill Custom Paths.

## Agenci projektowi (11)

Definicje w `.opencode/agents/`: forge (primary), code-reviewer, debugger, git-agent, test-runner, refactor-agent, security-auditor, dependency-agent, docs-writer, explorer, gh-search.

## MCP Serwery

mgrep (semantic search), context-mode, gh_grep (GitHub search), memory, playwright, github, sequential-thinking.

## Jeśli rozwijasz template

- Sprawdź `forge.md` przy zmianie agenta
- Dokumentuj decyzje w `docs/management/decisions.md`
- Aktualizuj `docs/management/kanban.md`
