# MCP Tools

## Applies When
All files (`**/*`)

## Available MCP Servers

| Server | Role |
|--------|------|
| `context-mode` | Context window protection — index large outputs in sandbox |
| `MCP_DOCKER` | Docker MCP Gateway — full server catalog |

### Docker MCP — Meta-tools (always available)

| Tool | Description |
|------|-------------|
| `mcp-find` | Search 316+ MCP servers by name/description |
| `mcp-exec` | Call a tool from any server without adding to session |
| `mcp-add` | Add a server to current session |

### Useful Docker MCP Servers

- **context7** — library documentation (`resolve-library-id` -> `query-docs`). Use instead of guessing APIs.
- **playwright** — browser automation when fetch isn't enough (SPA, JS-rendered, Cloudflare)
- **github-official** — GitHub API (issues, PRs, commits, code search)
- **memory** — persistent memory between sessions (`memory_store` / `memory_retrieve`)
- **sequential-thinking** — step-by-step reasoning for complex problems

## Usage Rules
- Use `context-mode` for any command producing >20 lines of output
- Use `context7` to look up library APIs — never hallucinate API signatures
- Use `playwright` when `WebFetch` returns empty/blocked content
- MCP tool outputs >10K tokens will trigger warnings — keep outputs focused
