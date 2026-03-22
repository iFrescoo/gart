# Plugins and Extensions

Extension systems available across Claude Code, OpenCode, and AntiGravity IDE.

## Claude Code

### Skills (`/skill-name`)

Reusable, invocable workflows defined in `.claude/skills/`. Each skill is a markdown prompt that guides Claude through a specific task.

```
/polish          # Final quality pass before shipping
/audit           # Comprehensive interface quality audit
/harden          # Improve error handling and edge cases
/optimize        # Performance analysis and improvements
/critique        # UX effectiveness evaluation
```

Full list: `adapt`, `animate`, `audit`, `bolder`, `clarify`, `colorize`, `critique`, `delight`, `distill`, `extract`, `frontend-design`, `harden`, `normalize`, `onboard`, `optimize`, `polish`, `quieter`, `teach-impeccable`

### MCP Servers

Extend Claude's capabilities with tools. Configured in `.mcp.json`. See [mcp-reference.md](mcp-reference.md).

### Hooks

Shell scripts in `.claude/hooks/` that run on specific events (PreToolUse, PostToolUse). Used for safety guardrails and workflow automation. See [claude/README.md](claude/README.md).

---

## OpenCode

### Skills (`@skill-name`)

Markdown-defined workflows in `.opencode/skills/`. Invoked with `@skill-name` in conversation.

**Workflow skills:** `brainstorming`, `git-workflow`, `lsp-navigator`, `mgrep-search`, `subagent-driven-development`, `systematic-debugging`, `writing-plans`

### Agents (`@agent-name`, `/agent name`)

Specialist agents in `.opencode/agents/`. Each has a defined role, tools, and invocation syntax. See [opencode/README.md](opencode/README.md).

### Commands (`.opencode/commands/`)

Custom slash commands exposed in the OpenCode UI. Can trigger agent workflows, run scripts, or execute predefined prompts.

### Plugins (`.opencode/plugin/`)

Deeper extensions to OpenCode behavior. The `subtask2` plugin enables parallel subagent execution.

---

## AntiGravity IDE

### Skills (`.agent/skills/`)

The primary extension mechanism. 174+ skills covering all engineering and design domains. Invoked via the IDE's skill palette.

### Workflows (`.agent/workflows/`)

Multi-step processes combining multiple skills in sequence. 14 workflows for common engineering tasks (code review, feature dev, debugging, release).

### Rules (`.agent/rules/`)

Context-aware constraints applied based on the file being edited. 26 rules covering code quality, security, testing, and tool-specific conventions.

---

## Adding New Plugins / Skills

1. **Claude Code:** Create a new `.md` file in `.claude/skills/` following the existing format
2. **OpenCode:** Create a new `.md` file in `.opencode/skills/` with `@name` invocation syntax
3. **AntiGravity:** Create a new `.md` file in `.agent/skills/` with a clear role definition

After adding local skills, run `bash scripts/gart.sh sync` to merge with upstream agent updates.
