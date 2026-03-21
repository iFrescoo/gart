# CSS Conventions

## Applies When
CSS and SCSS files (`**/*.css`, `**/*.scss`)

## Rules

### Layout
- **Flexbox** for 1D layouts (rows or columns)
- **CSS Grid** for 2D layouts (rows AND columns)
- Avoid `float` for layout (legacy pattern)
- Use logical properties (`margin-inline`, `padding-block`) for RTL support

### Custom Properties (CSS Variables)
```css
:root {
  --color-primary: #3b82f6;
  --spacing-md: 1rem;
  --font-size-base: 16px;
}
```
- Define tokens in `:root`, consume everywhere
- Use for colors, spacing, typography, shadows, borders

### Naming
- BEM methodology: `.block__element--modifier`
- Or utility-first (Tailwind) — don't mix approaches
- Avoid deeply nested selectors (max 3 levels)

### Responsive Design
- Mobile-first: start with base styles, add `@media (min-width:)` for larger
- Use `rem`/`em` for typography, `px` for borders/shadows
- Test at: 320px, 768px, 1024px, 1440px breakpoints

### Don'ts
- No `!important` (except for utility overrides)
- No inline styles in HTML (use classes)
- No fixed widths on text containers (use `max-width`)
- No magic numbers — use variables or calc()

### Dark Mode
- Use `prefers-color-scheme: dark` media query
- Or class-based toggle (`.dark` on `<html>`)
- Ensure sufficient contrast in both modes (WCAG AA: 4.5:1)
