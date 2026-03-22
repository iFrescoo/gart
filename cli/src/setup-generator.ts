import type { Tool } from "./types.js";

interface SetupOptions {
  tools: Tool[];
  language: string;
}

export function generateSetup({ tools, language }: SetupOptions): string {
  const hasClaude = tools.includes("claude-code");
  const hasOpencode = tools.includes("opencode");
  const hasAntigravity = tools.includes("antigravity");

  const sections: string[] = [];

  sections.push("# Setup Guide\n");
  sections.push(
    "> Follow these steps to get your GART project fully configured.\n",
  );

  // 1. Environment
  sections.push("## 1. Environment Variables\n");
  sections.push("```bash");
  sections.push("cp .env.example .env");
  sections.push("```\n");
  sections.push("Open `.env` and fill in the required values:\n");
  sections.push("| Variable | Required | Description |");
  sections.push("|----------|----------|-------------|");
  sections.push(
    "| `GITHUB_PERSONAL_ACCESS_TOKEN` | Yes | GitHub MCP server authentication |",
  );
  sections.push("| `REF_API_KEY` | No | ref.tools documentation MCP server |");
  sections.push("");

  // 2. Install dependencies
  sections.push("## 2. Install Dependencies\n");
  sections.push("```bash");
  sections.push("npm install");
  sections.push("```\n");
  if (hasOpencode) {
    sections.push(
      "OpenCode plugins require [Bun](https://bun.sh/). After installing Bun:\n",
    );
    sections.push("```bash");
    sections.push("cd .opencode && bun install && cd ..");
    sections.push("```\n");
  }

  // 3. Docker MCP (if OpenCode)
  if (hasOpencode) {
    sections.push("## 3. Docker MCP Gateway\n");
    sections.push(
      "The `opencode.json` file includes a pre-configured `MCP_DOCKER` entry. To use it:\n",
    );
    sections.push(
      "1. Install [Docker Desktop](https://www.docker.com/products/docker-desktop/)",
    );
    sections.push("2. Enable the Docker MCP plugin in Docker Desktop settings");
    sections.push("3. Verify the MCP binary is available:\n");
    sections.push("```bash");
    sections.push("# macOS / Linux");
    sections.push("which docker-mcp");
    sections.push("");
    sections.push("# Windows");
    sections.push("where docker-mcp.exe");
    sections.push("```\n");
    sections.push(
      "If the path in `opencode.json` doesn't match your system, update `mcp.MCP_DOCKER.command` manually.\n",
    );
  }

  // 4. Tool-specific setup
  const toolStep = hasOpencode ? 4 : 3;
  sections.push(`## ${toolStep}. Launch Your Tool\n`);

  if (hasClaude) {
    sections.push("### Claude Code\n");
    sections.push(
      "Install via `npm install -g @anthropic-ai/claude-code` or use the VS Code extension.\n",
    );
    sections.push("```bash");
    sections.push("claude");
    sections.push("```\n");
    sections.push(
      "Claude reads `CLAUDE.md` for project instructions. Agents are in `.claude/agents/`.\n",
    );
  }

  if (hasOpencode) {
    sections.push("### OpenCode\n");
    sections.push("```bash");
    sections.push("opencode");
    sections.push("```\n");
    sections.push(
      "OpenCode reads `AGENTS.md` + `opencode.json`. Agents in `.opencode/agents/`.\n",
    );
  }

  if (hasAntigravity) {
    sections.push("### AntiGravity\n");
    sections.push(
      "Open the project folder in the AntiGravity IDE. It reads `GEMINI.md` automatically.",
    );
    sections.push("Skills in `.agent/skills/`, rules in `.agent/rules/`.\n");
  }

  // Free LLM model discovery (always shown)
  sections.push(`## ${toolStep + 1}. Free LLM Model Discovery (Optional)\n`);
  sections.push(
    "GART includes `bash scripts/gart.sh models` — a wrapper for [free-coding-models](https://github.com/vava-nessa/free-coding-models).\n",
  );
  sections.push(
    "It pings 174 free LLM models across 23 providers (Groq, Cerebras, NVIDIA NIM, OpenRouter, +19 more), ranks by latency and stability, and writes config for your coding tool.\n",
  );
  sections.push("```bash");
  sections.push(
    "bash scripts/gart.sh models          # interactive TUI — browse all models",
  );
  sections.push(
    "bash scripts/gart.sh models --tier S  # show only top-tier (S-rank) models",
  );
  sections.push("```\n");
  sections.push(
    "> Requires `npm install -g free-coding-models` or `npx` (auto-downloaded on first run).\n",
  );

  // Recommended VS Code extensions
  const extStep = toolStep + 2;
  sections.push(`## ${extStep}. Recommended VS Code Extensions (22)\n`);
  sections.push(
    "GART includes 22 free extensions for auditing, debugging, security, and developer experience.\n",
  );
  sections.push("**Three ways to install:**\n");
  sections.push(
    "1. Open the project in VS Code — accept the recommendations popup",
  );
  sections.push(
    "2. Run `bash scripts/gart.sh extensions` to batch-install all",
  );
  sections.push(
    "3. Browse `.vscode/extensions.json` and install individually\n",
  );
  sections.push(
    "**Categories:** Code Quality (SonarLint, ESLint, Prettier, CodeMetrics), " +
      "Security (Snyk, GitGuardian), Git (GitLens, Git Graph), Accessibility (axe Linter), " +
      "Testing (Jest), API (Thunder Client), CI/CD (GitHub Actions), Performance (Flame Chart), " +
      "DX (Tailwind, YAML, markdownlint, Import Cost, Todo Tree, Regex, Logs, Spell Checker).\n",
  );

  // MCP Servers section
  const mcpStep = extStep + 1;
  sections.push(`## ${mcpStep}. MCP Servers (Pre-configured)\n`);
  sections.push(
    "GART includes **20 MCP servers** via Docker MCP Gateway, plus 4 via npx.\n",
  );
  sections.push("### Pre-configured Docker MCP servers\n");
  sections.push("| Server | Tools | Category |");
  sections.push("|--------|-------|----------|");
  sections.push("| ast-grep | 1 | Code analysis — structural search |");
  sections.push("| Atlas Docs | 5 | MongoDB documentation |");
  sections.push("| Context7 | 2 | Library docs & code examples |");
  sections.push("| Docker Hub | 13 | Container registry management |");
  sections.push("| Fetch | 1 | HTTP fetch |");
  sections.push("| Filesystem | 11 | File operations |");
  sections.push("| Git | 12 | Git operations |");
  sections.push("| GitHub Official | 40 | GitHub API (issues, PRs, code) |");
  sections.push("| Hugging Face | 8 | AI/ML model hub |");
  sections.push("| Markdownify | 11 | HTML to Markdown conversion |");
  sections.push("| Memory | 9 | Persistent memory between sessions |");
  sections.push("| NPM Sentinel | 19 | npm package audit & analysis |");
  sections.push("| Paper Search | 57 | Academic paper search (multi-source) |");
  sections.push("| Playwright | 21 | Browser automation |");
  sections.push("| Semgrep | 8 | Security scanning (SAST) |");
  sections.push("| Sequential Thinking | 1 | Step-by-step reasoning |");
  sections.push("| SQLite | 25 | SQLite database |");
  sections.push("| WolframAlpha | 1 | Math & computation |");
  sections.push("| YouTube Transcripts | — | Video transcript extraction |");
  sections.push("| ArXiv | — | Research paper search & download |\n");
  sections.push("### Adding more servers\n");
  sections.push("```bash");
  sections.push("# Search the catalog (300+ servers):");
  sections.push("# mcp-find <keyword>");
  sections.push("#");
  sections.push("# Add to current session:");
  sections.push("# mcp-add <server-name>");
  sections.push("#");
  sections.push("# Popular additions:");
  sections.push("# mcp-add brave          — Web search (needs BRAVE_API_KEY)");
  sections.push("# mcp-add grafana        — Dashboard & metrics");
  sections.push("# mcp-add elasticsearch  — Search index management");
  sections.push(
    "# mcp-add stripe         — Payment API (needs STRIPE_API_KEY)",
  );
  sections.push(
    "# mcp-add notion         — Notion workspace (needs NOTION_TOKEN)",
  );
  sections.push("# mcp-add neon           — Serverless PostgreSQL");
  sections.push("# mcp-add mongodb        — MongoDB database access");
  sections.push("# mcp-add heroku         — Heroku deployment");
  sections.push("```\n");
  sections.push(
    "Browse all: [Docker Hub MCP Catalog](https://hub.docker.com/mcp/explore)\n",
  );

  // Verification checklist
  const checkStep = mcpStep + 1;
  sections.push(`## ${checkStep}. Verification Checklist\n`);
  sections.push("- [ ] `.env` configured with API keys");
  if (hasOpencode) {
    sections.push("- [ ] Docker Desktop running (for MCP Docker Gateway)");
    sections.push("- [ ] `docker-mcp` binary accessible from your PATH");
  }
  sections.push("- [ ] `npm install` completed without errors");
  if (hasOpencode) {
    sections.push("- [ ] `bun install` completed in `.opencode/`");
  }
  sections.push("- [ ] Launch your chosen tool and verify agents load");
  sections.push(`- [ ] Agent response language is set to **${language}**`);
  sections.push("");

  return sections.join("\n");
}
