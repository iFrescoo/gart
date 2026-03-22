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

  // 5. Verification checklist
  const checkStep = toolStep + 1;
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
