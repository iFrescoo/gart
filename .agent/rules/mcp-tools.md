# MCP Tools

## Applies When
All files (`**/*`)

## Available MCP Servers

| Server | Role |
|--------|------|
| `mgrep` | Semantic code search across the project |
| `context-mode` | Context window protection — index large outputs in sandbox |
| `gh_grep` | GitHub code search (via `@gh-search`) |
| `MCP_DOCKER` | Docker MCP Gateway — full server catalog |

> AntiGravity has a limit of **100 tools**. Use `--servers` for filtering and `mcp-exec` instead of `mcp-add` for rarely used servers.

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
- **docker-hub** — Docker Hub: images, tags, versions

## Usage Rules
- Use `mgrep` as the primary search tool — semantic understanding beats regex for discovery
- Use `context-mode` for any command producing >20 lines of output
- Use `context7` to look up library APIs — never hallucinate API signatures
- Use `playwright` when page content is JS-rendered or blocked
- Prefer `mcp-exec` over `mcp-add` for one-off server usage (saves tool slots)
- MCP tool outputs >10K tokens will trigger warnings — keep outputs focused
