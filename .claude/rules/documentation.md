# Documentation

## Applies When
All files (`**/*`)

## Rules

### Inline Comments
- Only add comments where logic isn't self-evident
- Don't add comments to unchanged code during edits
- Don't add JSDoc/docstrings unless explicitly asked
- Prefer self-documenting code (clear names) over comments

### When Comments ARE Needed
- Non-obvious business logic ("// VAT exempt for orders > €1000 per EU directive 2006/112")
- Workarounds with context ("// Chrome 120 bug: flex gap doesn't work with...")
- Performance-critical decisions ("// Using Map instead of array.find() — O(1) vs O(n) for 10k+ items")
- Regex patterns ("// Matches: YYYY-MM-DD with optional time")

### README Format
- Start with what the project does (1 sentence)
- Prerequisites and setup instructions
- How to run, test, deploy
- Environment variables reference

### ADR (Architecture Decision Records)
Location: `docs/decisions/`
Format: Title, Status, Context, Decision, Consequences

### Documentation Locations
- `docs/guides/` — reference guides (debugging, MCP, workflows)
- `docs/decisions/` — architecture decision records
- `docs/tasks/` — task tracking
- `docs/context/` — project context and notes
