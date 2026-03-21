import { cp, readdir, rm, writeFile, stat } from 'node:fs/promises';
import { join, resolve } from 'node:path';
import { execFileSync } from 'node:child_process';
import { platform } from 'node:os';

// On Windows, npm/npx are .cmd files — execFileSync needs shell: true to find them
const SHELL = platform() === 'win32' ? { shell: true } : {};
import { downloadTemplate } from 'giget';
import type { ScaffoldOptions } from './types.js';
import { BASE_FILES, TOOL_CONFIGS, EXCLUDED_PATHS } from './constants.js';
import { generatePackageJson, generateMcpJson, transformOpencodeJson, injectLanguage } from './transform.js';
import { generateReadme } from './readme-generator.js';

async function exists(path: string): Promise<boolean> {
  try {
    await stat(path);
    return true;
  } catch {
    return false;
  }
}

async function copyEntry(src: string, dest: string): Promise<void> {
  const s = await stat(src);
  if (s.isDirectory()) {
    await cp(src, dest, { recursive: true });
  } else {
    await cp(src, dest);
  }
}

export async function scaffold(
  options: ScaffoldOptions,
  onStatus: (msg: string) => void,
): Promise<void> {
  const targetDir = resolve(options.projectDir);

  // 1. Download template from GitHub
  onStatus('Fetching template from GitHub...');
  const { dir: tempDir } = await downloadTemplate('github:Fresco04/agentic-coding-template#main', {
    force: true,
    dir: join(targetDir, '.gart-temp'),
  });

  // 2. Determine which entries to copy
  const allowedEntries = new Set<string>(BASE_FILES);
  for (const tool of options.tools) {
    for (const file of TOOL_CONFIGS[tool].files) {
      allowedEntries.add(file);
    }
  }

  // 3. Copy selected files
  onStatus('Scaffolding project...');
  const entries = await readdir(tempDir);
  for (const entry of entries) {
    if (EXCLUDED_PATHS.includes(entry)) continue;
    if (!allowedEntries.has(entry)) continue;

    const src = join(tempDir, entry);
    const dest = join(targetDir, entry);
    await copyEntry(src, dest);
  }

  // 4. Generate package.json
  onStatus('Generating package.json...');
  const pkgContent = generatePackageJson(options.projectDir, options.tools);
  await writeFile(join(targetDir, 'package.json'), pkgContent, 'utf-8');

  // 5. Generate README.md
  onStatus('Generating README...');
  const readmeContent = generateReadme({
    projectName: options.projectDir,
    tools: options.tools,
    language: options.language,
  });
  await writeFile(join(targetDir, 'README.md'), readmeContent, 'utf-8');

  // 6. Generate .mcp.json (Claude Code MCP pre-configuration)
  const mcpContent = generateMcpJson(options.tools);
  if (mcpContent) {
    onStatus('Generating MCP config...');
    await writeFile(join(targetDir, '.mcp.json'), mcpContent, 'utf-8');
  }

  // 7. Transform opencode.json (remove hardcoded paths)
  if (options.tools.includes('opencode')) {
    const opencodeJsonPath = join(targetDir, 'opencode.json');
    if (await exists(opencodeJsonPath)) {
      onStatus('Cleaning opencode.json...');
      await transformOpencodeJson(opencodeJsonPath);
    }
  }

  // 7. Inject language preference
  if (options.language !== 'English') {
    onStatus('Setting agent language...');
  }
  await injectLanguage(targetDir, options.tools, options.language);

  // 8. Clean up temp directory
  await rm(join(targetDir, '.gart-temp'), { recursive: true, force: true });

  // 9. Git init
  if (options.gitInit) {
    onStatus('Initializing git repository...');
    try {
      execFileSync('git', ['init'], { cwd: targetDir, stdio: 'ignore', ...SHELL });
    } catch {
      // git not available — skip silently
    }
  }

  // 10. Install dependencies
  if (options.installDeps) {
    onStatus('Installing dependencies...');
    try {
      execFileSync('npm', ['install'], { cwd: targetDir, stdio: 'ignore', timeout: 120_000, ...SHELL });
    } catch {
      // Will show warning in outro
    }
  }
}
