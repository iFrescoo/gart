---
name: brainstorm
description: Structured ideation workflow. Activates when a task is ambiguous or benefits from exploring multiple approaches before implementation. Generates 3+ options with pros/cons, then transitions to planning or execution.
---

# Brainstorm Workflow

## When to Activate

- User says "brainstorm", "explore ideas", "think through options", "what are our options"
- Task is ambiguous — contains "maybe", "could", "should we", "what if"
- Multiple valid approaches exist and picking wrong one has high cost
- User explicitly asks to compare approaches before coding

## Phase 1: Read Context

1. Explore the project — stack, architecture, existing patterns
2. Identify constraints: tech stack, performance requirements, team conventions
3. Check for prior art — has this problem been solved elsewhere in the codebase?

## Phase 2: Clarify Intent

Ask 3 targeted questions before exploring options:

1. **Scope** — What exactly needs to be solved? What's out of scope?
2. **Constraints** — Performance targets, compatibility, timeline, budget?
3. **Success criteria** — How will we know the solution works?

Skip this phase if the user already provided clear requirements.

## Phase 3: Explore 3+ Approaches

For each approach, provide:

| Aspect           | Details                                               |
| ---------------- | ----------------------------------------------------- |
| **Name**         | Short, descriptive label                              |
| **How it works** | 2-3 sentence explanation                              |
| **Pros**         | Advantages (performance, simplicity, maintainability) |
| **Cons**         | Disadvantages (complexity, limitations, risk)         |
| **Effort**       | Low / Medium / High                                   |
| **Best when**    | Scenario where this approach shines                   |

## Phase 4: Recommend

1. State the recommended approach with reasoning
2. Explain why alternatives were ranked lower
3. Note any risks and mitigations for the chosen approach
4. If two approaches are equally valid, present both and ask the user to decide

## Phase 5: Transition

Chain to the next step based on user decision:

- **Complex implementation** → transition to `/plan` mode for detailed planning
- **Simple implementation** → proceed directly to coding
- **Need more exploration** → loop back to Phase 3 with refined constraints
- **User picks different approach** → accept and proceed with their choice
