#!/usr/bin/env bash
#
# sync-agents.sh — Sync agents from msitarzewski/agency-agents into this template.
#
# Steps:
#   1. Clone/update upstream repo
#   2. Run upstream convert.sh (OpenCode, AntiGravity)
#   3. Collect agent data by division (for team generation)
#   4. Copy to .claude/agents/ + enrich with trigger phrases
#   5. Post-process OpenCode agents (permissions, model, temp, triggers)
#   6. Generate local agents from scripts/local-agents/ → all 3 IDEs
#   7. Generate team-* division agents (OpenCode primary agents = tabs)
#   8. Generate orchestrator.md (knows ALL agents)
#   9. Generate orchestration skill (.opencode/skills/ + .claude/skills/)
#  10. Generate AntiGravity orchestration workflow
#  11. Copy AntiGravity skills from upstream
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

OPENCODE_AGENTS="$PROJECT_ROOT/.opencode/agents"
CLAUDE_AGENTS="$PROJECT_ROOT/.claude/agents"
ANTIGRAVITY_SKILLS="$PROJECT_ROOT/.agent/skills"
OPENCODE_SKILLS="$PROJECT_ROOT/.opencode/skills/orchestration"
CLAUDE_SKILLS="$PROJECT_ROOT/.claude/skills/orchestration"
AGENT_WORKFLOWS="$PROJECT_ROOT/.agent/workflows"
LOCAL_AGENTS_DIR="$PROJECT_ROOT/scripts/local-agents"

# Source category dirs in upstream repo
AGENT_DIRS=(
  design engineering game-development marketing paid-media sales product
  project-management testing support spatial-computing specialized integrations
)

# --- Parse flags ---
FORCE=false
[[ "${1:-}" == "--force" ]] && FORCE=true

# --- Temp directory for agent data collection ---
TMPDIR_DATA=$(mktemp -d)
trap 'rm -rf "$TMPDIR_DATA"' EXIT

# ==========================================================================
# Division configuration — trigger phrases
# ==========================================================================
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

# ==========================================================================
# Division configuration — permissions (YAML block for OpenCode frontmatter)
# ==========================================================================
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

# Coordinator permissions (team-* agents and orchestrator — delegate only, don't implement)
COORDINATOR_PERMS='bash: "deny"
  edit: "deny"
  write: "deny"
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

# Colors per division
declare -A COLORS
COLORS[engineering]="#339af0"
COLORS[design]="#cc5de8"
COLORS[testing]="#94d82d"
COLORS[product]="#22b8cf"
COLORS[project-management]="#5c7cfa"
COLORS[marketing]="#ff922b"
COLORS[sales]="#fcc419"
COLORS[paid-media]="#f06595"
COLORS[game-development]="#845ef7"
COLORS[spatial-computing]="#20c997"
COLORS[specialized]="#ff6b6b"
COLORS[support]="#51cf66"
COLORS[integrations]="#7950f2"

# ==========================================================================
# Team configuration — which divisions belong to each team
# ==========================================================================
declare -A TEAM_DIVS
TEAM_DIVS[team-engineering]="engineering"
TEAM_DIVS[team-design]="design"
TEAM_DIVS[team-qa]="testing"
TEAM_DIVS[team-product]="product"
TEAM_DIVS[team-project-mgmt]="project-management"
TEAM_DIVS[team-marketing]="marketing"
TEAM_DIVS[team-sales]="sales"
TEAM_DIVS[team-paid-media]="paid-media"
TEAM_DIVS[team-game-dev]="game-development"
TEAM_DIVS[team-spatial]="spatial-computing"
TEAM_DIVS[team-specialized]="specialized support integrations"

declare -A TEAM_LABELS
TEAM_LABELS[team-engineering]="Engineering"
TEAM_LABELS[team-design]="Design"
TEAM_LABELS[team-qa]="QA & Testing"
TEAM_LABELS[team-product]="Product"
TEAM_LABELS[team-project-mgmt]="Project Management"
TEAM_LABELS[team-marketing]="Marketing"
TEAM_LABELS[team-sales]="Sales"
TEAM_LABELS[team-paid-media]="Paid Media"
TEAM_LABELS[team-game-dev]="Game Development"
TEAM_LABELS[team-spatial]="Spatial Computing"
TEAM_LABELS[team-specialized]="Specialized"

