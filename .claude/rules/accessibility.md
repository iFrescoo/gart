# Accessibility (a11y)

## Applies When
UI files (`**/*.tsx`, `**/*.jsx`, `**/*.vue`, `**/*.html`, `**/*.svelte`)

## Rules (WCAG 2.1 AA)

### Color & Contrast
- Normal text: **4.5:1** contrast ratio minimum
- Large text (18px+ bold, 24px+ regular): **3:1** minimum
- Don't convey information through color alone (add icons, text, patterns)
- Test with color blindness simulators

### Keyboard Navigation
- All interactive elements must be focusable and operable via keyboard
- Visible focus indicators (don't remove `outline` without replacement)
- Logical tab order (follows visual layout)
- `Escape` closes modals/dropdowns
- Arrow keys navigate within composite widgets (tabs, menus)

### Screen Readers
- All images need `alt` text (or `alt=""` for decorative)
- Form inputs need associated `<label>` elements
- Use `aria-label` or `aria-labelledby` when visual label is absent
- Live regions (`aria-live`) for dynamic content updates
- Announce loading states and errors

### Semantic HTML
- Use `<button>` for actions (not clickable `<div>`)
- Use `<a>` for navigation (not clickable `<span>`)
- Use heading hierarchy (`h1` > `h2` > `h3`)
- Use `<nav>`, `<main>`, `<aside>`, `<footer>` landmarks

### Forms
- Group related fields with `<fieldset>` + `<legend>`
- Show error messages near the invalid field
- Don't rely on placeholder text as labels
- Mark required fields with `aria-required="true"`

### Motion
- Respect `prefers-reduced-motion` media query
- Provide pause/stop controls for animations
- No auto-playing media with sound
