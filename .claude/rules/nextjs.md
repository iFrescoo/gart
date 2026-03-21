# Next.js Conventions

## Applies When
Next.js App Router files (`app/**`, `pages/**`)

## Rules

### App Router (preferred)
- **Server Components** by default — only add `"use client"` when needed
- Use `"use client"` only for: event handlers, hooks, browser APIs, third-party client libs
- Keep client components small — push logic to server components

### Data Fetching
- Fetch data in Server Components (not client-side useEffect)
- Use `fetch()` with Next.js caching: `{ cache: 'force-cache' }` or `{ next: { revalidate: 60 } }`
- Use `loading.tsx` for streaming/Suspense boundaries
- Use `error.tsx` for error boundaries

### File Conventions
| File | Purpose |
|------|---------|
| `page.tsx` | Route UI |
| `layout.tsx` | Shared layout (wraps children) |
| `loading.tsx` | Loading UI (Suspense fallback) |
| `error.tsx` | Error UI (Error Boundary) |
| `not-found.tsx` | 404 UI |

### API Routes
- Use Route Handlers (`app/api/*/route.ts`) for API endpoints
- Validate all input (use zod or similar)
- Return proper HTTP status codes
- Don't expose internal errors to clients

### Performance
- Use `next/image` for optimized images (not `<img>`)
- Use `next/link` for client-side navigation (not `<a>`)
- Use `next/font` for optimized font loading
- Implement code splitting with `dynamic()` for heavy components

### Don'ts
- Don't mix App Router and Pages Router in the same route
- Don't use `getServerSideProps`/`getStaticProps` in App Router (Pages Router only)
- Don't fetch data in `layout.tsx` if it's only needed in `page.tsx`
