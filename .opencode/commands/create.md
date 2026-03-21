---
description: Scaffold new projects or features with auto-validation
agent: build
---

# Create

## When to Use

- Starting from scratch — new project, feature, or module
- User says "create", "scaffold", "build from scratch", "new project"

## Process

### 1. Detect Context

| Context         | Indicators                               | Action                                      |
| --------------- | ---------------------------------------- | ------------------------------------------- |
| **Greenfield**  | Empty directory, no package.json         | Full project scaffold                       |
| **New feature** | Existing project, adding capability      | Feature scaffold within existing structure  |
| **New module**  | Existing project, adding service/package | Module scaffold following existing patterns |

### 2. Gather Requirements

1. **Stack** — Language, framework, runtime (detect from existing project or ask)
2. **Type** — API, web app, CLI, library, microservice
3. **Constraints** — Integration requirements, authentication, database
4. **Conventions** — Follow existing project patterns

### 3. Scaffold

Generate directory structure, config files, base components, package.json with scripts, .env.example.

### 4. Validate (Auto)

Run automatically — do not wait for user:

1. `tsc --noEmit` — type check
2. `npm run lint` — lint check
3. `npm run build` — build check
4. Fix any errors before presenting result

### 5. Document

Update README.md, add setup instructions, note manual steps needed.
