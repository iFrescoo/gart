# Contributing to GART

## Prerequisites

- [Node.js](https://nodejs.org/) >= 18.0.0
- [npm](https://www.npmjs.com/) >= 9.0.0
- [Bun](https://bun.sh/) >= 1.0.0 (for OpenCode)
- [Git](https://git-scm.com/)

## Quick Start

```bash
# 1. Fork the repository on GitHub
# 2. Clone your fork
git clone https://github.com/<your-username>/gart.git
cd gart

# 3. Install dependencies
npm install

# 4. Make your changes
# 5. Test locally
bash scripts/gart.sh validate
```

## Adding Agents

1. Edit or create agent templates in `.gart/agents/`.
2. Run the sync script to generate agents across all 3 IDEs:

```bash
bash scripts/gart.sh sync
```

This propagates your changes to `.claude/agents/`, `.opencode/agents/`, and `.agent/skills/`.

## Adding Rules

Create a `.md` file in `.claude/rules/` with domain-specific conventions. Use the existing rules as reference for structure (applies-when section, clear categories, code examples).

## Adding Skills

1. Create a new directory in `.claude/skills/` named after your skill.
2. Add a `SKILL.md` file inside the directory with the skill instructions.
3. Update the skill count in `CLAUDE.md` if needed.

## Submitting a PR

- Use [Conventional Commits](https://www.conventionalcommits.org/): `feat:`, `fix:`, `docs:`, `refactor:`, `test:`, `chore:`
- Run validation before submitting:

```bash
bash scripts/gart.sh validate
```

- Describe your changes clearly in the PR description.
- Keep changes focused -- one feature or fix per PR.

## Project Structure

| Directory    | Purpose                                            |
| ------------ | -------------------------------------------------- |
| `.claude/`   | Claude Code agents, rules, hooks, skills           |
| `.opencode/` | OpenCode plugins and agents                        |
| `.agent/`    | AntiGravity skills and workflows                   |
| `.gart/`     | Local agent templates (source for sync)            |
| `cli/`       | CLI source code (published as `gart-build` on npm) |
| `docs/`      | User workspace (guides, decisions, tasks, context) |
| `docs-dev/`  | Template development docs (not distributed)        |
| `scripts/`   | Project management scripts (`gart.sh`)             |

## License

By contributing, you agree that your contributions will be licensed under the [MIT License](LICENSE).
