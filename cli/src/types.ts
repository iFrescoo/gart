export type Tool = "claude-code" | "opencode" | "antigravity";

export interface ToolConfig {
  id: Tool;
  label: string;
  hint: string;
  files: string[];
  gitignoreFiles: string[]; // subset of files to gitignore (heavy/regeneratable only)
  transforms?: string[];
}

export interface Language {
  value: string;
  label: string;
}

export interface ScaffoldOptions {
  projectDir: string;
  tools: Tool[];
  language: string;
  includeSync: boolean;
  includeWorkflows: boolean;
  gitInit: boolean;
  installDeps: boolean;
  gitignore: boolean;
}
