#!/usr/bin/env bash
#
# validate.sh — Project health check script
#
# Usage:
#   bash scripts/validate.sh           # defaults to --quick
#   bash scripts/validate.sh --quick   # fast checks (~30s)
#   bash scripts/validate.sh --full    # all checks including tests and outdated deps
#
# Exit codes:
#   0 = all checks passed
#   1 = one or more checks failed
#
# Used by:
#   - /status workflow (auto-runs --full)
#   - /deploy workflow (auto-runs --quick, blocks on failure)
#   - CI pipelines (optional)

set -euo pipefail

# --- Mode ---
MODE="${1:---quick}"

# --- Colour helpers ---
if [[ -t 1 && -z "${NO_COLOR:-}" && "${TERM:-}" != "dumb" ]]; then
  GREEN=$'\033[0;32m'; YELLOW=$'\033[1;33m'; RED=$'\033[0;31m'; CYAN=$'\033[0;36m'; DIM=$'\033[2m'; BOLD=$'\033[1m'; RESET=$'\033[0m'
else
  GREEN=''; YELLOW=''; RED=''; CYAN=''; DIM=''; BOLD=''; RESET=''
fi

pass() { printf "  ${GREEN}[PASS]${RESET} %s\n" "$*"; }
warn() { printf "  ${YELLOW}[WARN]${RESET} %s\n" "$*"; }
fail() { printf "  ${RED}[FAIL]${RESET} %s\n" "$*"; HAS_FAILURE=1; }
skip() { printf "  ${DIM}[SKIP]${RESET} %s\n" "$*"; }
header() { echo -e "\n${BOLD}${CYAN}$*${RESET}"; }

HAS_FAILURE=0

echo ""
echo "${BOLD}Project Health Check${RESET} (${MODE})"
echo "$(printf '=%.0s' {1..40})"

# ==========================================================================
# Code Quality
# ==========================================================================
header "Code Quality"

# TypeScript type check
if command -v npx &>/dev/null && [[ -f "tsconfig.json" ]]; then
  if npx tsc --noEmit 2>/dev/null; then
    pass "TypeScript: no type errors"
  else
    fail "TypeScript: type errors found (run 'tsc --noEmit' for details)"
  fi
else
  skip "TypeScript: no tsconfig.json or npx not found"
fi

# Lint
if [[ -f "package.json" ]] && grep -q '"lint"' package.json 2>/dev/null; then
  if npm run lint --silent 2>/dev/null; then
    pass "Lint: clean"
  else
    fail "Lint: errors found (run 'npm run lint' for details)"
  fi
elif command -v ruff &>/dev/null && [[ -f "pyproject.toml" || -f "ruff.toml" ]]; then
  if ruff check . 2>/dev/null; then
    pass "Lint (ruff): clean"
  else
    fail "Lint (ruff): errors found"
  fi
else
  skip "Lint: no lint script or linter found"
fi

# ==========================================================================
# Security
# ==========================================================================
header "Security"

# npm audit
if command -v npm &>/dev/null && [[ -f "package-lock.json" ]]; then
  if npm audit --audit-level=high 2>/dev/null | grep -q "found 0 vulnerabilities"; then
    pass "npm audit: no high/critical vulnerabilities"
  else
    audit_output=$(npm audit --audit-level=high 2>/dev/null || true)
    high_count=$(echo "$audit_output" | grep -oP '\d+ high' | head -1 || echo "")
    crit_count=$(echo "$audit_output" | grep -oP '\d+ critical' | head -1 || echo "")
    if [[ -n "$high_count" || -n "$crit_count" ]]; then
      fail "npm audit: ${high_count} ${crit_count} vulnerabilities"
    else
      pass "npm audit: no high/critical vulnerabilities"
    fi
  fi
else
  skip "npm audit: no package-lock.json"
fi

