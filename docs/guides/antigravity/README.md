# AntiGravity IDE Guide

Configuration and capabilities for AntiGravity IDE in this project.

**Entry point:** `GEMINI.md` — project instructions, loaded automatically when the folder is opened.

## Agent Workflows

### Invoking Agents

AntiGravity uses skills as the primary agent abstraction. Skills are invoked via the IDE's skill palette or referenced directly in conversations.

| Skill category | Location            | Count    |
| -------------- | ------------------- | -------- |
| Engineering    | `.agent/skills/`    | 174+     |
| Design         | `.agent/skills/`    | included |
| Workflows      | `.agent/workflows/` | 14       |

### Workflow Patterns

1. **Direct task** — invoke a skill for a specific task (e.g., code review, debugging)
2. **Workflow** — multi-step process defined in `.agent/workflows/` (e.g., release workflow)
3. **Rules-guided** — rules in `.agent/rules/` constrain agent behavior per file type

## Skills (174+)

Located in `.agent/skills/`. Skills cover all engineering divisions:

| Division    | Examples                                                                           |
| ----------- | ---------------------------------------------------------------------------------- |
| Engineering | `backend-architect`, `frontend-developer`, `security-engineer`, `devops-automator` |
| AI/ML       | `ai-engineer`, `model-qa-specialist`, `data-engineer`                              |
| Design      | `ux-architect`, `ui-designer`, `visual-storyteller`                                |
| Game Dev    | `unity-architect`, `unreal-systems-engineer`, `godot-gameplay-scripter`            |
| Specialized | `mcp-builder`, `blockchain-auditor`, `technical-writer`                            |

## Rules (26)

Located in `.agent/rules/`. Applied based on file context:

| Rule             | Domain                           |
| ---------------- | -------------------------------- |
| `core.md`        | Core working principles          |
| `security.md`    | Security and OWASP guidelines    |
| `typescript.md`  | TypeScript conventions           |
| `react.md`       | React patterns                   |
| `testing.md`     | Test strategy and coverage       |
| `performance.md` | Performance optimization         |
| `git.md`         | Commit and branching conventions |
| `api-design.md`  | REST API design                  |

## Workflows (14)

Located in `.agent/workflows/`. Multi-step automated processes:

| Workflow      | Purpose                             |
| ------------- | ----------------------------------- |
| `code-review` | Structured code review pipeline     |
| `feature-dev` | Feature development from spec to PR |
| `debugging`   | Systematic debugging protocol       |
| `release`     | Release preparation and tagging     |

## MCP

AntiGravity IDE supports MCP via its plugin system. Refer to [`../mcp-reference.md`](../mcp-reference.md) for the Docker Gateway server catalog.
