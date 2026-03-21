import type { Tool } from './types.js';

interface ReadmeOptions {
  projectName: string;
  tools: Tool[];
  language: string;
}

export function generateReadme({ projectName, tools, language }: ReadmeOptions): string {
  const hasClaude = tools.includes('claude-code');
  const hasOpencode = tools.includes('opencode');
  const hasAntigravity = tools.includes('antigravity');

  const toolNames = tools.map((t) => {
    if (t === 'claude-code') return 'Claude Code';
    if (t === 'opencode') return 'OpenCode';
    return 'AntiGravity';
  });

  const sections: string[] = [];

  // Header
  sections.push(`# ${projectName}\n`);
  sections.push(
    `> Scaffolded with [GART](https://github.com/Fresco04/agentic-coding-template) — Generative Agent Runtime Toolkit\n`,
  );
  sections.push(`AI coding tools: **${toolNames.join(', ')}**`);
  sections.push(`Agent response language: **${language}**\n`);

  // Prerequisites
  sections.push(`## Prerequisites\n`);
  sections.push(`- [Node.js](https://nodejs.org/) >= 18.0.0`);
  sections.push(`- npm >= 9.0.0`);
  if (hasOpencode) {
    sections.push(`- [Bun](https://bun.sh/) >= 1.0.0`);
  }
  sections.push(`- [Docker Desktop](https://www.docker.com/products/docker-desktop/) (for MCP Docker Gateway)`);
  sections.push('');

  // Setup
  sections.push(`## Setup\n`);
  sections.push('```bash');
  sections.push('cp .env.example .env     # Add your API keys');
  sections.push('npm install              # Install MCP server dependencies');
  sections.push('```\n');

  // Launch
  sections.push(`## Launch\n`);
  if (hasClaude) {
    sections.push(`### Claude Code`);
    sections.push('```bash');
    sections.push('claude');
    sections.push('```');
    sections.push(`Reads \`CLAUDE.md\` for instructions. Agents in \`.claude/agents/\`, skills in \`.claude/skills/\`.\n`);
  }
  if (hasOpencode) {
    sections.push(`### OpenCode`);
    sections.push('```bash');
    sections.push('opencode');
    sections.push('```');
    sections.push(`Reads \`AGENTS.md\` + \`opencode.json\`. Agents in \`.opencode/agents/\`, skills in \`.opencode/skills/\`.\n`);
  }
  if (hasAntigravity) {
    sections.push(`### AntiGravity`);
    sections.push('Open the project folder in the AntiGravity IDE.');
    sections.push(`Reads \`GEMINI.md\`. Skills in \`.agent/skills/\`, rules in \`.agent/rules/\`, workflows in \`.agent/workflows/\`.\n`);
  }

  // Agent Orchestration
  sections.push(`## Agent Orchestration\n`);
  sections.push(`This project includes **144+ specialist AI agents** organized into divisions:\n`);
  sections.push('| Division | Agents |');
  sections.push('|----------|--------|');
  sections.push('| Engineering | Backend, Frontend, DevOps, AI/ML, Security, SRE, Mobile |');
  sections.push('| Design | UX, UI, Brand, Visual Storytelling |');
  sections.push('| Game Dev | Unity, Unreal, Godot, Level Design, Narrative |');
  sections.push('| Marketing | Content, SEO, Social Media, Growth |');
  sections.push('| Specialized | MCP Builder, Blockchain, Data Engineering |');
  sections.push('');
  sections.push('Update agents to latest version:');
  sections.push('```bash');
  sections.push('bash scripts/sync-agents.sh');
  sections.push('```\n');

  // Docs
  sections.push(`## Documentation\n`);
  sections.push('- `docs/guides/` — Reference guides (debugging, MCP, agent workflows)');
  sections.push('- `docs/decisions/` — Architecture decision records');
  sections.push('- `docs/tasks/` — Task tracking');
  sections.push('- `docs/context/` — Project context & notes\n');

  // Environment
  sections.push(`## Environment Variables\n`);
  sections.push('See `.env.example` for required API keys:\n');
  sections.push('- `GITHUB_PERSONAL_ACCESS_TOKEN` — GitHub MCP server');
  sections.push('- `REF_API_KEY` — ref.tools documentation MCP (optional)');
  if (hasOpencode) {
    sections.push('- `OPENCODE_EXPERIMENTAL_LSP_TOOL=true` — Enable LSP tools for agents');
  }
  sections.push('');

  return sections.join('\n');
}
