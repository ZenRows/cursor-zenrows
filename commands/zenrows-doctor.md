---
name: zenrows-doctor
description: Check that the Zenrows MCP connection is live and authorized, and confirm scraping works.
---

# /zenrows-doctor

Report whether Zenrows is connected, authorized, and able to scrape. Steps:

1. Check that the Zenrows MCP tools (`scrape`, `browser_*`) are available in this session. If they are not, the plugin is not connected: confirm it is installed and enabled, fully restart Cursor, and check Settings, Tools and MCP for a `zenrows` entry.
2. If the Zenrows MCP exposes a usage or subscription-status tool, call it and report plan name, remaining credits, and concurrency limit.
3. Otherwise, run a probe: `scrape(url='https://httpbin.io/get', response_type='plaintext', mode='auto')`.
   - Returns content: Zenrows is connected, authorized, and scraping works. Report success.
   - Returns a 401 or an `AUTH` error code: the OAuth login is missing or expired. Tell the user to complete the Zenrows authorization when Cursor shows "Needs login", or, if it is stuck, run "Cursor: Clear All MCP Tokens" from the command palette (Cmd+Shift+P) and re-authorize.
4. Keep the output to a few lines: connection status, auth status, and (if available) plan and credits.
