# Tailwind CSS Conventions

## Applies When
Files using Tailwind classes (`**/*.tsx`, `**/*.jsx`, `**/*.vue`, `**/*.html`)

## Rules

### Utility-First
- Use Tailwind utilities directly in markup — no custom CSS for common patterns
- Extract repeated utility groups into components (React/Vue), not `@apply`
- `@apply` is acceptable only in base styles or third-party component overrides

### Class Organization
Order classes by category for readability:
1. Layout: `flex`, `grid`, `block`, `hidden`
2. Sizing: `w-*`, `h-*`, `max-w-*`
3. Spacing: `p-*`, `m-*`, `gap-*`
4. Typography: `text-*`, `font-*`, `leading-*`
5. Colors: `bg-*`, `text-*`, `border-*`
6. Effects: `shadow-*`, `opacity-*`, `ring-*`
7. Responsive: `sm:`, `md:`, `lg:`, `xl:`
8. States: `hover:`, `focus:`, `active:`, `disabled:`
9. Dark: `dark:`

### Responsive Design
- Mobile-first: base classes = mobile, `sm:` = tablet, `lg:` = desktop
- Use container queries (`@container`) for component-level responsiveness
- Test at standard breakpoints: `sm` (640), `md` (768), `lg` (1024), `xl` (1280)

### Dark Mode
- Use `dark:` variant for dark mode styles
- Strategy: `class` (toggle) or `media` (system preference) in `tailwind.config`
- Ensure text/background contrast meets WCAG AA standards

### Don'ts
- Don't use arbitrary values (`[23px]`) when a standard scale value exists
- Don't create utility classes that duplicate Tailwind's built-in utilities
- Don't mix Tailwind with traditional CSS methodologies (BEM) in the same project
