# MCP — Docker Gateway Reference

Central gateway connecting the IDE with the MCP ecosystem.

**Command:** `docker-mcp.exe gateway run --verify-signatures`

## Active Servers

| Server               | Tools    | Description                         |
| -------------------- | -------- | ----------------------------------- |
| `ast-grep`           | 1        | AST-based structural code search    |
| `atlas-docs`         | 5        | MongoDB Atlas documentation         |
| `context7`           | 2        | Live library documentation          |
| `docker-hub`         | 13       | Docker Hub — images, tags, versions |
| `fetch`              | 1+1p     | Web page fetching, web scraping     |
| `filesystem`         | 11       | File system operations              |
| `git`                | 12       | Git operations                      |
| `github-official`    | 41+2p+5r | GitHub API                          |
| `hugging-face`       | 10+4p    | Hugging Face hub                    |
| `markdownify`        | 11       | Markdown conversion                 |
| `memory`             | 9        | Persistent memory (knowledge graph) |
| `npm-sentinel`       | 19+2r    | NPM package analysis                |
| `paper-search`       | 8        | Scientific publication search       |
| `playwright`         | 22       | Browser automation (headless)       |
| `ref`                | —        | Documentation (API key required)    |
| `semgrep`            | —        | SAST — code security scanning       |
| `sequentialthinking` | 1        | Step-by-step structured reasoning   |
| `sqlite-mcp-server`  | —        | SQLite operations                   |
| `wolfram-alpha`      | —        | Mathematical computations           |
| `youtube_transcript` | —        | YouTube transcripts                 |

## Dynamic MCP (Meta-tools)

The gateway exposes 5 meta-tools that are always available:

| Tool             | Description                                                  |
| ---------------- | ------------------------------------------------------------ |
| `mcp-find`       | Search the catalog of 316+ servers by name/description       |
| `mcp-exec`       | Call a tool from any server without adding it to the session |
| `mcp-add`        | Add a server to the current session (increases tool count)   |
| `mcp-remove`     | Remove a server from the session                             |
| `mcp-config-set` | Set a server configuration value                             |

`mcp-exec` — key for IDEs with tool limits (bypasses the limit without adding to the session).

## Gateway Flags

| Flag                  | Description                                     |
| --------------------- | ----------------------------------------------- |
| `--verify-signatures` | Verify Docker image signatures and attestations |
| `--servers <name>`    | Filter servers — limits the number of tools     |
| `--log-calls`         | Audit log of tool calls (on by default)         |

## Known Issues

| Problem                    | Solution                                                       |
| -------------------------- | -------------------------------------------------------------- |
| "Failed to connect" in IDE | Use the full path to `docker-mcp.exe`, add Windows env vars    |
| Timeout >30s               | Set `MCP_TIMEOUT=60000` as a Windows user environment variable |
| "N tools exceeds limit"    | Use `--servers` to filter; `mcp-exec` for rarely used tools    |
| Server crashes with EOF    | Check required API keys in Docker Desktop → Configure          |
