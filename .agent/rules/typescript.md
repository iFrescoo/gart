# TypeScript Conventions

## Applies When
TypeScript files (`**/*.ts`, `**/*.tsx`)

## Rules

### Strict Mode
- `strict: true` in tsconfig — non-negotiable
- **No `any`** — use `unknown` + type narrowing, or define proper types
- Explicit return types on all public/exported functions
- Use `import type { Foo }` for type-only imports

### Types vs Interfaces
- `interface` for object shapes and class contracts (extendable)
- `type` for unions, intersections, mapped types, primitives
- Don't mix — be consistent within a module

### Patterns

**Immutability:**
```typescript
const CONFIG = { apiUrl: '...', timeout: 5000 } as const;
```

**Discriminated Unions:**
```typescript
type Result<T> = { ok: true; data: T } | { ok: false; error: Error };
```

**Exhaustive Checks:**
```typescript
function assertNever(x: never): never {
  throw new Error(`Unexpected value: ${x}`);
}
```

### Don'ts
- No barrel exports (`index.ts` re-exporting everything) — hurts tree-shaking
- No `enum` — use `as const` objects or union types
- No `namespace` — use ES modules
- No `!` non-null assertion unless absolutely certain
- No `@ts-ignore` without explanation comment

### Module Style
- ESM only (`import`/`export`) — no CommonJS (`require`)
- Use `.js` extension in relative imports (for ESM resolution)
- Group imports: external packages → internal modules → types
