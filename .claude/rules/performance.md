# Performance

## Applies When
All source files (`**/*`)

## Patterns to Flag

### Algorithmic
- **O(n²) loops** where O(n) is possible — use Maps/Sets for lookups
- **N+1 queries** — batch database calls, use JOINs or DataLoader
- **Unnecessary iterations** — combine `.filter().map()` into single `.reduce()`

### React / Frontend
- Missing `memo`, `useMemo`, `useCallback` on expensive renders
- Unnecessary re-renders from inline object/function creation in JSX
- Large bundle imports — use dynamic `import()` for heavy libraries
- Images without lazy loading or proper sizing

### Memory
- Uncleared event listeners in `useEffect` cleanup
- Uncleared `setInterval`/`setTimeout` timers
- Unclosed subscriptions (WebSocket, Observable)
- Growing arrays/Maps that never get pruned

### Network
- Duplicate API calls — deduplicate or cache
- Missing request cancellation on component unmount
- No pagination for large data sets
- Synchronous blocking calls where async would work

### Database
- Missing indexes on frequently queried columns
- `SELECT *` when only specific columns needed
- No connection pooling
- Transactions held open too long

## What NOT to Optimize
- Don't optimize before measuring
- Don't add caching for data accessed once
- Don't micro-optimize hot loops that run <1000 iterations
- Readability > performance for non-critical paths
