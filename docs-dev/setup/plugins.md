# OpenCode Plugins Catalog

> Last updated: 2026-03-22
> Environment: Windows 11, Gemini, OpenCode + AntiGravity + Claude Code

---

## Installed (global config)

File: `~/.config/opencode/opencode.json`

| Plugin | Version | What it does |
|--------|---------|-------------|
| `@openspoon/subtask2` | latest | Granular flow control for `/commands` |
| `@plannotator/opencode` | latest | Visual plan review before implementation |
| `opencode-scheduler` | latest | Cron-style scheduling via Windows Task Scheduler |
| `@tarquinen/opencode-dcp` | latest | Dynamic Context Pruning — compression, deduplication of tool calls |
| `opencode-websearch-cited` | **1.2.0 (pinned)** | Websearch with inline citations for the explorer agent |

Additionally (git clone, not npm):

| Plugin | Location | What it does |
|--------|----------|-------------|
| `opencode-shell-strategy` | `~/.config/opencode/plugin/shell-strategy/` | Non-interactive shell flags — prevents TTY hangs |

---

## To Install

### Orchestration

| Plugin | Priority | Difficulty | Notes |
|--------|----------|-----------|-------|
| [opencode-worktree](https://github.com/kdcokenny/opencode-worktree) | HIGH | Medium | Git worktrees — each agent on a separate branch. OCX doesn't work on Windows without WSL — use manual copy of `src/` to `.opencode/plugins/` |
| [opencode-background-agents](https://github.com/kdcokenny/opencode-background-agents) | MEDIUM | Easy | Async delegation — research in background. Note: create `~/.local/share/opencode/delegations/` manually on Windows |
| [octto](https://github.com/vtemian/octto) | MEDIUM | Easy | Browser UI — agent asks questions via widgets (radio, checkbox, diff viewer) instead of chat |

### Research / Auth

| Plugin | Priority | Difficulty | Notes |
|--------|----------|-----------|-------|
| [opencode-google-antigravity-auth](https://github.com/shekohex/opencode-google-antigravity-auth) | MEDIUM | Easy | OAuth AntiGravity + `google_search` tool + multi-account rotation. **Change `webfetch` to `ask`** in `opencode.json` before installing |

### Notifications

| Plugin | Priority | Difficulty | Notes |
|--------|----------|-----------|-------|
| [`@mohak34/opencode-notifier`](https://github.com/mohak34/opencode-notifier) | LOW | Easy | Desktop notifications + sounds. Was downloaded (`~/.cache`), not added to config. Only `.wav`, full paths `C:/Users/...` required |

---

## Plugin `plugin[]` ordering rules (CRITICAL)

```jsonc
// ~/.config/opencode/opencode.json
"plugin": [
  // first entries — any order
  "@openspoon/subtask2",
  "@plannotator/opencode",
  "opencode-worktree",         // when installed
  "octto",
  "opencode-scheduler",
  // OAuth BEFORE DCP
  "opencode-google-antigravity-auth",
  // DCP after OAuth, BEFORE websearch
  "@tarquinen/opencode-dcp",
  // websearch-cited MUST BE LAST
  "opencode-websearch-cited@1.2.0"
]
```

---

## Conflicts

| Conflict | Type | Resolution |
|----------|------|-----------|
| `websearch-cited` not last in array | Critical | Always last — otherwise disrupts auth flow |
| `websearch_cited` vs `google_search` (after antigravity-auth install) | Warning | `websearch_cited` = research with citations; `google_search` = quick lookup |
| `background-agents` + DCP | Warning | DCP disabled for subagents — don't delegate long tasks via bg-agents |
| `scheduler` + `git commit` (ask) | Warning | Scheduled runs work only for read-only operations |

---

## Deferred

| Plugin | Reason |
|--------|--------|
| `oh-my-opencode` | Overlaps with this template, requires Bun, installs via prompt — hard to control |
| `opencode-morph-fast-apply` | Not on npm, requires `MORPH_API_KEY`. Return when fast editing of 500+ line files is needed |
| `opencode-type-inject` | Valuable for TypeScript-heavy projects |

---

## Windows Gotchas

- `~/.local/share/opencode/` does not exist — background-agents requires manual creation
- Scheduler: no no-overlap guarantee on Windows (supervisor pipeline macOS/Linux only)
- Notifier: only `.wav`, full paths `C:/Users/...` not `~/`
- Global config: **UTF-8 without BOM** — verify after editing in Notepad
