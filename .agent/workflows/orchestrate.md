---
name: orchestrate
description: Multi-agent orchestration workflow. Activates when a task requires specialist delegation across multiple domains. Guides through task decomposition and parallel agent invocation.
---

# Orchestration Workflow

## When to Activate

- Task requires expertise from multiple domains
- User asks to "use agents", "delegate", or "orchestrate"
- Task has phases: research → build → review → test
- Task is large enough to benefit from parallelization

## Phase 1: Decompose

Break the task into subtasks by type:
1. Research (→ agency-codebase-explorer / agency-github-code-searcher)
2. Design / Architecture (→ agency-software-architect / agency-ux-architect)
3. Implementation (→ specialist agents per domain)
4. Review / Test (→ agency-code-reviewer / agency-api-tester / agency-reality-checker)

## Phase 2: Route to Specialists

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
| Performance | agency-performance-benchmarker |
| UI/UX design | agency-ux-architect |
| Code review | agency-code-reviewer |
| Documentation | agency-technical-writer |
| Database design | agency-database-optimizer |
| AI/ML features | agency-ai-engineer |
| MCP server | agency-mcp-builder |
| Debugging | agency-debugger |

## Phase 3: Execute

- Independent tasks: invoke skills in parallel
- Dependent tasks: invoke sequentially
- Always research before implementing
- Always review/test after implementing

## Phase 4: Synthesize

1. Collect all agent outputs
2. Identify conflicts or gaps
3. Present unified result to user
4. Ask if additional specialists are needed
