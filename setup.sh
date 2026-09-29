#!/usr/bin/env bash
set -euo pipefail

# ostest — First-time setup
# Usage: ./setup.sh
# Works on Windows (Git Bash / mingw) and on Linux / macOS.

echo "=== ostest Setup ==="
echo

# --- Prerequisites -----------------------------------------------------------
# Probe candidates and keep the first one that actually runs Python 3.8+.
# This skips broken PATH shims (e.g. the Windows Store python3 alias).
PYTHON=""
for candidate in python3 python py; do
  if command -v "$candidate" >/dev/null 2>&1 && \
     "$candidate" -c 'import sys; sys.exit(0 if sys.version_info >= (3, 8) else 1)' >/dev/null 2>&1; then
    PYTHON="$candidate"
    break
  fi
done

if [ -z "$PYTHON" ]; then
  echo "Error: Python 3.8 or newer is required but was not found on PATH." >&2
  echo "Install Python 3.8+ from https://www.python.org/downloads/ and re-run this script." >&2
  exit 1
fi
echo "Using $("$PYTHON" --version 2>&1)"

# --- Directory sanity --------------------------------------------------------
if [ ! -f "src/app.py" ]; then
  echo "Error: run this script from the project root (src/app.py not found)." >&2
  exit 1
fi

# --- Virtual environment -----------------------------------------------------
if [ ! -d ".venv" ]; then
  echo "Creating virtual environment (.venv)..."
  "$PYTHON" -m venv .venv
else
  echo "Virtual environment .venv already exists, skipping."
fi

# Locate the activate script (Windows uses Scripts/, POSIX uses bin/).
ACTIVATE=".venv/bin/activate"
[ -f ".venv/Scripts/activate" ] && ACTIVATE=".venv/Scripts/activate"
echo "Activate it with: source $ACTIVATE"

# --- Dependencies ------------------------------------------------------------
# This project has no third-party dependencies. If a requirements.txt is ever
# added, install from it here.
if [ -f "requirements.txt" ] && grep -qvE '^\s*(#|$)' requirements.txt; then
  echo "Installing dependencies..."
  if [ -f "$ACTIVATE" ]; then
    # shellcheck disable=SC1090
    . "$ACTIVATE"
  fi
  "$PYTHON" -m pip install --upgrade pip
  "$PYTHON" -m pip install -r requirements.txt
else
  echo "No dependencies to install."
fi

# --- Environment -------------------------------------------------------------
if [ ! -f ".env" ]; then
  cp .env.example .env
  echo "Created .env from .env.example"
else
  echo ".env already exists, leaving it untouched."
fi

# --- Done --------------------------------------------------------------------
echo
echo "=== Setup complete! ==="
echo
echo "Next steps:"
echo "  1. Edit .env and fill in GITHUB_TOKEN, DATABASE_URL, and API_KEY"
echo "  2. Activate the environment:  source $ACTIVATE"
echo "  3. Load .env into your shell, then run:  python src/app.py"
echo "  4. Using Claude Code? CLAUDE.md has all the context."
