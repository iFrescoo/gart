# Code Navigation

## Applies When
All files (`**/*`)

## Rules

### Search Order (fastest to slowest)
1. **`mgrep`** (MCP) — semantic search first. Understands meaning, not just text. **Sees files in `.gitignore` that grep cannot see.**
2. **`lsp`** — goToDefinition, findReferences, call hierarchy. Use when you already know the symbol.
3. **`grep`** — exact string/regex search. Note: does NOT see files in `.gitignore`.
4. **`glob`** / **`list`** — directory structure, path patterns.
5. **`read`** — read a file only when you already know which one.

### Prohibited
- **Never** read files sequentially looking for something — search first (mgrep/grep), then read
- **Never** skip `mgrep` — it's the fastest path to understanding. One query instead of reading 20 files.
- **Never** rely solely on `grep` for discovery — it misses `.gitignore` files that `mgrep` sees

### Efficient Exploration
- Start with `mgrep` for semantic understanding of the codebase
- Fall back to `grep` for exact string matching (literal patterns, error messages)
- Use `lsp` for navigating type hierarchies and call chains
- Parallelize independent searches — multiple tool calls in one message
- When searching for a definition, try `class ClassName` or `function functionName` patterns
