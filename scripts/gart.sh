#!/usr/bin/env bash
# GART — Generative Agent Runtime Toolkit
# Unified project management commands
#
# Usage:
#   bash scripts/gart.sh <command>
#
# Commands:
#   validate  — Health-check your project (TypeScript, lint, deps, secrets)
#   sync      — Update 274+ agents from upstream (requires git)
#   doctor    — Diagnose setup issues (coming soon)
#   help      — Show this help message

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

case "${1:-help}" in
  validate)
    if [[ -f "$SCRIPT_DIR/lib/validate.sh" ]]; then
      shift
      bash "$SCRIPT_DIR/lib/validate.sh" "$@"
    else
      echo "Error: validate module not found. Agent sync scripts may not be installed."
      echo "Re-run 'npx gart-build' with sync enabled to install."
      exit 1
    fi
    ;;

  sync)
    if [[ -f "$SCRIPT_DIR/lib/sync-agents.sh" ]]; then
      shift
      bash "$SCRIPT_DIR/lib/sync-agents.sh" "$@"
    else
      echo "Error: sync module not found. Agent sync scripts may not be installed."
      echo "Re-run 'npx gart-build' with sync enabled to install."
      exit 1
    fi
    ;;

  doctor)
    echo "GART Doctor — Setup Diagnostics"
    echo "================================"
    echo ""

    # Check Node.js
    if command -v node &>/dev/null; then
      echo "✓ Node.js $(node -v)"
    else
      echo "✗ Node.js not found — install from https://nodejs.org"
    fi

    # Check npm
    if command -v npm &>/dev/null; then
      echo "✓ npm $(npm -v)"
    else
      echo "✗ npm not found"
    fi

    # Check git
    if command -v git &>/dev/null; then
      echo "✓ git $(git --version | cut -d' ' -f3)"
    else
      echo "✗ git not found — install from https://git-scm.com"
    fi

    # Check Bun (optional, for OpenCode)
    if command -v bun &>/dev/null; then
      echo "✓ Bun $(bun --version)"
    else
      echo "- Bun not found (optional — needed for OpenCode)"
    fi

    # Check Docker (optional, for MCP Docker)
    if command -v docker &>/dev/null; then
      echo "✓ Docker $(docker --version | cut -d' ' -f3 | tr -d ',')"
    else
      echo "- Docker not found (optional — needed for MCP Docker Gateway)"
    fi

    # Check .env
    if [[ -f .env ]]; then
      echo "✓ .env file exists"
    else
      echo "✗ .env file missing — run: cp .env.example .env"
    fi

    # Check agent directories
    echo ""
    echo "Agent directories:"
    [[ -d .claude/agents ]] && echo "  ✓ .claude/agents/ ($(ls .claude/agents/*.md 2>/dev/null | wc -l) agents)" || echo "  - .claude/agents/ not found"
    [[ -d .opencode/agents ]] && echo "  ✓ .opencode/agents/ ($(ls .opencode/agents/*.md 2>/dev/null | wc -l) agents)" || echo "  - .opencode/agents/ not found"
    [[ -d .agent/skills ]] && echo "  ✓ .agent/skills/ ($(ls -d .agent/skills/agency-* 2>/dev/null | wc -l) skills)" || echo "  - .agent/skills/ not found"

    # Check sync availability
    echo ""
    if [[ -f "$SCRIPT_DIR/lib/sync-agents.sh" ]]; then
      echo "✓ Agent sync available (bash scripts/gart.sh sync)"
    else
      echo "- Agent sync not installed (re-run npx gart-build with sync enabled)"
    fi

    echo ""
    echo "Run 'bash scripts/gart.sh validate' for a full project health check."
    ;;

  help|*)
    echo "GART — Generative Agent Runtime Toolkit"
    echo ""
    echo "Usage: bash scripts/gart.sh <command>"
    echo ""
    echo "Commands:"
    echo "  validate  — Health-check your project"
    echo "  sync      — Update 274+ agents from upstream"
    echo "  doctor    — Diagnose setup issues"
    echo "  help      — Show this help message"
    ;;
esac
