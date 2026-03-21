# Code Generation

## Applies When
All source files (`**/*`)

## Rules

### Clean Code
- Small functions (≤30 lines), single responsibility
- Readable names — no abbreviations, no magic numbers
- Max file length: ~300 lines (split if larger)
- Max nesting: 3 levels (extract early returns or helper functions)
- Max parameters: 4 (use options object for more)

### Imports
- Check existing imports before adding — no duplicates
- Remove unused imports after refactoring
- Use `import type` for type-only imports (TypeScript)

### Critical Changes
Use `// BEFORE:` -> `// AFTER:` comments for logic changes that affect behavior

### Naming Conventions
- `camelCase` — variables, functions, methods
- `PascalCase` — classes, interfaces, types, React components
- `UPPER_SNAKE_CASE` — constants, env variables
- `kebab-case` — file names, CSS classes, URLs

### Code Review Format
When reviewing code, use this structure:
```
OK — [what's good]
Needs improvement — [file:line] -> [suggested fix]
Critical — [file:line] -> [suggested fix]
```
