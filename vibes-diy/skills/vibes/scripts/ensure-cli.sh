#!/usr/bin/env bash
# Ensures a working vibes-diy CLI for the vibes skill.
# Persistent install in ${CLAUDE_PLUGIN_DATA}; npx fallback; daily update check.
# Prints: cli:/version:/login: status lines. Never touches system package managers.
set -euo pipefail

PKG_SPEC="${ENSURE_CLI_PKG_SPEC:-vibes-diy@latest}"
DATA_DIR="${CLAUDE_PLUGIN_DATA:-$HOME/.claude/plugins/data/vibes-diy}"
KEYBAG_DIR="${VIBES_KEYBAG_DIR:-$HOME/.fireproof/keybag}"
CLI_DIR="$DATA_DIR/cli"
MARKER="$CLI_DIR/.last-update-check"
BIN="$CLI_DIR/node_modules/.bin/vibes-diy"

if ! command -v node >/dev/null 2>&1; then
  echo "vibes: Node.js is required but was not found on PATH. Install Node.js >= 20 (https://nodejs.org) and retry." >&2
  exit 1
fi

marker_fresh() { [ -f "$MARKER" ] && [ -n "$(find "$MARKER" -mtime -1 2>/dev/null)" ]; }

install_cli() {
  mkdir -p "$CLI_DIR"
  (cd "$CLI_DIR" && npm install --no-fund --no-audit --loglevel=error "$PKG_SPEC" >/dev/null) && touch "$MARKER"
}

if command -v npm >/dev/null 2>&1; then
  if [ ! -x "$BIN" ]; then
    # First-install failure is non-fatal (transient npm error, read-only or
    # unusable data dir): fall through to the npx fallback below instead of
    # dying here under set -e.
    install_cli || true
  elif ! marker_fresh; then
    install_cli || true # update failure is non-fatal; the existing install still works
  fi
fi

if [ -x "$BIN" ]; then
  RUN=("$BIN")
  echo "cli: $BIN"
elif command -v npx >/dev/null 2>&1; then
  RUN=(npx -y "$PKG_SPEC")
  echo "cli: npx -y $PKG_SPEC"
else
  echo "vibes: npm/npx is required but was not found on PATH. Install Node.js >= 20 with npm (https://nodejs.org) and retry." >&2
  exit 1
fi

VERSION="$("${RUN[@]}" --version 2>/dev/null | head -1 || true)"
echo "version: ${VERSION:-unknown}"

if grep -ls '"cert"' "$KEYBAG_DIR"/*.json >/dev/null 2>&1; then
  echo "login: yes"
else
  echo "login: no"
fi
