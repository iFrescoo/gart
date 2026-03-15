---
name: subagent-driven-development
description: Use when executing implementation plans with independent tasks in the current session
---

# Subagent-Driven Development

Execute plan by dispatching fresh subagent per task, with two-stage review after each: spec compliance review first, then code quality review.

**Why subagents:** You delegate tasks to specialized agents with isolated context. By precisely crafting their instructions and context, you ensure they stay focused and succeed at their task. They should never inherit your session's context or history — you construct exactly what they need. This also preserves your own context for coordination work.

**Core principle:** Fresh subagent per task + two-stage review (spec then quality) = high quality, fast iteration

## When to Use

Use when you have an implementation plan AND tasks are mostly independent AND staying in current session.

**vs. Manual execution:**
- Subagents follow TDD naturally
- Fresh context per task (no confusion)
- Review checkpoints automatic

**vs. Parallel sessions:**
- Same session (no handoff)
- Continuous progress (no waiting)

## The Process

1. **Read plan, extract all tasks** with full text, note context, create TodoWrite
2. **Per task:**
   - Dispatch implementation subagent with full task text + context
   - Answer questions before proceeding (not during)
   - Implementer implements, tests, commits, self-reviews
   - Dispatch spec compliance reviewer (does code match spec?)
   - If issues: implementer fixes → re-review until ✓
   - Dispatch code quality reviewer
   - If issues: implementer fixes → re-review until ✓
   - Mark task complete in TodoWrite
3. After all tasks: Dispatch final code reviewer for entire implementation
4. Use superpowers:finishing-a-development-branch

## Model Selection

Use the least powerful model that can handle each role:

- **Mechanical tasks** (isolated functions, clear specs, 1-2 files) → fast/cheap model
- **Integration tasks** (multi-file, pattern matching, debugging) → standard model
- **Architecture/review tasks** → most capable model

## Handling Implementer Status

**DONE:** Proceed to spec compliance review.

**DONE_WITH_CONCERNS:** Read concerns before proceeding. If about correctness/scope, address before review.

**NEEDS_CONTEXT:** Provide missing context, re-dispatch.

**BLOCKED:**
1. Context problem → provide context, re-dispatch with same model
2. Needs more reasoning → re-dispatch with more capable model
3. Task too large → break into smaller pieces
4. Plan wrong → escalate to human

**Never** ignore an escalation or force same model to retry without changes.

## Red Flags

**Never:**
- Skip reviews (spec compliance OR code quality)
- Proceed with unfixed issues
- Dispatch multiple implementation subagents in parallel (conflicts)
- Make subagent read plan file (provide full text instead)
- Accept "close enough" on spec compliance
- **Start code quality review before spec compliance is ✓**
- Move to next task while either review has open issues

**If subagent asks questions:** Answer clearly and completely before letting them proceed.

**If reviewer finds issues:** Implementer fixes → reviewer reviews again → repeat until approved.

## Integration

**Required workflow skills:**
- **superpowers:writing-plans** — Creates the plan this skill executes
- **superpowers:finishing-a-development-branch** — Complete development after all tasks

**Subagents should use:**
- **superpowers:test-driven-development** — TDD for each task
- **superpowers:systematic-debugging** — When encountering bugs
