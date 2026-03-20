# GART — Generative Agent Runtime Toolkit

> Scaffold multi-IDE agentic coding projects with **144+ AI agents** in one command.

```bash
npx gart-build my-project
```

GART sets up a complete AI agent orchestration environment for **Claude Code**, **OpenCode** (Google Gemini), and **AntiGravity IDE** — with pre-configured agents, skills, hooks, and MCP server integrations.

## Quick Start

```bash
npx gart-build my-project
cd my-project
cp .env.example .env     # Add your API keys
claude                   # or: opencode / open in AntiGravity
```

The interactive CLI lets you:
- **Choose your tools** — select which AI IDEs to configure (space to toggle)
- **Set agent language** — agents respond in your preferred language
- **Auto-scaffold** — only the configs you need, clean and ready

## What You Get

| Component | Details |
|-----------|---------|
| **144+ Specialist Agents** | Engineering, Design, Game Dev, Marketing, Sales, QA, and more |
| **Agent Orchestration** | Team coordinators, division routing, central orchestrator |
| **19+ Skills** | Frontend design, debugging, brainstorming, git workflow, LSP navigation |
| **MCP Integration** | Docker MCP Gateway (316+ servers), GitHub, Memory, Playwright |
| **Documentation** | Guides, ADR templates, task tracking, agent workflow reference |
| **Security Hooks** | Block dangerous commands, permission matrices, safety controls |

## Supported Tools

| Tool | Config Files | Agents |
|------|-------------|--------|
| **Claude Code** | `.claude/`, `CLAUDE.md` | 274 agents, 19 skills, hooks |
| **OpenCode** | `.opencode/`, `opencode.json`, `AGENTS.md` | 154 agents, 25 skills, commands |
| **AntiGravity** | `.agent/`, `GEMINI.md` | 155 skills, orchestration workflow |

## Prerequisites

- [Node.js](https://nodejs.org/) >= 18.0.0
- [Bun](https://bun.sh/) >= 1.0.0 (for OpenCode plugin)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) (for MCP Docker Gateway)

## Agent Divisions

Agents are organized into specialized divisions:

| Division | Examples |
|----------|---------|
| Engineering | Backend Architect, Frontend Developer, DevOps, AI Engineer, Security |
| Design | UX Architect, UI Designer, Brand Guardian, Visual Storyteller |
| Game Dev | Unity, Unreal, Godot specialists, Level Designer, Narrative Designer |
| Marketing | Content Creator, SEO, Social Media, Growth Hacker |
| QA & Testing | API Tester, Performance Benchmarker, Evidence Collector |
| Specialized | MCP Builder, Blockchain Auditor, Data Engineer, Technical Writer |

Update agents to the latest version:

```bash
bash scripts/sync-agents.sh
```

## How It Works

1. `npx gart-build` downloads the latest template from this repository
2. You select which AI coding tools you use (Claude Code, OpenCode, AntiGravity)
3. You choose your preferred agent response language
4. GART scaffolds only the selected configs into your project
5. Generated `package.json` and `README.md` are tailored to your selection

## Contributing

This repository is the source for both the GART CLI and the template it scaffolds.

```bash
git clone https://github.com/Fresco04/agentic-coding-template.git
cd agentic-coding-template

# CLI development
cd cli
npm install
npm run build
npm link              # Now 'gart-build' command is available globally

# Test scaffolding
gart-build test-project
```

### Repository Structure

```
├── cli/              # GART CLI source (published to npm as "gart-build")
├── .claude/          # Claude Code agents, skills, hooks
├── .opencode/        # OpenCode agents, skills, commands
├── .agent/           # AntiGravity skills, workflows
├── scripts/          # Agent sync pipeline
├── docs/             # Documentation templates
├── CLAUDE.md         # Claude Code instruction file
├── AGENTS.md         # OpenCode instruction file
└── GEMINI.md         # AntiGravity instruction file
```

### Publishing

```bash
cd cli
npm run build
npm publish           # Requires npm login
```

Or push a version tag for automatic publishing:

```bash
git tag v1.0.1
git push origin v1.0.1   # GitHub Action publishes to npm
```

## License

[MIT](LICENSE)
