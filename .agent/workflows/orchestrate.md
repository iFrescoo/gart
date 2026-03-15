---
name: orchestrate
description: Multi-agent orchestration workflow. Activates when a task requires specialist delegation across multiple domains. Guides through task decomposition and parallel agent invocation using available skills.
---

# Orchestration Workflow

## When to Activate

Activate this workflow when:
- Task requires expertise from multiple domains
- User explicitly asks to "use agents", "delegate", or "orchestrate"
- Task has phases: research → build → review → test
- Task is large enough to benefit from parallelization (3+ distinct subtasks)

## Phase 1: Analyze

Before delegating, understand:
1. What is the core goal? (not just the surface request)
2. What phases does this task have?
3. Which domains are involved?
4. Which tasks can run in parallel?

## Phase 2: Decompose

Break the task into subtasks by type:
1. **Research** — What do we need to know first? → agency-codebase-explorer or agency-github-code-searcher
2. **Design/Architecture** — What needs to be planned? → agency-software-architect or agency-ux-architect
3. **Implementation** — What needs to be built? → domain-specific specialists
4. **Review/Test** — What needs to be verified? → agency-code-reviewer, agency-api-tester, agency-reality-checker

## Phase 3: Route to Specialists

| Task Type | Specialist Skill |
|-----------|-----------------|
| Codebase exploration | agency-codebase-explorer |
| GitHub code examples | agency-github-code-searcher |
| Frontend implementation | agency-frontend-developer |
| Backend implementation | agency-backend-architect |
| Architecture design | agency-software-architect |
| Security review | agency-security-engineer |
| DevOps / CI/CD | agency-devops-automator |
| API testing | agency-api-tester |
| Performance testing | agency-performance-benchmarker |
| UI/UX design | agency-ux-architect |
| Code review | agency-code-reviewer |
| Documentation | agency-technical-writer |
| Database design | agency-database-optimizer |
| AI/ML features | agency-ai-engineer |
| MCP server | agency-mcp-builder |
| Debugging | agency-debugger |
| Dependency management | agency-dependency-auditor |
| Content creation | agency-content-creator |
| SEO | agency-seo-specialist |
| Game development | agency-unity-architect or agency-unreal-systems-engineer |

## Phase 4: Execute

**Independent tasks:** Invoke skills in parallel (Gemini supports async agent activation)

**Dependent tasks:** Invoke sequentially — wait for each to complete before the next

**Example — "Build a REST API":**
1. [parallel] agency-software-architect (design) + agency-codebase-explorer (explore existing code)
2. [sequential] agency-backend-architect (implement based on design)
3. [parallel] agency-security-engineer (security review) + agency-api-tester (test endpoints)
4. [sequential] agency-technical-writer (document the API)

## Phase 5: Synthesize

After all agents complete:
1. Collect all outputs
2. Identify any conflicts, gaps, or dependencies
3. Combine into a coherent result
4. Present to user with a summary of what each agent contributed
5. Ask if additional specialists are needed

## Rules

- Always research before implementing
- Run independent tasks in parallel to save time
- Never skip the review phase for code changes
- Document which agents were used and what each contributed
- If an agent's output is incomplete → re-invoke that specialist
