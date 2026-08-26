#!/usr/bin/env bash
# Install the Zenrows plugin into Cursor for local testing.
#
# Cursor loads local plugins from ~/.cursor/plugins/local/<name>/, so a symlink
# is enough: edits in this repo are picked up without re-copying.
# Reference: https://cursor.com/docs/plugins
#
# Auth is OAuth, handled by Cursor. There is no API key and no environment variable.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
PLUGIN_NAME="zenrows"
LOCAL_DIR="$HOME/.cursor/plugins/local"
TARGET="$LOCAL_DIR/$PLUGIN_NAME"

mkdir -p "$LOCAL_DIR"

if [[ -L "$TARGET" ]]; then
  rm "$TARGET"
elif [[ -e "$TARGET" ]]; then
  echo "Refusing to replace $TARGET: it exists and is not a symlink." >&2
  echo "Remove or rename it, then re-run this script." >&2
  exit 1
fi

ln -s "$REPO_ROOT" "$TARGET"
echo "Linked $TARGET -> $REPO_ROOT"

cat <<'NOTE'

Next:
  1. Reload Cursor: command palette (Cmd+Shift+P) > "Developer: Reload Window".
     If the rules, skills, or commands still do not appear, fully quit Cursor
     (Cmd+Q) and reopen. You may also need "Include third-party Plugins,
     Skills, and other configs" under Settings > Features.
  2. Settings > Tools and MCP should list a "zenrows" server. Click "Needs
     login" and complete the Zenrows authorization in your browser (OAuth).
     Expand the server there to see every tool it exposes.
  3. Verify with /zenrows-doctor, then try: "fetch https://httpbin.io/get".
     If the connection hangs, run "Cursor: Clear All MCP Tokens" from the
     command palette, reload the window, and re-authorize.
NOTE
