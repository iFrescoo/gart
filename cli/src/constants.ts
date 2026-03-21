import type { Tool, ToolConfig, Language } from './types.js';

export const TEMPLATE_SOURCE = 'github:Fresco04/agentic-coding-template#main';

export const BASE_FILES: string[] = [
  'docs',
  'scripts',
  '.env.example',
  '.gitignore',
  '.vscode',
];

export const TOOL_CONFIGS: Record<Tool, ToolConfig> = {
  'claude-code': {
    id: 'claude-code',
    label: 'Claude Code',
    hint: '274 agents, 19 skills, 11 hooks, 23 rules',
    files: ['.claude', 'CLAUDE.md'],
  },
  opencode: {
    id: 'opencode',
    label: 'OpenCode',
    hint: '154 agents, 25 skills, commands',
    files: ['.opencode', 'opencode.json', 'AGENTS.md'],
    transforms: ['opencode.json'],
  },
  antigravity: {
    id: 'antigravity',
    label: 'AntiGravity',
    hint: '155 skills, orchestration workflow',
    files: ['.agent', 'GEMINI.md'],
  },
};

export const EXCLUDED_PATHS: string[] = [
  'cli',
  '.github',
  'docs-dev',
  'undefined',
  'node_modules',
  '.agency-agents-upstream',
  'package-lock.json',
  'bun.lock',
  'opencode-workspace.code-workspace',
  'README.md',
  'package.json',
  'LICENSE',
  'ROADMAP.md',
  'marketplace.json',
  '.git',
  '.gitattributes',
];

export const LANGUAGES: Language[] = [
  { value: 'English', label: 'English' },
  { value: 'Polski', label: 'Polski (Polish)' },
  { value: 'Espanol', label: 'Espanol (Spanish)' },
  { value: 'Deutsch', label: 'Deutsch (German)' },
  { value: 'Francais', label: 'Francais (French)' },
  { value: 'Portugues', label: 'Portugues (Portuguese)' },
  { value: '日本語', label: '日本語 (Japanese)' },
  { value: '中文', label: '中文 (Chinese)' },
];

export const MCP_DEVDEPENDENCIES: Record<string, string> = {
  '@modelcontextprotocol/server-github': '^2025.4.8',
  '@modelcontextprotocol/server-memory': '^2026.1.26',
  '@playwright/mcp': '^0.0.68',
  'mcp-server-sqlite-npx': '^0.8.0',
};
