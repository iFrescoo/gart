# Code Navigation

## Applies When
All files (`**/*`)

## Rules

### Search Order (fastest to slowest)
1. **Grep** — exact string/regex search across files
2. **Glob** — file path patterns, directory structure
3. **Read** — when you already know which file
4. **LSP** — goToDefinition, findReferences, hover, documentSymbol, getDiagnostics

### Prohibited
- **Never** read files sequentially looking for something — search first (Grep/Glob), then read
- **Never** use `cat`, `head`, `tail` via Bash when Read tool is available
- **Never** use `find` via Bash when Glob tool is available
- **Never** use `grep`/`rg` via Bash when Grep tool is available

### Efficient Exploration
- For open-ended codebase exploration, use the `Explore` subagent
- For specific class/function lookup, use Grep directly
- Parallelize independent searches — multiple Grep/Glob calls in one message
- When searching for a definition, try `class ClassName` or `function functionName` patterns