declare -A TEAM_COLORS
TEAM_COLORS[team-engineering]="#339af0"
TEAM_COLORS[team-design]="#cc5de8"
TEAM_COLORS[team-qa]="#94d82d"
TEAM_COLORS[team-product]="#22b8cf"
TEAM_COLORS[team-project-mgmt]="#5c7cfa"
TEAM_COLORS[team-marketing]="#ff922b"
TEAM_COLORS[team-sales]="#fcc419"
TEAM_COLORS[team-paid-media]="#f06595"
TEAM_COLORS[team-game-dev]="#845ef7"
TEAM_COLORS[team-spatial]="#20c997"
TEAM_COLORS[team-specialized]="#ff6b6b"

declare -A TEAM_EMOJIS
TEAM_EMOJIS[team-engineering]="⚙️"
TEAM_EMOJIS[team-design]="🎨"
TEAM_EMOJIS[team-qa]="🧪"
TEAM_EMOJIS[team-product]="📦"
TEAM_EMOJIS[team-project-mgmt]="📋"
TEAM_EMOJIS[team-marketing]="📣"
TEAM_EMOJIS[team-sales]="💼"
TEAM_EMOJIS[team-paid-media]="📊"
TEAM_EMOJIS[team-game-dev]="🎮"
TEAM_EMOJIS[team-spatial]="🥽"
TEAM_EMOJIS[team-specialized]="🔬"

# Local agent → division mapping
declare -A LOCAL_AGENT_DIV
LOCAL_AGENT_DIV[debugger]="engineering"
LOCAL_AGENT_DIV[test-runner]="testing"
LOCAL_AGENT_DIV[dependency-auditor]="engineering"
LOCAL_AGENT_DIV[codebase-explorer]="engineering"
LOCAL_AGENT_DIV[github-code-searcher]="engineering"

# ==========================================================================
# Helper functions
# ==========================================================================
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
    *)       echo "#868e96" ;;
  esac
}

# Enrich description field in YAML frontmatter with trigger phrase (requires python3)
update_description_with_trigger() {
  local file="$1"
  local trigger="$2"
  [[ -f "$file" ]] || return 0
  command -v python3 &>/dev/null || return 0

  FILE="$file" TRIGGER="$trigger" python3 << 'PYEOF'
import os, re, sys
file_path = os.environ['FILE']
trigger = os.environ['TRIGGER']
try:
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    parts = content.split('---', 2)
    if len(parts) < 3:
        sys.exit(0)
    frontmatter = parts[1]
    def update_desc(m):
        raw = m.group(1).strip()
        if raw.startswith('"') and raw.endswith('"'):
            raw = raw[1:-1]
        raw = re.sub(r'\s*—\s*USE THIS AGENT when:.*$', '', raw, flags=re.IGNORECASE)
        raw = raw.rstrip('. ')
        return f'description: "{raw} — {trigger}"'
    new_fm = re.sub(r'^description:\s*(.+)$', update_desc, frontmatter, flags=re.MULTILINE)
    if new_fm == frontmatter:
        sys.exit(0)
    with open(file_path, 'w', encoding='utf-8') as f:
        f.write('---' + new_fm + '---' + parts[2])
except Exception as e:
    print(f"ERROR: {e}", file=sys.stderr)
PYEOF
}

BOOT_SEQUENCE='## BOOT SEQUENCE

1. Follow rules from `AGENTS.md`
2. Use tool hierarchy: mgrep → lsp → grep → glob → read

'

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
# Step 3: Collect agent data by division (needed for team-* + orchestrator)
# ==========================================================================
header "Step 3: Collecting agent data by division"

