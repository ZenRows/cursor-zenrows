#!/usr/bin/env bash
# Installs the plugin into Cursor's local plugin directory for dogfooding.
# Run after any change to rules, skills, or .mcp.json to pick up the update.
# Cursor must be fully quit and reopened after each sync.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
LOCAL_PLUGIN="$HOME/.cursor/plugins/local/zenrows"

echo "Syncing ZenRows plugin to $LOCAL_PLUGIN"
rm -rf "$LOCAL_PLUGIN"
cp -R "$REPO_ROOT" "$LOCAL_PLUGIN"

# Cursor plugin MCP cannot resolve relative script paths, so write an absolute
# path into the local copy of .mcp.json.
cat > "$LOCAL_PLUGIN/.mcp.json" <<EOF
{
  "mcpServers": {
    "zenrows": {
      "type": "stdio",
      "command": "node",
      "args": ["$LOCAL_PLUGIN/scripts/run-mcp.mjs"]
    }
  }
}
EOF

echo "Done. Quit Cursor fully (Cmd+Q), reopen, then check Settings → Tools → MCP."
