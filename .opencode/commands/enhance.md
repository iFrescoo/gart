---
description: Route to the right improvement skill — optimize, harden, polish, or distill
agent: build
---

# Enhance

**This is a ROUTER** — it analyzes code and delegates to specialist skills.

## When to Use

- User says "enhance", "improve", "refactor", "optimize", "clean up"
- Code works but needs quality improvement

## Routing Table

| Signal                                                 | Type               | Route To         |
| ------------------------------------------------------ | ------------------ | ---------------- |
| Slow execution, large bundle, redundant operations     | **Performance**    | `optimize` skill |
| Missing error handling, no i18n, edge cases unhandled  | **Resilience**     | `harden` skill   |
| Inconsistent spacing, misaligned elements, rough edges | **Visual polish**  | `polish` skill   |
| Over-engineered, too many abstractions, hard to follow | **Simplification** | `distill` skill  |
| Boring/flat UI, lacks personality                      | **Delight**        | `delight` skill  |
| Unclear labels, confusing copy, bad error messages     | **Clarity**        | `clarify` skill  |
| Color issues, monochromatic, poor contrast             | **Color**          | `colorize` skill |
| No animations, static transitions                      | **Motion**         | `animate` skill  |

## Process

1. **Analyze** — read target code, classify improvement type
2. **Route** — invoke appropriate skill(s). If multiple: distill → harden → optimize → polish
3. **Execute** — run the selected skill(s) with target files as context
4. **Validate** — verify enhancement, run `tsc --noEmit`, run tests, confirm no regressions
