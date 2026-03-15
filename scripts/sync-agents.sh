#!/usr/bin/env bash
#
# sync-agents.sh — Sync agents from msitarzewski/agency-agents into this template.
#
# Clones/updates the upstream repo, runs its convert.sh, then post-processes
# OpenCode agents with permissions and BOOT SEQUENCE. Copies results to:
#   .opencode/agents/   (OpenCode — with enriched frontmatter)
#   .claude/agents/     (Claude Code — original .md files)
#   .agent/skills/      (AntiGravity — SKILL.md format)
#
# Usage:
#   ./scripts/sync-agents.sh [--force]
#
# Flags:
#   --force   Re-clone upstream even if it already exists

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
UPSTREAM_REPO="https://github.com/msitarzewski/agency-agents.git"

# Destination dirs
OPENCODE_AGENTS="$PROJECT_ROOT/.opencode/agents"
CLAUDE_AGENTS="$PROJECT_ROOT/.claude/agents"
ANTIGRAVITY_SKILLS="$PROJECT_ROOT/.agent/skills"

# Source category dirs in upstream repo
AGENT_DIRS=(
  design engineering game-development marketing paid-media sales product
  project-management testing support spatial-computing specialized integrations
)

# --- Parse flags ---
FORCE=false
[[ "${1:-}" == "--force" ]] && FORCE=true

# ==========================================================================
# Step 1: Clone or update upstream repo
# ==========================================================================
header "Step 1: Fetching upstream agency-agents repo"

if [[ "$FORCE" == true && -d "$UPSTREAM_DIR" ]]; then
  warn "Force flag set — removing existing upstream clone"
  rm -rf "$UPSTREAM_DIR"
fi

if [[ -d "$UPSTREAM_DIR/.git" ]]; then
  info "Upstream repo exists — pulling latest"
  git -C "$UPSTREAM_DIR" pull --ff-only 2>/dev/null || {
    warn "Pull failed — re-cloning"
    rm -rf "$UPSTREAM_DIR"
    git clone --depth 1 "$UPSTREAM_REPO" "$UPSTREAM_DIR"
  }
else
  info "Cloning upstream repo (shallow)"
  git clone --depth 1 "$UPSTREAM_REPO" "$UPSTREAM_DIR"
fi

# ==========================================================================
# Step 2: Run upstream convert.sh for OpenCode and AntiGravity
# ==========================================================================
header "Step 2: Running upstream convert.sh"

if [[ -x "$UPSTREAM_DIR/scripts/convert.sh" ]]; then
  (cd "$UPSTREAM_DIR" && bash scripts/convert.sh --tool opencode 2>&1) || {
    error "convert.sh --tool opencode failed"; exit 1;
  }
  (cd "$UPSTREAM_DIR" && bash scripts/convert.sh --tool antigravity 2>&1) || {
    error "convert.sh --tool antigravity failed"; exit 1;
  }
else
  error "convert.sh not found or not executable in upstream repo"
  exit 1
fi

# ==========================================================================
# Step 3: Copy Claude Code agents (original .md, no conversion needed)
# ==========================================================================
header "Step 3: Copying agents to .claude/agents/"

