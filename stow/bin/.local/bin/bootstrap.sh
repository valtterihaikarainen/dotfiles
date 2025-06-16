#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# bootstrap.sh — one-time XDG bootstrap for zsh & Python REPL on macOS
# -----------------------------------------------------------------------------
# Run this script **once per machine** after cloning / copying your dot-files.
# It creates the XDG directory tree and moves any legacy history files so that
# new lean ~/.zshenv doesn’t need to run heavy commands on every shell.
# -----------------------------------------------------------------------------
set -euo pipefail

# 1. Define fallback XDG paths if they aren’t already in the environment.
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# 2. Directory skeleton (idempotent)
mkdir -p "$XDG_CONFIG_HOME"/{python,zsh} \
         "$XDG_STATE_HOME"/{zsh,less} \
         "$XDG_CACHE_HOME"/zsh

echo "Created base XDG directories ✅"

# 3. Python REPL history — move if present, otherwise touch
if [[ -f "$HOME/.python_history" ]]; then
  mv "$HOME/.python_history" "$XDG_STATE_HOME/python_history"
  echo "Moved ~/.python_history  →  $XDG_STATE_HOME/python_history"
fi
: > "$XDG_STATE_HOME/python_history"   # ensure file exists
:
# 4. Less history — move if present, otherwise touch
if [[ -f "$HOME/.lesshst" ]]; then
  mv "$HOME/.lesshst" "$XDG_STATE_HOME/less/history"
  echo "Moved ~/.lesshst  →  $XDG_STATE_HOME/less/history"
fi
: > "$XDG_STATE_HOME/less/history"

# 5. Zsh history — create empty file if absent
: > "$XDG_STATE_HOME/zsh/history"

# 6. Optional: create a minimal Python startup if missing
PYTHONRC="$XDG_CONFIG_HOME/python/pythonrc"
if [[ ! -s "$PYTHONRC" ]]; then
  cat > "$PYTHONRC" <<'PY'
import os, atexit, readline
from pathlib import Path
hist = Path(os.getenv("XDG_STATE_HOME", "~/.local/state")).expanduser() / "python_history"
hist.parent.mkdir(parents=True, exist_ok=True)
try:
    readline.read_history_file(hist)
except FileNotFoundError:
    pass
atexit.register(readline.write_history_file, hist)
PY
  echo "Created default Python startup at $PYTHONRC"
fi

echo "Bootstrap complete ✔︎ — you can now open a new shell."
