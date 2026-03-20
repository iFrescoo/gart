#!/usr/bin/env node

import * as p from '@clack/prompts';
import pc from 'picocolors';
import { runPrompts } from './prompts.js';
import { scaffold } from './scaffold.js';
import { existsSync } from 'node:fs';
import { resolve } from 'node:path';

async function main(): Promise<void> {
  console.log('');
  p.intro(`${pc.bgCyan(pc.black(' GART '))} ${pc.dim('Generative Agent Runtime Toolkit')}`);

  const argDir = process.argv[2];

  // Check if target already exists
  if (argDir && existsSync(resolve(argDir))) {
    p.log.error(`Directory ${pc.bold(argDir)} already exists.`);
    process.exit(1);
  }

  const options = await runPrompts(argDir);
  if (!options) {
    p.cancel('Cancelled.');
    process.exit(0);
  }

  // Verify target doesn't exist (for prompted dir)
  if (!argDir && existsSync(resolve(options.projectDir))) {
    p.log.error(`Directory ${pc.bold(options.projectDir)} already exists.`);
    process.exit(1);
  }

  const s = p.spinner();
  s.start('Fetching template...');

  try {
    await scaffold(options, (msg) => {
      s.message(msg);
    });
    s.stop('Done!');
  } catch (err) {
    s.stop('Failed.');
    p.log.error(
      err instanceof Error ? err.message : 'An unexpected error occurred.',
    );
    process.exit(1);
  }

  // Tool-specific launch commands
  const launchCmds: string[] = [];
  if (options.tools.includes('claude-code')) launchCmds.push('claude                   # Claude Code');
  if (options.tools.includes('opencode')) launchCmds.push('opencode                 # OpenCode');
  if (options.tools.includes('antigravity')) launchCmds.push('# Open folder in AntiGravity IDE');

  p.note(
    [
      `cd ${options.projectDir}`,
      'cp .env.example .env     # Add your API keys',
      ...launchCmds,
    ].join('\n'),
    'Next steps',
  );

  p.outro(`${pc.green('Your GART project is ready!')} ${pc.dim(`(${options.tools.length} tool${options.tools.length > 1 ? 's' : ''}, ${options.language})`)}`);
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
