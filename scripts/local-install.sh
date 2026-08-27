#!/usr/bin/env bash
# Install the Zenrows plugin into Cursor for local testing.
#
# Cursor loads local plugins from ~/.cursor/plugins/local/<name>/.
#
# Cursor's docs suggest symlinking the repo there. That does NOT work: the
# plugin silently fails to load, even after a full quit. Copy instead, and
# re-run this script after every change.
# Reference: https://cursor.com/docs/plugins
#
# Auth is OAuth, handled by Cursor. There is no API key and no environment variable.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
PLUGIN_NAME="zenrows"
TARGET="$HOME/.cursor/plugins/local/$PLUGIN_NAME"

# Only the components the manifest declares. Keeps .git, docs and scripts out.
COMPONENTS=(.cursor-plugin mcp.json rules skills commands assets)

rm -rf "$TARGET"
mkdir -p "$TARGET"
for item in "${COMPONENTS[@]}"; do
  if [[ -e "$REPO_ROOT/$item" ]]; then
    cp -R "$REPO_ROOT/$item" "$TARGET/"
  else
    echo "warning: $item not found in repo, skipping" >&2
  fi
done

echo "Copied plugin to $TARGET"

cat <<'NOTE'

Next:
  1. Fully quit Cursor (Cmd+Q) and reopen. A window reload is not enough for a
     newly added or changed local plugin.
     If components still do not appear, check "Include third-party Plugins,
     Skills, and other configs" under Settings > Features.
  2. Settings > MCPs should list a "zenrows" server. Click "Needs login" and
     complete the Zenrows authorization in your browser (OAuth).
     Expand the server there to see every tool it exposes.
  3. Verify with /zenrows-doctor, then try: "fetch https://httpbin.io/get".
     If the connection hangs, run "Cursor: Clear All MCP Tokens" from the
     command palette, restart, and re-authorize.

  There is no hot reload. Re-run this script and restart after each change.
NOTE
