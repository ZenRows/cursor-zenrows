---
name: zenrows-doctor
description: Check that the Zenrows MCP connection is live and authorized, and confirm scraping works.
---

# /zenrows-doctor

Report whether Zenrows is connected, authorized, and able to scrape. Steps:

1. Check which Zenrows MCP tools are available and report them by primitive: Fetch (`scrape`), Extract (`extract`), Batch (`batch_create`, `batch_status`, `batch_wait`, `batch_results`, `batch_cancel`) and Browser Sessions (`browser_*`). Name any that are missing. If no Zenrows tools are present at all, the plugin is not connected: confirm it is installed and enabled, fully restart Cursor, and check Settings, MCPs for a `zenrows` entry.
2. Run a probe: `scrape(url='https://httpbin.io/get', response_type='plaintext', mode='auto')`.
   - Returns content: Zenrows is connected, authorized, and scraping works. Report success.
   - Returns a 401 or an `AUTH` error code: the OAuth login is missing or expired. Tell the user to complete the Zenrows authorization when Cursor shows "Needs login", or, if it is stuck, run "Cursor: Clear All MCP Tokens" from the command palette (Cmd+Shift+P) and re-authorize.
3. Keep the output to a few lines: connection status, the tools found by primitive, and auth status. The hosted server exposes no usage or credits tool, so do not report plan or credit figures.
