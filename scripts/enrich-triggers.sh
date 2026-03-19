#!/usr/bin/env bash
#
# enrich-triggers.sh — One-time script to add trigger phrases to agent descriptions.
#
# Reads .claude/agents/*.md and .opencode/agents/agency-*.md, then appends
# "USE THIS AGENT when: ..." to each description based on the agent's division.
# Division is determined by scanning the upstream agency-agents directory structure.
#
# Prerequisites:
#   - Run scripts/sync-agents.sh first (to clone .agency-agents-upstream/)
#   - Python 3 required
#
# Usage:
#   bash scripts/enrich-triggers.sh [--dry-run]
#
# Flags:
#   --dry-run   Preview changes without writing any files
#
# After running: verify the output, then this functionality is merged into sync-agents.sh
# (Step 6 in sync-agents.sh). Once verified, you can delete this standalone script.

set -euo pipefail

# --- Colour helpers ---
if [[ -t 1 && -z "${NO_COLOR:-}" && "${TERM:-}" != "dumb" ]]; then
  GREEN=$'\033[0;32m'; YELLOW=$'\033[1;33m'; RED=$'\033[0;31m'; BOLD=$'\033[1m'; RESET=$'\033[0m'
else
  GREEN=''; YELLOW=''; RED=''; BOLD=''; RESET=''
fi
info()   { printf "${GREEN}[OK]${RESET}  %s\n" "$*"; }
warn()   { printf "${YELLOW}[!!]${RESET}  %s\n" "$*"; }
error()  { printf "${RED}[ERR]${RESET} %s\n" "$*" >&2; }
header() { echo -e "\n${BOLD}$*${RESET}"; }

# --- Paths ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
UPSTREAM_DIR="$PROJECT_ROOT/.agency-agents-upstream"
CLAUDE_AGENTS="$PROJECT_ROOT/.claude/agents"
OPENCODE_AGENTS="$PROJECT_ROOT/.opencode/agents"

# --- Parse flags ---
DRY_RUN=false
[[ "${1:-}" == "--dry-run" ]] && DRY_RUN=true

# --- Check prerequisites ---
if [[ ! -d "$UPSTREAM_DIR/.git" ]]; then
  error "Upstream repo not found at $UPSTREAM_DIR"
  error "Run scripts/sync-agents.sh first to clone it."
  exit 1
fi

if ! command -v python3 &>/dev/null; then
  error "python3 is required but not found"
  exit 1
fi

# --- Division → trigger phrase mapping ---
# Keep in sync with scripts/divisions.json
declare -A TRIGGERS
TRIGGERS[engineering]="USE THIS AGENT when: implementing code, building features, designing software architecture, fixing bugs, optimizing performance, or handling infrastructure and DevOps."
TRIGGERS[design]="USE THIS AGENT when: designing UI/UX interfaces, creating design systems, reviewing accessibility, building brand identity, or conducting user research."
TRIGGERS[testing]="USE THIS AGENT when: testing APIs, measuring performance, validating implementations, auditing quality, or analyzing test results."
TRIGGERS[product]="USE THIS AGENT when: prioritizing features, planning sprints, synthesizing user feedback, researching market trends, or tracking experiments."
TRIGGERS[project-management]="USE THIS AGENT when: managing projects, tracking deliverables, coordinating teams, planning releases, or organizing workflows."
TRIGGERS[marketing]="USE THIS AGENT when: creating marketing content, SEO optimization, social media strategy, growth hacking, or app store optimization."
TRIGGERS[sales]="USE THIS AGENT when: developing deal strategy, sales engineering, analyzing pipeline health, coaching discovery calls, or managing accounts."
TRIGGERS[paid-media]="USE THIS AGENT when: planning paid advertising campaigns, managing ad spend, creating ad creatives, or measuring campaign performance."
TRIGGERS[game-development]="USE THIS AGENT when: developing games with Unity/Unreal/Godot, designing game systems, creating game mechanics, or building game content."
TRIGGERS[spatial-computing]="USE THIS AGENT when: building AR/VR/XR experiences, visionOS applications, spatial interfaces, or immersive computing environments."
TRIGGERS[specialized]="USE THIS AGENT when: building MCP servers, developing AI/ML systems, auditing smart contracts, ensuring compliance, or creating specialized technical solutions."
TRIGGERS[support]="USE THIS AGENT when: writing technical documentation, responding to support requests, developer relations, legal compliance, or analytics reporting."
TRIGGERS[integrations]="USE THIS AGENT when: building platform integrations, mini programs, or third-party service connections."

# --- Agent directories in upstream ---
AGENT_DIRS=(
  design engineering game-development marketing paid-media sales product
  project-management testing support spatial-computing specialized integrations
)

# --- Helper functions (same as sync-agents.sh) ---
get_field() {
  local field="$1" file="$2"
  awk -v f="$field" '
    /^---$/ { fm++; next }
    fm == 1 && $0 ~ "^" f ": " { sub("^" f ": ", ""); print; exit }
  ' "$file"
}

slugify() {
  echo "$1" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-//;s/-$//'
}