# Secrets in source code
secrets_found=0
for pattern in 'AKIA[0-9A-Z]{16}' 'sk-[a-zA-Z0-9]{20,}' 'ghp_[a-zA-Z0-9]{36}' 'password\s*=\s*["\x27][^"\x27]+["\x27]'; do
  if grep -rn --include="*.ts" --include="*.js" --include="*.py" --include="*.json" \
     -E "$pattern" . --exclude-dir=node_modules --exclude-dir=.git 2>/dev/null | \
     grep -v ".env.example" | grep -v "package-lock.json" | head -1 | grep -q .; then
    secrets_found=1
    break
  fi
done

if [[ $secrets_found -eq 1 ]]; then
  fail "Secrets: potential hardcoded credentials found in source"
else
  pass "Secrets: no hardcoded credentials detected"
fi

# .env in .gitignore
if [[ -f ".gitignore" ]]; then
  if grep -qE '^\s*\.env\s*$' .gitignore 2>/dev/null; then
    pass ".gitignore: .env is excluded"
  else
    warn ".gitignore: .env may not be excluded"
  fi
else
  skip ".gitignore: file not found"
fi

# ==========================================================================
# Tests (--full only)
# ==========================================================================
if [[ "$MODE" == "--full" ]]; then
  header "Tests"

  if [[ -f "package.json" ]] && grep -q '"test"' package.json 2>/dev/null; then
    if npm test --silent 2>/dev/null; then
      pass "Tests: all passing"
    else
      fail "Tests: failures detected (run 'npm test' for details)"
    fi
  elif command -v pytest &>/dev/null; then
    if pytest --tb=no -q 2>/dev/null; then
      pass "Tests (pytest): all passing"
    else
      fail "Tests (pytest): failures detected"
    fi
  else
    skip "Tests: no test runner found"
  fi

  # Coverage (if available)
  if [[ -f "package.json" ]] && grep -q '"test:coverage"' package.json 2>/dev/null; then
    skip "Coverage: run 'npm run test:coverage' for coverage report"
  fi
fi

# ==========================================================================
# Dependencies (--full only)
# ==========================================================================
if [[ "$MODE" == "--full" ]]; then
  header "Dependencies"

  if command -v npm &>/dev/null && [[ -f "package.json" ]]; then
    outdated_output=$(npm outdated 2>/dev/null || true)
    if [[ -z "$outdated_output" ]]; then
      pass "Dependencies: all up to date"
    else
      outdated_count=$(echo "$outdated_output" | tail -n +2 | wc -l | tr -d ' ')
      warn "Dependencies: $outdated_count packages outdated (run 'npm outdated')"
    fi
  else
    skip "Dependencies: no package.json"
  fi
fi

# ==========================================================================
# Git Health
# ==========================================================================
header "Git Health"

if command -v git &>/dev/null && git rev-parse --is-inside-work-tree &>/dev/null; then
  # Uncommitted changes
  if [[ -z "$(git status --porcelain 2>/dev/null)" ]]; then
    pass "Git: working tree clean"
  else
    changed=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')
    warn "Git: $changed uncommitted changes"
  fi

  # Branch up to date
  git fetch --dry-run 2>/dev/null || true
  local_ref=$(git rev-parse HEAD 2>/dev/null || echo "none")
  remote_ref=$(git rev-parse @{u} 2>/dev/null || echo "none")
  if [[ "$local_ref" == "$remote_ref" ]]; then
    pass "Git: up to date with remote"
  elif [[ "$remote_ref" == "none" ]]; then
    skip "Git: no upstream tracking branch"
  else
    warn "Git: not synced with remote"
  fi
else
  skip "Git: not a git repository"
fi

# ==========================================================================
# Summary
# ==========================================================================
echo ""
echo "$(printf '=%.0s' {1..40})"
if [[ $HAS_FAILURE -eq 1 ]]; then
  echo "${RED}${BOLD}Result: ISSUES FOUND${RESET}"
  echo "Fix [FAIL] items before deploying."
  exit 1
else
  echo "${GREEN}${BOLD}Result: HEALTHY${RESET}"
  exit 0
fi
