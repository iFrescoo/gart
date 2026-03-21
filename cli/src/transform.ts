import { readFile, writeFile } from 'node:fs/promises';
import { join } from 'node:path';
import type { Tool } from './types.js';
import { MCP_DEVDEPENDENCIES } from './constants.js';

export function generatePackageJson(projectName: string, tools: Tool[]): string {
  const pkg: Record<string, unknown> = {
    name: projectName,
    version: '0.1.0',
    description: '',
    private: true,
    engines: { node: '>=18.0.0' },
    scripts: {} as Record<string, string>,
    devDependencies: { ...MCP_DEVDEPENDENCIES },
  };

  if (tools.includes('opencode')) {
    (pkg.scripts as Record<string, string>).postinstall = 'cd .opencode && bun install';
  }

  return JSON.stringify(pkg, null, 2) + '\n';
}

export async function transformOpencodeJson(filePath: string): Promise<void> {
  const raw = await readFile(filePath, 'utf-8');
  const config = JSON.parse(raw);

  // Remove hardcoded MCP_DOCKER (contains Windows-specific paths)
  if (config.mcp?.MCP_DOCKER) {
    delete config.mcp.MCP_DOCKER;
  }

  await writeFile(filePath, JSON.stringify(config, null, 2) + '\n', 'utf-8');
}

export function generateMcpJson(tools: Tool[]): string | null {
  if (!tools.includes('claude-code')) return null;

  const config: Record<string, unknown> = {
    mcpServers: {
      github: {
        command: 'npx',
        args: ['-y', '@modelcontextprotocol/server-github'],
        env: {
          GITHUB_PERSONAL_ACCESS_TOKEN: '${GITHUB_PERSONAL_ACCESS_TOKEN}',
        },
      },
      memory: {
        command: 'npx',
        args: ['-y', '@modelcontextprotocol/server-memory'],
      },
      playwright: {
        command: 'npx',
        args: ['-y', '@playwright/mcp'],
      },
    },
  };

  return JSON.stringify(config, null, 2) + '\n';
}

export async function injectLanguage(
  targetDir: string,
  tools: Tool[],
  language: string,
): Promise<void> {
  const languageBlock = `\n## Language\n\nRespond in: ${language}\nWrite code comments in: ${language}\n`;

  const filesToPatch: { tool: Tool; file: string }[] = [
    { tool: 'claude-code', file: 'CLAUDE.md' },
    { tool: 'opencode', file: 'AGENTS.md' },
    { tool: 'antigravity', file: 'GEMINI.md' },
  ];

  for (const { tool, file } of filesToPatch) {
    if (!tools.includes(tool)) continue;

    const filePath = join(targetDir, file);
    try {
      let content = await readFile(filePath, 'utf-8');

      // Replace existing Language section or insert after first heading
      const langRegex = /\n## Language\n[\s\S]*?(?=\n## |\n---|\Z)/;
      if (langRegex.test(content)) {
        content = content.replace(langRegex, languageBlock);
      } else {
        // Insert after the first heading line
        const firstHeadingEnd = content.indexOf('\n');
        if (firstHeadingEnd !== -1) {
          content =
            content.slice(0, firstHeadingEnd + 1) +
            languageBlock +
            content.slice(firstHeadingEnd + 1);
        }
      }

      await writeFile(filePath, content, 'utf-8');
    } catch {
      // File doesn't exist for unselected tools — skip
    }
  }
}
