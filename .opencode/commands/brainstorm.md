---
description: Structured ideation — explore 3+ approaches with pros/cons before implementation
agent: build
---

# Brainstorm

## When to Use

- Task is ambiguous or has multiple valid approaches
- User says "brainstorm", "explore ideas", "think through options"
- Picking the wrong approach has high cost

## Process

### 1. Read Context

Explore the project — stack, architecture, existing patterns, constraints.

### 2. Clarify Intent (skip if requirements are clear)

Ask 3 targeted questions:

1. **Scope** — What exactly needs to be solved? What's out of scope?
2. **Constraints** — Performance targets, compatibility, timeline?
3. **Success criteria** — How will we know the solution works?

### 3. Explore 3+ Approaches

For each approach, provide:

| Aspect           | Details                             |
| ---------------- | ----------------------------------- |
| **Name**         | Short, descriptive label            |
| **How it works** | 2-3 sentence explanation            |
| **Pros**         | Advantages                          |
| **Cons**         | Disadvantages                       |
| **Effort**       | Low / Medium / High                 |
| **Best when**    | Scenario where this approach shines |

### 4. Recommend

State the recommended approach with reasoning. If two are equally valid, present both and ask the user to decide.

### 5. Transition

- **Complex** → transition to plan mode
- **Simple** → proceed directly to coding
- **Need more exploration** → loop back with refined constraints
