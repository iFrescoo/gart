import * as p from "@clack/prompts";
import { LANGUAGES, TOOL_CONFIGS } from "./constants.js";
import type { ScaffoldOptions, Tool } from "./types.js";

export async function runPrompts(
  argDir?: string,
): Promise<ScaffoldOptions | null> {
  // Step 1: Project directory
  let projectDir = argDir;
  if (!projectDir) {
    const dir = await p.text({
      message: "Where should we create your project?",
      placeholder: "my-project",
      validate(value) {
        if (!value.trim()) return "Directory name is required.";
        if (/[<>:"|?*]/.test(value))
          return "Invalid characters in directory name.";
      },
    });
    if (p.isCancel(dir)) return null;
    projectDir = dir;
  }

  // Step 2: Tool selection (multiselect with space bar)
  const tools = await p.multiselect({
    message: "Which AI coding tools do you use?",
    options: Object.values(TOOL_CONFIGS).map((tc) => ({
      value: tc.id,
      label: tc.label,
      hint: tc.hint,
    })),
    initialValues: ["claude-code", "opencode", "antigravity"] as Tool[],
    required: true,
  });
  if (p.isCancel(tools)) return null;

  // Step 3: Agent response language
  const language = await p.select({
    message: "Agent response language?",
    options: [
      ...LANGUAGES.map((l) => ({ value: l.value, label: l.label })),
      { value: "__custom__", label: "Custom..." },
    ],
    initialValue: "English",
  });
  if (p.isCancel(language)) return null;

  let finalLanguage = language as string;
  if (language === "__custom__") {
    const custom = await p.text({
      message: "Enter your language:",
      placeholder: "e.g. Ukrainian, Korean, Hindi...",
      validate(value) {
        if (!value.trim()) return "Language is required.";
      },
    });
    if (p.isCancel(custom)) return null;
    finalLanguage = custom;
  }

  // Step 4: Git init
  const gitInit = await p.confirm({
    message: "Initialize git repository?",
    initialValue: true,
  });
  if (p.isCancel(gitInit)) return null;

  // Step 5: Install dependencies
  const installDeps = await p.confirm({
    message: "Install dependencies?",
    initialValue: true,
  });
  if (p.isCancel(installDeps)) return null;

  // Step 6: Gitignore
  const gitignore = await p.confirm({
    message: "Add GART folders to .gitignore?",
    initialValue: true,
  });
  if (p.isCancel(gitignore)) return null;

  return {
    projectDir,
    tools: tools as Tool[],
    language: finalLanguage,
    gitInit,
    installDeps,
    gitignore,
  };
}