# --- Python function to safely update description in YAML frontmatter ---
update_description() {
  local file="$1"
  local trigger="$2"
  local dry_run="${3:-false}"

  if [[ "$dry_run" == "true" ]]; then
    echo "  [DRY-RUN] Would update: $file"
    return 0
  fi

  FILE="$file" TRIGGER="$trigger" python3 << 'PYEOF'
import os, re, sys

file_path = os.environ['FILE']
trigger = os.environ['TRIGGER']

try:
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Split on frontmatter delimiters (first 3 parts: '', frontmatter, body)
    parts = content.split('---', 2)
    if len(parts) < 3:
        print(f"  SKIP (no frontmatter): {file_path}", file=sys.stderr)
        sys.exit(0)

    frontmatter = parts[1]

    def update_desc(m):
        raw = m.group(1).strip()
        # Remove surrounding quotes if present
        if raw.startswith('"') and raw.endswith('"'):
            raw = raw[1:-1]
        # Remove existing trigger phrase if already present
        raw = re.sub(r'\s*—\s*USE THIS AGENT when:.*$', '', raw, flags=re.IGNORECASE)
        raw = raw.rstrip('. ')
        return f'description: "{raw} — {trigger}"'

    new_fm = re.sub(
        r'^description:\s*(.+)$',
        update_desc,
        frontmatter,
        flags=re.MULTILINE
    )

    if new_fm == frontmatter:
        print(f"  SKIP (no description field): {file_path}", file=sys.stderr)
        sys.exit(0)

    new_content = '---' + new_fm + '---' + parts[2]

    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(new_content)

except Exception as e:
    print(f"  ERROR processing {file_path}: {e}", file=sys.stderr)
    sys.exit(1)
PYEOF
}

# ==========================================================================
# Step 1: Process upstream agents by division
# ==========================================================================
header "Step 1: Processing upstream agents by division"

total=0
for dir in "${AGENT_DIRS[@]}"; do
  src="$UPSTREAM_DIR/$dir"
  [[ -d "$src" ]] || continue

  trigger="${TRIGGERS[$dir]:-}"
  [[ -z "$trigger" ]] && { warn "No trigger phrase for division: $dir — skipping"; continue; }

  count=0
  for f in "$src"/*.md; do
    [[ -f "$f" ]] || continue

    name="$(get_field "name" "$f")"
    [[ -z "$name" ]] && continue

    slug="agency-$(slugify "$name")"

    # Update .claude/agents/[slug].md
    claude_file="$CLAUDE_AGENTS/${slug}.md"
    if [[ -f "$claude_file" ]]; then
      update_description "$claude_file" "$trigger" "$DRY_RUN"
      (( count++ )) || true
    fi

    # Update .opencode/agents/[slug].md
    oc_file="$OPENCODE_AGENTS/${slug}.md"
    if [[ -f "$oc_file" ]]; then
      update_description "$oc_file" "$trigger" "$DRY_RUN"
    fi
  done

  info "Division '$dir': $count agents updated"
  (( total += count )) || true
done

# ==========================================================================
# Step 2: Process local agents from scripts/local-agents/
# ==========================================================================
header "Step 2: Processing local agents"

LOCAL_AGENTS_DIR="$PROJECT_ROOT/scripts/local-agents"
if [[ -d "$LOCAL_AGENTS_DIR" ]]; then
  declare -A LOCAL_AGENT_TRIGGERS
  LOCAL_AGENT_TRIGGERS[debugger]="${TRIGGERS[engineering]}"
  LOCAL_AGENT_TRIGGERS[test-runner]="${TRIGGERS[testing]}"
  LOCAL_AGENT_TRIGGERS[dependency-auditor]="${TRIGGERS[engineering]}"
  LOCAL_AGENT_TRIGGERS[codebase-explorer]="${TRIGGERS[engineering]}"
  LOCAL_AGENT_TRIGGERS[github-code-searcher]="${TRIGGERS[engineering]}"

  for key in "${!LOCAL_AGENT_TRIGGERS[@]}"; do
    trigger="${LOCAL_AGENT_TRIGGERS[$key]}"
    slug="agency-$key"

    for target_dir in "$CLAUDE_AGENTS" "$OPENCODE_AGENTS"; do
      target_file="$target_dir/${slug}.md"
      if [[ -f "$target_file" ]]; then
        update_description "$target_file" "$trigger" "$DRY_RUN"
        info "Local agent '$slug' updated in $(basename "$target_dir")"
      fi
    done
  done
else
  warn "scripts/local-agents/ not found — skipping local agents"
fi

# ==========================================================================
# Summary
# ==========================================================================
header "Done!"
if [[ "$DRY_RUN" == "true" ]]; then
  echo "  DRY-RUN mode — no files were modified."
  echo "  Remove --dry-run to apply changes."
else
  echo "  $total agents enriched with trigger phrases."
  echo ""
  echo "  Next steps:"
  echo "  1. Review a few updated files:"
  echo "     head -5 $CLAUDE_AGENTS/agency-frontend-developer.md"
  echo "  2. If looks good — this functionality is now baked into sync-agents.sh (Step 6)."
  echo "  3. You can delete this standalone script: rm scripts/enrich-triggers.sh"
fi