for dir in "${AGENT_DIRS[@]}"; do
  src="$UPSTREAM_DIR/$dir"
  [[ -d "$src" ]] || continue
  for f in "$src"/*.md; do
    [[ -f "$f" ]] || continue
    name="$(get_field "name" "$f")"
    desc="$(get_field "description" "$f")"
    [[ -z "$name" ]] && continue
    slug="agency-$(slugify "$name")"
    printf '%s\t%s\n' "@${slug}" "${desc}" >> "$TMPDIR_DATA/${dir}.agents"
  done
done

# Add local agents to their division data files
if [[ -d "$LOCAL_AGENTS_DIR" ]]; then
  for key in "${!LOCAL_AGENT_DIV[@]}"; do
    div="${LOCAL_AGENT_DIV[$key]}"
    src_file="$LOCAL_AGENTS_DIR/${key}.md"
    [[ -f "$src_file" ]] || continue
    name="$(get_field "name" "$src_file")"
    desc="$(get_field "description" "$src_file")"
    [[ -z "$name" ]] && continue
    slug="agency-$(slugify "$name")"
    printf '%s\t%s\n' "@${slug}" "${desc}" >> "$TMPDIR_DATA/${div}.agents"
  done
fi

info "Agent data collected for $(ls "$TMPDIR_DATA/"*.agents 2>/dev/null | wc -l | tr -d ' ') divisions"

# ==========================================================================
# Step 4: Copy Claude Code agents + enrich with trigger phrases
# ==========================================================================
header "Step 4: Copying agents to .claude/agents/ + enriching with trigger phrases"

mkdir -p "$CLAUDE_AGENTS"
count=0
for dir in "${AGENT_DIRS[@]}"; do
  src="$UPSTREAM_DIR/$dir"
  [[ -d "$src" ]] || continue
  trigger="${TRIGGERS[$dir]:-}"
  for f in "$src"/*.md; do
    [[ -f "$f" ]] || continue
    name="$(get_field "name" "$f")"
    [[ -z "$name" ]] && continue
    slug="agency-$(slugify "$name")"
    target="$CLAUDE_AGENTS/${slug}.md"
    cp "$f" "$target"
    [[ -n "$trigger" ]] && update_description_with_trigger "$target" "$trigger"
    (( count++ )) || true
  done
done
info "Claude Code: $count agents copied to .claude/agents/"

# ==========================================================================
# Step 5: Post-process OpenCode agents (permissions, model, temp, triggers)
# ==========================================================================
header "Step 5: Post-processing OpenCode agents"

mkdir -p "$OPENCODE_AGENTS"
oc_count=0
for dir in "${AGENT_DIRS[@]}"; do
  src="$UPSTREAM_DIR/$dir"
  [[ -d "$src" ]] || continue

  perms="${PERMS[$dir]:-${PERMS[specialized]}}"
  temp="${TEMPS[$dir]:-0.2}"
  trigger="${TRIGGERS[$dir]:-}"

  for f in "$src"/*.md; do
    [[ -f "$f" ]] || continue
    name="$(get_field "name" "$f")"
    description="$(get_field "description" "$f")"
    color_raw="$(get_field "color" "$f")"
    body="$(get_body "$f")"
    [[ -z "$name" ]] && continue

    slug="agency-$(slugify "$name")"
    color="$(resolve_color "$color_raw")"
    desc_enriched="${description}"
    [[ -n "$trigger" ]] && desc_enriched="${description} — ${trigger}"

    cat > "$OPENCODE_AGENTS/${slug}.md" <<HEREDOC
---
description: "${desc_enriched} — Invoke via @${slug}"
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
# Step 6: Generate local agents (scripts/local-agents/ → all 3 IDEs)
# ==========================================================================
header "Step 6: Generating local agents from scripts/local-agents/"

local_count=0
if [[ -d "$LOCAL_AGENTS_DIR" ]]; then
  for src_file in "$LOCAL_AGENTS_DIR"/*.md; do
    [[ -f "$src_file" ]] || continue
    base="$(basename "$src_file" .md)"
    div="${LOCAL_AGENT_DIV[$base]:-specialized}"

    name="$(get_field "name" "$src_file")"
    description="$(get_field "description" "$src_file")"
    color_raw="$(get_field "color" "$src_file")"
    body="$(get_body "$src_file")"
    [[ -z "$name" ]] && continue

    slug="agency-$(slugify "$name")"
    color="$(resolve_color "$color_raw")"
    perms="${PERMS[$div]:-${PERMS[specialized]}}"
    temp="${TEMPS[$div]:-0.2}"
    trigger="${TRIGGERS[$div]:-}"
    desc_enriched="${description}"
    [[ -n "$trigger" ]] && desc_enriched="${description} — ${trigger}"

    # → .opencode/agents/
    cat > "$OPENCODE_AGENTS/${slug}.md" <<HEREDOC
---
description: "${desc_enriched} — Invoke via @${slug}"
mode: subagent
model: google/gemini-3.1-pro-preview-customtools
temperature: ${temp}
color: "${color}"
steps: 20
hidden: false
permission:
  ${perms}
---

${BOOT_SEQUENCE}${body}
HEREDOC

    # → .claude/agents/ (with trigger in description)
    cp "$src_file" "$CLAUDE_AGENTS/${slug}.md"
    [[ -n "$trigger" ]] && update_description_with_trigger "$CLAUDE_AGENTS/${slug}.md" "$trigger"

    # → .agent/skills/agency-[slug]/SKILL.md
    mkdir -p "$ANTIGRAVITY_SKILLS/${slug}"
    cat > "$ANTIGRAVITY_SKILLS/${slug}/SKILL.md" <<HEREDOC
---
name: ${slug}
description: ${description}
---

${body}
HEREDOC

    (( local_count++ )) || true
  done
  info "Local agents: $local_count processed to all 3 IDEs"
else
  warn "scripts/local-agents/ not found — skipping local agents"
fi

# ==========================================================================
# Step 7: Generate team-* division agents (OpenCode primary agents = tabs)
# ==========================================================================
header "Step 7: Generating team-* division agents"

# Helper: build full agent list for given divisions
build_agent_list() {
  for div in "$@"; do
    local agents_file="$TMPDIR_DATA/${div}.agents"
    [[ -f "$agents_file" ]] || continue
    # Add section header if multiple divisions
    [[ "$#" -gt 1 ]] && echo "### ${div} agents" && echo ""
    while IFS=$'\t' read -r slug desc; do
      printf '- %s — %s\n' "$slug" "$desc"
    done < "$agents_file"
    echo ""
  done
}

# Helper: build priority agents list (first 5 per division)
build_priority_list() {
  for div in "$@"; do
    local agents_file="$TMPDIR_DATA/${div}.agents"
    [[ -f "$agents_file" ]] || continue
    head -5 "$agents_file" | while IFS=$'\t' read -r slug desc; do
      printf '- %s — %s\n' "$slug" "$desc"
    done
  done
}

# Ordered list for consistent generation
TEAM_ORDER=(team-engineering team-design team-qa team-product team-project-mgmt
            team-marketing team-sales team-paid-media team-game-dev team-spatial team-specialized)

team_count=0
for team in "${TEAM_ORDER[@]}"; do
  divs_str="${TEAM_DIVS[$team]}"
  read -ra divs <<< "$divs_str"
  label="${TEAM_LABELS[$team]}"
  color="${TEAM_COLORS[$team]}"
  emoji="${TEAM_EMOJIS[$team]}"

  agent_list="$(build_agent_list "${divs[@]}")"
  priority_list="$(build_priority_list "${divs[@]}")"

  total_agents=0
  for div in "${divs[@]}"; do
    [[ -f "$TMPDIR_DATA/${div}.agents" ]] && \
      total_agents=$(( total_agents + $(wc -l < "$TMPDIR_DATA/${div}.agents") ))
  done

  cat > "$OPENCODE_AGENTS/${team}.md" <<HEREDOC
---
description: "${emoji} ${label} division coordinator — analyzes tasks and delegates to ${total_agents} specialists. — Invoke via @${team}"
mode: primary
model: google/gemini-3.1-pro-preview-customtools
temperature: 0.2
color: "${color}"
steps: 25
hidden: false
permission:
  ${COORDINATOR_PERMS}
---

## BOOT SEQUENCE

1. Follow rules from \`AGENTS.md\`
2. Use tool hierarchy: mgrep → lsp → grep → glob → read

You are **Team ${label}** — the ${label} division coordinator.
Analyze the task and delegate to the right specialist. **NEVER implement yourself.**

## Your Role

1. **Receive** the task from the user or Orchestrator
2. **Identify** which specialist best fits the task
3. **Delegate** using @[agent-slug] syntax
4. **Coordinate** between specialists when a task spans multiple agents
5. **Synthesize** results into a coherent output for the user

## When to Delegate vs Handle Yourself

- **Delegate:** Any implementation, writing, design, testing, analysis
- **Handle yourself:** Task decomposition, progress tracking, result synthesis
- **Escalate to @orchestrator:** Tasks that span multiple divisions

## Priority Agents

${priority_list}

## All ${label} Agents (${total_agents} total)

${agent_list}

## Delegation Example

\`\`\`
User: "..."
You: @agency-[best-fit-specialist] — [what to ask them]
     @agency-[second-specialist] — [what to ask them in parallel]
\`\`\`
HEREDOC

  (( team_count++ )) || true
  info "Generated: ${team}.md (${total_agents} agents)"
done

info "OpenCode: $team_count team agents generated"

# ==========================================================================
# Step 8: Generate orchestrator.md (primary, knows ALL agents)
# ==========================================================================
header "Step 8: Generating orchestrator.md"

# Build full routing table organized by team
full_routing=""
for team in "${TEAM_ORDER[@]}"; do
  divs_str="${TEAM_DIVS[$team]}"
  read -ra divs <<< "$divs_str"
  label="${TEAM_LABELS[$team]}"
  emoji="${TEAM_EMOJIS[$team]}"

  full_routing+="### ${emoji} ${label} — @${team}"$'\n\n'
  for div in "${divs[@]}"; do
    agents_file="$TMPDIR_DATA/${div}.agents"
    [[ -f "$agents_file" ]] || continue
    while IFS=$'\t' read -r slug desc; do
      full_routing+="- ${slug} — ${desc}"$'\n'
    done < "$agents_file"
  done
  full_routing+=$'\n'
done

total_all=0
for dir in "${AGENT_DIRS[@]}"; do
  [[ -f "$TMPDIR_DATA/${dir}.agents" ]] && \
    total_all=$(( total_all + $(wc -l < "$TMPDIR_DATA/${dir}.agents") ))
done

cat > "$OPENCODE_AGENTS/orchestrator.md" <<HEREDOC
---
description: "🎯 CTO-level orchestrator — decomposes complex tasks and delegates to division teams and specialists across all ${total_all}+ agents. — Invoke via @orchestrator"
mode: primary
model: google/gemini-3.1-pro-preview-customtools
temperature: 0.2
color: "#adb5bd"
steps: 40
hidden: false
permission:
  ${COORDINATOR_PERMS}
---

## BOOT SEQUENCE

1. Follow rules from \`AGENTS.md\`
2. For complex tasks: decompose → delegate in parallel → synthesize

You are the **Orchestrator** — the central coordinator for all ${total_all}+ specialist agents.
Think of yourself as a CTO: you plan, decompose, delegate, and synthesize.
**You NEVER implement code, write content, or do specialist work yourself.**

## Core Responsibilities

1. **Receive** the task — understand what the user truly needs
2. **Decompose** — break into specialist subtasks
3. **Delegate** — assign to the right team or specialist
4. **Parallelize** — run independent tasks simultaneously
5. **Synthesize** — combine results into a coherent output

## Decision Framework

\`\`\`
Is it trivial (< 3 steps)?  → Handle yourself
Within one division?        → Delegate to @team-[division]
Spans multiple divisions?   → Delegate to multiple teams in parallel
Needs specific expert?      → Delegate directly to @agency-[specialist]
\`\`\`

## Delegation Patterns

**Sequential (dependency chain):**
\`\`\`
@agency-software-architect → @agency-backend-architect → @agency-code-reviewer → @agency-api-tester
\`\`\`

**Parallel (independent tasks):**
\`\`\`
@agency-frontend-developer + @agency-backend-architect (simultaneously)
\`\`\`

**Research → Build → Verify:**
\`\`\`
@agency-codebase-explorer → @agency-[specialist] → @agency-reality-checker
\`\`\`

## Example Workflows

**"Build a feature":**
1. @agency-software-architect — design
2. @agency-frontend-developer + @agency-backend-architect (parallel) — implement
3. @agency-code-reviewer → @agency-api-tester — review and test

**"Marketing campaign":**
1. @agency-trend-researcher — research
2. @agency-content-creator + @agency-seo-specialist (parallel) — create
3. @agency-social-media-strategist — distribute

## Division Teams

- @team-engineering — code, architecture, infrastructure, security, DevOps
- @team-design — UX/UI, brand, accessibility, user research
- @team-qa — testing, quality, performance, validation
- @team-product — product management, prioritization, experiments
- @team-project-mgmt — project planning, coordination, delivery
- @team-marketing — content, SEO, social media, growth
- @team-sales — deals, pipeline, accounts, discovery
- @team-paid-media — paid ads, campaigns, attribution
- @team-game-dev — Unity, Unreal, Godot, game design
- @team-spatial — AR/VR/XR, visionOS, spatial interfaces
- @team-specialized — MCP, AI/ML, blockchain, docs, integrations

## Full Agent Roster (${total_all} agents)

${full_routing}
HEREDOC

info "Generated: orchestrator.md (${total_all} agents in roster)"

# ==========================================================================
# Step 9: Generate orchestration skill
# ==========================================================================
header "Step 9: Generating orchestration skill"

mkdir -p "$OPENCODE_SKILLS"
mkdir -p "$CLAUDE_SKILLS"

# Build routing table (compact)
routing_table=""
for team in "${TEAM_ORDER[@]}"; do
  divs_str="${TEAM_DIVS[$team]}"
  read -ra divs <<< "$divs_str"
  label="${TEAM_LABELS[$team]}"
  routing_table+="**${label} (@${team}):**"$'\n'
  for div in "${divs[@]}"; do
    agents_file="$TMPDIR_DATA/${div}.agents"
    [[ -f "$agents_file" ]] || continue
    while IFS=$'\t' read -r slug desc; do
      routing_table+="- ${slug} — ${desc}"$'\n'
    done < "$agents_file"
  done
  routing_table+=$'\n'
done

cat > "$OPENCODE_SKILLS/SKILL.md" <<SKILLEOF
---
name: orchestration
description: Agent orchestration routing table and delegation patterns. Use this skill when deciding which specialist agent to invoke, how to decompose multi-agent tasks, or how to coordinate parallel work across divisions.
---

# Agent Orchestration

## When to Delegate

**Delegate to specialists when:**
- Task requires deep domain expertise
- Task has discrete phases (research → implement → review → test)
- Multiple independent subtasks can run in parallel
- Task is outside your core competency

**Handle yourself when:**
- Task is trivial (< 3 steps, conversational)
- Task is purely informational

## Division Team Leads

| Task Type | Use |
|-----------|-----|
| Implement code / architecture / DevOps | @team-engineering |
| UI/UX design, brand, accessibility | @team-design |
| Testing, QA, performance | @team-qa |
| Product management, prioritization | @team-product |
| Project planning, coordination | @team-project-mgmt |
| Marketing, content, SEO | @team-marketing |
| Sales, deals, pipeline | @team-sales |
| Paid ads, campaigns | @team-paid-media |
| Game development | @team-game-dev |
| AR/VR/XR, visionOS | @team-spatial |
| MCP, AI/ML, blockchain, docs | @team-specialized |

## Delegation Patterns

Sequential: \`architect → developer → reviewer → tester\`
Parallel: \`frontend-developer + backend-architect (simultaneously)\`
Research first: \`codebase-explorer → specialist → reality-checker\`

## Full Routing Table (${total_all} agents)

${routing_table}
SKILLEOF

cp "$OPENCODE_SKILLS/SKILL.md" "$CLAUDE_SKILLS/SKILL.md"
info "Generated: orchestration skill (.opencode/skills/orchestration/ + .claude/skills/orchestration/)"

# ==========================================================================
# Step 10: Generate AntiGravity orchestration workflow
# ==========================================================================
header "Step 10: Generating AntiGravity orchestration workflow"

mkdir -p "$AGENT_WORKFLOWS"

cat > "$AGENT_WORKFLOWS/orchestrate.md" <<'WORKFLOWEOF'
---
name: orchestrate
description: Multi-agent orchestration workflow. Activates when a task requires specialist delegation across multiple domains. Guides through task decomposition and parallel agent invocation.
---

# Orchestration Workflow

## When to Activate

- Task requires expertise from multiple domains
- User asks to "use agents", "delegate", or "orchestrate"
- Task has phases: research → build → review → test
- Task is large enough to benefit from parallelization

## Phase 1: Decompose

Break the task into subtasks by type:
1. Research (→ agency-codebase-explorer / agency-github-code-searcher)
2. Design / Architecture (→ agency-software-architect / agency-ux-architect)
3. Implementation (→ specialist agents per domain)
4. Review / Test (→ agency-code-reviewer / agency-api-tester / agency-reality-checker)

## Phase 2: Route to Specialists

| Task Type | Specialist Skill |
|-----------|-----------------|
| Codebase exploration | agency-codebase-explorer |
| GitHub code examples | agency-github-code-searcher |
| Frontend implementation | agency-frontend-developer |
| Backend implementation | agency-backend-architect |
| Architecture design | agency-software-architect |
| Security review | agency-security-engineer |
| DevOps / CI/CD | agency-devops-automator |
| API testing | agency-api-tester |
| Performance | agency-performance-benchmarker |
| UI/UX design | agency-ux-architect |
| Code review | agency-code-reviewer |
| Documentation | agency-technical-writer |
| Database design | agency-database-optimizer |
| AI/ML features | agency-ai-engineer |
| MCP server | agency-mcp-builder |
| Debugging | agency-debugger |

## Phase 3: Execute

- Independent tasks: invoke skills in parallel
- Dependent tasks: invoke sequentially
- Always research before implementing
- Always review/test after implementing

## Phase 4: Synthesize

1. Collect all agent outputs
2. Identify conflicts or gaps
3. Present unified result to user
4. Ask if additional specialists are needed
WORKFLOWEOF

info "Generated: .agent/workflows/orchestrate.md"

# ==========================================================================
# Step 11: Copy AntiGravity skills from upstream
# ==========================================================================
header "Step 11: Copying AntiGravity skills"

mkdir -p "$ANTIGRAVITY_SKILLS"
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
  warn "AntiGravity integrations not found in upstream — skipping"
fi

# ==========================================================================
# Summary
# ==========================================================================
header "Sync complete!"
echo "  Claude Code:    $count agents          → .claude/agents/"
echo "  OpenCode:       $oc_count agents       → .opencode/agents/"
echo "  Local agents:   $local_count           → all 3 IDEs"
echo "  Team agents:    $team_count            → .opencode/agents/team-*.md"
echo "  Orchestrator:   1                      → .opencode/agents/orchestrator.md"
echo "  Orch. skill:    1                      → .opencode + .claude skills/"
echo "  AG workflow:    1                      → .agent/workflows/"
echo "  AntiGravity:    $ag_count skills       → .agent/skills/"
echo ""
echo "  Upstream:       $UPSTREAM_DIR"
echo ""
info "Done. Project files (AGENTS.md, CLAUDE.md, etc.) are untouched."
