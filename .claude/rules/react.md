# React Conventions

## Applies When
React component files (`**/*.tsx`, `**/*.jsx`)

## Rules

### Component Structure
- One component per file (exception: small helper components)
- Use function components with hooks (no class components)
- Export component as default or named — be consistent per project
- Co-locate styles, tests, and types with the component

### Hooks Rules
- Only call hooks at the top level (not inside loops, conditions, or nested functions)
- `useEffect` must have a cleanup function for subscriptions, timers, listeners
- `useEffect` dependency array must be complete — no missing dependencies
- Prefer `useMemo`/`useCallback` only after measuring performance, not preemptively

### State Management Layering
1. **Local state** (`useState`) — component-only data
2. **Shared state** (`useContext`) — small, infrequent updates
3. **External store** (Zustand, Redux) — complex, frequent updates
4. Don't lift state higher than necessary

### Patterns

**Composition over inheritance:**
```tsx
<Card>
  <Card.Header>Title</Card.Header>
  <Card.Body>{children}</Card.Body>
</Card>
```

**Early return for loading/error states:**
```tsx
if (isLoading) return <Spinner />;
if (error) return <ErrorMessage error={error} />;
return <DataView data={data} />;
```

### Don'ts
- No inline object/function creation in JSX props (causes re-renders)
- No `index` as `key` in dynamic lists (only for static lists)
- No direct DOM manipulation (`document.querySelector`) — use refs
- No `any` in event handlers — use proper React event types
