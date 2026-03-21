# HTML Conventions

## Applies When
HTML files (`**/*.html`, `**/*.htm`)

## Rules

### Semantic Elements
Use semantic tags instead of generic `<div>`:

| Instead of | Use |
|-----------|-----|
| `<div class="header">` | `<header>` |
| `<div class="nav">` | `<nav>` |
| `<div class="main">` | `<main>` |
| `<div class="article">` | `<article>` |
| `<div class="section">` | `<section>` |
| `<div class="footer">` | `<footer>` |
| `<div class="sidebar">` | `<aside>` |

### Accessibility (a11y)
- All `<img>` must have `alt` attributes (empty `alt=""` for decorative images)
- All form inputs must have associated `<label>` elements
- Use ARIA attributes when semantic HTML isn't sufficient
- Ensure keyboard navigation works (focusable elements, tab order)
- Use `role` attributes when repurposing elements

### Structure
- One `<main>` per page
- Heading hierarchy: `<h1>` -> `<h2>` -> `<h3>` (don't skip levels)
- Use `<button>` for actions, `<a>` for navigation
- Use `<time datetime="...">` for dates

### Performance
- Add `loading="lazy"` to below-fold images
- Add `width` and `height` to images (prevents layout shift)
- Use `<link rel="preload">` for critical resources