mkdir -p "$CLAUDE_AGENTS"
count=0
for dir in "${AGENT_DIRS[@]}"; do
  src="$UPSTREAM_DIR/$dir"
  [[ -d "$src" ]] || continue
  for f in "$src"/*.md; do
    [[ -f "$f" ]] || continue
    cp "$f" "$CLAUDE_AGENTS/"
    (( count++ )) || true
  done
done
info "Claude Code: $count agents copied to .claude/agents/"

# ==========================================================================
# Step 4: Copy and enrich OpenCode agents
# ==========================================================================
header "Step 4: Copying and enriching OpenCode agents"

mkdir -p "$OPENCODE_AGENTS"

# Permission profiles per category
# Format: bash|edit|write|read|glob|grep|lsp|todowrite|todoread|webfetch|websearch|list|skill
declare -A PERMS
PERMS[engineering]='bash: "ask"
  edit: "allow"
  write: "allow"
  read: "allow"
  glob: "allow"
  grep: "allow"
  lsp: "allow"
  list: "allow"
  skill: "allow"
  todoread: "allow"
  todowrite: "allow"
  webfetch: "deny"
  websearch: "deny"'
PERMS[design]='bash: "deny"
  edit: "deny"
  write: "deny"
  read: "allow"
  glob: "allow"
  grep: "allow"
  lsp: "allow"
  list: "allow"
  skill: "allow"
  todoread: "allow"
  todowrite: "deny"
  webfetch: "deny"
  websearch: "deny"'
PERMS[marketing]='bash: "deny"
  edit: "deny"
  write: "allow"
  read: "allow"
  glob: "allow"
  grep: "allow"
  lsp: "deny"
  list: "allow"
  skill: "allow"
  todoread: "allow"
  todowrite: "allow"
  webfetch: "allow"
  websearch: "allow"'
PERMS[product]='bash: "deny"
  edit: "deny"
  write: "allow"
  read: "allow"
  glob: "allow"
  grep: "allow"
  lsp: "deny"
  list: "allow"
  skill: "allow"
  todoread: "allow"
  todowrite: "allow"
  webfetch: "allow"
  websearch: "allow"'
PERMS[testing]='bash: "ask"
  edit: "deny"
  write: "deny"
  read: "allow"
  glob: "allow"
  grep: "allow"
  lsp: "allow"
  list: "allow"
  skill: "allow"
  todoread: "allow"
  todowrite: "allow"
  webfetch: "deny"
  websearch: "deny"'
PERMS[support]='bash: "deny"
  edit: "deny"
  write: "allow"
  read: "allow"
  glob: "allow"
  grep: "allow"
  lsp: "deny"
  list: "allow"
  skill: "allow"
  todoread: "allow"
  todowrite: "allow"
  webfetch: "allow"
  websearch: "allow"'
PERMS[project-management]='bash: "deny"
  edit: "deny"
  write: "allow"
  read: "allow"
  glob: "allow"
  grep: "allow"
  lsp: "deny"
  list: "allow"
  skill: "allow"
  todoread: "allow"
  todowrite: "allow"
  webfetch: "deny"
  websearch: "deny"'
PERMS[sales]='bash: "deny"
  edit: "deny"
  write: "allow"
  read: "allow"
  glob: "allow"
  grep: "allow"
  lsp: "deny"
  list: "allow"
  skill: "allow"
  todoread: "allow"
  todowrite: "deny"
  webfetch: "allow"
  websearch: "allow"'
PERMS[paid-media]='bash: "deny"
  edit: "deny"
  write: "allow"
  read: "allow"
  glob: "allow"
  grep: "allow"
  lsp: "deny"
  list: "allow"
  skill: "allow"
  todoread: "allow"
  todowrite: "deny"
  webfetch: "allow"
  websearch: "allow"'
PERMS[game-development]='bash: "ask"
  edit: "allow"
  write: "allow"
  read: "allow"
  glob: "allow"
  grep: "allow"
  lsp: "allow"
  list: "allow"
  skill: "allow"
  todoread: "allow"
  todowrite: "allow"
  webfetch: "deny"
  websearch: "deny"'
PERMS[spatial-computing]='bash: "ask"
  edit: "allow"
  write: "allow"
  read: "allow"
  glob: "allow"
  grep: "allow"
  lsp: "allow"
  list: "allow"
  skill: "allow"
  todoread: "allow"
  todowrite: "allow"
  webfetch: "deny"
  websearch: "deny"'
PERMS[specialized]='bash: "ask"
  edit: "allow"
  write: "allow"
  read: "allow"
  glob: "allow"
  grep: "allow"
  lsp: "deny"
  list: "allow"
  skill: "allow"
  todoread: "allow"
  todowrite: "allow"
  webfetch: "deny"
  websearch: "deny"'
PERMS[integrations]='bash: "ask"
  edit: "allow"
  write: "allow"
  read: "allow"
  glob: "allow"
  grep: "allow"
  lsp: "allow"
  list: "allow"
  skill: "allow"
  todoread: "allow"
  todowrite: "allow"
  webfetch: "allow"
  websearch: "allow"'

# Temperature per category
declare -A TEMPS
TEMPS[engineering]="0.2"
TEMPS[design]="0.5"
TEMPS[marketing]="0.5"
TEMPS[product]="0.3"
TEMPS[testing]="0.1"
TEMPS[support]="0.3"
TEMPS[project-management]="0.2"
TEMPS[sales]="0.5"
TEMPS[paid-media]="0.3"
TEMPS[game-development]="0.3"
TEMPS[spatial-computing]="0.3"
TEMPS[specialized]="0.2"
TEMPS[integrations]="0.2"

# Frontmatter helpers (same as upstream)
get_field() {
  local field="$1" file="$2"
  awk -v f="$field" '
    /^---$/ { fm++; next }
    fm == 1 && $0 ~ "^" f ": " { sub("^" f ": ", ""); print; exit }
  ' "$file"
}

get_body() {
  awk 'BEGIN{fm=0} /^---$/{fm++; next} fm>=2{print}' "$1"
}

slugify() {
  echo "$1" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-//;s/-$//'
}

# Resolve named colors to hex
resolve_color() {
  local c="$1"
  case "$c" in
    red)     echo "#ff6b6b" ;;
    green)   echo "#51cf66" ;;
    blue)    echo "#339af0" ;;
    cyan)    echo "#22b8cf" ;;
    magenta) echo "#cc5de8" ;;
    yellow)  echo "#fcc419" ;;
    orange)  echo "#ff922b" ;;
    pink)    echo "#f06595" ;;
    purple)  echo "#845ef7" ;;
    teal)    echo "#20c997" ;;
    indigo)  echo "#5c7cfa" ;;
    lime)    echo "#94d82d" ;;
    violet)  echo "#7950f2" ;;
    grape)   echo "#be4bdb" ;;
    *)       echo "#868e96" ;;  # gray fallback
  esac
}

BOOT_SEQUENCE='## BOOT SEQUENCE

1. Follow rules from `AGENTS.md`
2. Use tool hierarchy: mgrep → lsp → grep → glob → read

'

oc_count=0
for dir in "${AGENT_DIRS[@]}"; do
  src="$UPSTREAM_DIR/$dir"
  [[ -d "$src" ]] || continue

  # Get permission profile for this category
  perms="${PERMS[$dir]:-${PERMS[specialized]}}"
  temp="${TEMPS[$dir]:-0.2}"

  for f in "$src"/*.md; do
    [[ -f "$f" ]] || continue

    name="$(get_field "name" "$f")"
    description="$(get_field "description" "$f")"
    color_raw="$(get_field "color" "$f")"
    body="$(get_body "$f")"

    [[ -z "$name" ]] && continue

    slug="agency-$(slugify "$name")"
    color="$(resolve_color "$color_raw")"
    outfile="$OPENCODE_AGENTS/${slug}.md"

    cat > "$outfile" <<HEREDOC
---
description: "${description} — Invoke via @${slug}"
mode: subagent
model: google/gemini-3.1-pro-preview-customtools
temperature: ${temp}
color: "${color}"
steps: 15
hidden: false
permission:
  ${perms}
---

${BOOT_SEQUENCE}${body}
HEREDOC

    (( oc_count++ )) || true
  done
done
info "OpenCode: $oc_count agents enriched and copied to .opencode/agents/"

# ==========================================================================
# Step 5: Copy AntiGravity skills
# ==========================================================================
header "Step 5: Copying AntiGravity skills"

ag_src="$UPSTREAM_DIR/integrations/antigravity"
ag_count=0
if [[ -d "$ag_src" ]]; then
  for skill_dir in "$ag_src"/agency-*/; do
    [[ -d "$skill_dir" ]] || continue
    skill_name="$(basename "$skill_dir")"
    dest_dir="$ANTIGRAVITY_SKILLS/$skill_name"
    mkdir -p "$dest_dir"
    if [[ -f "$skill_dir/SKILL.md" ]]; then
      cp "$skill_dir/SKILL.md" "$dest_dir/"
      (( ag_count++ )) || true
    fi
  done
  info "AntiGravity: $ag_count skills copied to .agent/skills/"
else
  warn "AntiGravity integrations not found — skipping"
fi

# ==========================================================================
# Summary
# ==========================================================================
header "Sync complete!"
echo "  Claude Code:  $count agents  → .claude/agents/"
echo "  OpenCode:     $oc_count agents  → .opencode/agents/"
echo "  AntiGravity:  $ag_count skills  → .agent/skills/"
echo ""
echo "  Upstream:     $UPSTREAM_DIR"
echo ""
info "Done. Existing agents (code-reviewer, debugger, etc.) are untouched."
