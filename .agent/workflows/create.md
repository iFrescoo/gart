---
name: create
description: Scaffold workflow for new projects or features. Detects context (greenfield vs existing), gathers requirements, generates structure, and auto-validates the result.
---

# Create Workflow

## When to Activate

- User says "create", "scaffold", "build from scratch", "new project", "new feature", "init"
- Starting a new module, service, or component from zero
- Setting up a new repository or workspace

## Phase 1: Detect Context

Determine the starting point:

| Context         | Indicators                               | Action                                      |
| --------------- | ---------------------------------------- | ------------------------------------------- |
| **Greenfield**  | Empty directory, no package.json         | Full project scaffold                       |
| **New feature** | Existing project, adding capability      | Feature scaffold within existing structure  |
| **New module**  | Existing project, adding service/package | Module scaffold following existing patterns |

## Phase 2: Gather Requirements

1. **Stack** — Language, framework, runtime (detect from existing project or ask)
2. **Type** — API, web app, CLI, library, microservice
3. **Constraints** — Must integrate with existing systems? Authentication? Database?
4. **Conventions** — Follow existing project patterns (detect from codebase)

## Phase 3: Scaffold

Generate the appropriate structure:

### Greenfield Project

- Directory structure matching the chosen framework
- Configuration files (tsconfig, eslint, prettier, .gitignore)
- Base components/modules
- Package.json with scripts (dev, build, test, lint)
- Environment template (.env.example)

### New Feature / Module

- Follow existing directory conventions
- Create files matching existing naming patterns
- Add exports to barrel files if project uses them
- Wire up routing/registration if applicable

## Phase 4: Validate (Auto)

Run automatically after scaffolding — do not wait for user:

1. `tsc --noEmit` — type check (if TypeScript)
2. `npm run lint` or `ruff check .` — lint check
3. `npm run build` — build check (if build script exists)
4. Fix any errors found before presenting result

## Phase 5: Document

1. Update README.md with new feature/module documentation
2. Add setup instructions if new dependencies were introduced
3. Note any manual steps the user needs to complete (env vars, API keys, database setup)
