---
name: enhance
description: Enhancement routing workflow. Analyzes code to detect what type of improvement is needed, then delegates to the appropriate specialist skill (optimize, harden, polish, distill). Does NOT implement enhancements itself.
---

# Enhance Workflow

## When to Activate

- User says "enhance", "improve", "refactor", "optimize", "clean up", "make better"
- Code works but needs quality improvement
- User asks for general code improvement without specifying type

## Important: This is a ROUTER

This workflow does NOT implement enhancements directly. It analyzes the code, detects the type of improvement needed, and delegates to existing specialist skills.

## Phase 1: Analyze

Read the target code and classify the improvement type:

| Signal                                                 | Enhancement Type   | Route To         |
| ------------------------------------------------------ | ------------------ | ---------------- |
| Slow execution, large bundle, redundant operations     | **Performance**    | `optimize` skill |
| Missing error handling, no i18n, edge cases unhandled  | **Resilience**     | `harden` skill   |
| Inconsistent spacing, misaligned elements, rough edges | **Visual polish**  | `polish` skill   |
| Over-engineered, too many abstractions, hard to follow | **Simplification** | `distill` skill  |
| Boring/flat UI, lacks personality                      | **Delight**        | `delight` skill  |
| Unclear labels, confusing copy, bad error messages     | **Clarity**        | `clarify` skill  |
| Color issues, monochromatic, poor contrast             | **Color**          | `colorize` skill |
| No animations, static transitions                      | **Motion**         | `animate` skill  |

## Phase 2: Route

Based on analysis, invoke the appropriate skill(s):

- **Single type detected** → invoke that one skill
- **Multiple types detected** → invoke skills in this order:
  1. `distill` (simplify first)
  2. `harden` (make resilient)
  3. `optimize` (make fast)
  4. `polish` (make beautiful)

## Phase 3: Execute

Invoke the selected skill(s). Pass the target files/components as context.

## Phase 4: Validate

After skill execution:

1. Verify the enhancement was applied correctly
2. Run `tsc --noEmit` if TypeScript
3. Run tests if they exist
4. Confirm no regressions were introduced
