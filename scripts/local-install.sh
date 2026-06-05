#!/usr/bin/env bash
# Install the ZenRows plugin into Cursor for local testing.
#
# Cursor's IDE has no "load from a local folder" option, so this script does
# what the IDE won't: it copies the plugin into ~/.cursor/plugins/ AND registers
# it via the ~/.claude config surface that Cursor shares with Claude Code.
#
# Auth is OAuth, handled by Cursor. There is no API key or environment variable.
# Re-run after any change, then FULLY restart Cursor (Cmd+Q and reopen). No hot reload.
set -euo pipefail
command -v python3 >/dev/null || { echo "python3 is required"; exit 1; }

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
PLUGIN_NAME="zenrows"
PLUGIN_ID="${PLUGIN_NAME}@local"
TARGET="$HOME/.cursor/plugins/$PLUGIN_NAME"
CLAUDE_PLUGINS="$HOME/.claude/plugins/installed_plugins.json"
CLAUDE_SETTINGS="$HOME/.claude/settings.json"

# 1. Copy plugin files. Absolute install path; relative paths are unreliable.
echo "Copying plugin to $TARGET"
rm -rf "$TARGET"
mkdir -p "$TARGET" "$HOME/.claude/plugins"
for item in .cursor-plugin commands rules skills scripts assets .mcp.json; do
  [[ -e "$REPO_ROOT/$item" ]] && cp -R "$REPO_ROOT/$item" "$TARGET/"
done

# 2. Register in installed_plugins.json (upsert; do not clobber other plugins).
python3 - "$CLAUDE_PLUGINS" "$PLUGIN_ID" "$TARGET" <<'PY'
import json, os, sys
path, pid, ipath = sys.argv[1], sys.argv[2], sys.argv[3]
data = json.load(open(path)) if os.path.exists(path) else {}
if not isinstance(data, dict):
    data = {}
plugins = data.get("plugins", {})
entries = [e for e in plugins.get(pid, [])
           if not (isinstance(e, dict) and e.get("scope") == "user")]
entries.insert(0, {"scope": "user", "installPath": ipath})
plugins[pid] = entries
data["plugins"] = plugins
os.makedirs(os.path.dirname(path), exist_ok=True)
json.dump(data, open(path, "w"), indent=2)
print("Registered", pid)
PY

# 3. Enable in settings.json (upsert).
python3 - "$CLAUDE_SETTINGS" "$PLUGIN_ID" <<'PY'
import json, os, sys
path, pid = sys.argv[1], sys.argv[2]
data = json.load(open(path)) if os.path.exists(path) else {}
if not isinstance(data, dict):
    data = {}
data.setdefault("enabledPlugins", {})[pid] = True
os.makedirs(os.path.dirname(path), exist_ok=True)
json.dump(data, open(path, "w"), indent=2)
print("Enabled", pid)
PY

cat <<'NOTE'

Done. Next:
  1. If rules/skills/commands do not appear after restart, turn on
     "Include third-party Plugins, Skills, and other configs" under
     Settings > Features.
  2. Fully quit Cursor (Cmd+Q) and reopen.
  3. In Settings > Tools and MCP, click "Needs login" next to zenrows and
     authorize in the browser (OAuth). No API key is involved.
  4. Verify with /zenrows-doctor, then try: "fetch https://httpbin.org/get".
     If the connection hangs, run "Cursor: Clear All MCP Tokens", restart,
     and re-authorize.
NOTE
