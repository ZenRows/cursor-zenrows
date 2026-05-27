# ZenRows Cursor Plugin

Web scraping for Cursor. Fetch any webpage — JS-rendered, anti-bot protected, geo-restricted — directly from your AI agent. Powered by the [ZenRows Universal Scraper API](https://docs.zenrows.com/universal-scraper-api/api-reference) and [Scraping Browser](https://docs.zenrows.com/scraping-browser/introduction).

Install this plugin and ask your agent to scrape a URL in plain English. No scraping code, proxy setup, or anti-bot configuration required — just your ZenRows API key.

## Prerequisites

- [Cursor](https://cursor.com) with plugin/MCP support
- [Node.js](https://nodejs.org/) 18 or later (required for `npx -y @zenrows/mcp`)
- A [ZenRows API key](https://app.zenrows.com/register)

## Installation

### 1. Install the plugin

Install from the Cursor Marketplace (when listed) or add this repository as a local plugin during development.

### 2. Set your API key

Set `ZENROWS_API_KEY` as an environment variable. Cursor passes it to the MCP server when it starts.

**Do not** commit your API key to this repository or any project you share.

**macOS / Linux (zsh):**

```bash
echo 'export ZENROWS_API_KEY=”your_api_key_here”' >> ~/.zshrc
source ~/.zshrc
```

**macOS / Linux (bash):**

```bash
echo 'export ZENROWS_API_KEY=”your_api_key_here”' >> ~/.bashrc
source ~/.bashrc
```

**Windows (PowerShell — current user):**

```powershell
[System.Environment]::SetEnvironmentVariable(“ZENROWS_API_KEY”, “your_api_key_here”, “User”)
```

Fully quit and reopen Cursor after setting the variable.

#### macOS: launching Cursor from the Dock

Shell RC files (`.zshrc`, `.bashrc`) are only sourced for interactive terminal sessions — not when Cursor is opened from the Dock or Spotlight. If MCP shows as disconnected after the steps above, set the variable at the system level with `launchctl`:

```bash
launchctl setenv ZENROWS_API_KEY “your_api_key_here”
```

This takes effect immediately for any app you open next. It persists until reboot — re-run it after a restart, or add it to a login script.

Alternatively, always open Cursor from the terminal where the variable is already set:

```bash
open -a Cursor
# or, to open a project directly:
cursor /path/to/project
```

### 3. Verify MCP connection

In Cursor, go to **Settings → Tools → MCP** and confirm **zenrows** is connected (green, with tools enabled).

To test the MCP server manually (optional):

```bash
node scripts/run-mcp.mjs
# should print: ZenRows MCP server running on stdio
# Ctrl+C to exit — waiting on stdio with no further output is normal
```

This script reads `~/.zenrows.env` as a fallback if `ZENROWS_API_KEY` is not already in your environment — useful for quickly verifying the MCP server starts without touching your shell config.

## Usage examples

After installing, try these prompts in a Cursor agent conversation:

| Prompt | What the agent does |
|--------|---------------------|
| Fetch the OpenAI API docs at platform.openai.com/docs and tell me how to stream responses. | `scrape()` with markdown output; summarizes the streaming section. |
| Scrape the pricing page at competitor.com and compare it to our pricing. | `scrape()` → parses pricing table → structured comparison. |
| Get all the product listings from shop.example.com/phones | `scrape()` with `autoparse=true` or `css_extractor` → structured JSON. |
| That page is blocking me — can you retry with proxies? | Escalates to `premium_proxy=true`; informs you of the 10× cost multiplier. |
| Extract all email addresses from dir.example.com | `scrape()` with `outputs='emails'` → deduplicated email list. |
| Go to this search page, enter "GraphQL", click the first result, and give me its content. | `browser_navigate` → `browser_fill` → `browser_click` → summarize. |
| Take a screenshot of how this page looks right now. | `scrape()` with `screenshot_fullpage=true` → returns image. |
| What internal API does Hacker News use to load its stories? | Browser session + network inspection → surfaces API endpoint. |

## What's included

| Component | Purpose |
|-----------|---------|
| `.mcp.json` | Wires `@zenrows/mcp` via local stdio |
| `rules/zenrows.mdc` | Always-on cost-aware scraping guidance |
| `skills/` | Five task workflows: scrape, protected sites, extraction, browser automation, API discovery |

## Limitations

### Concurrency

ZenRows plans have concurrency limits (e.g. 5 on Developer, up to 250 on higher plans). The agent may fire multiple tool calls in parallel — especially with `browser_*` tools. Browser sessions should be closed promptly with `browser_close`.

### Cancelled requests

If you cancel a Cursor agent task mid-flight, ZenRows may continue processing the request server-side for up to 3 minutes. This consumes a concurrency slot until it completes. This is ZenRows API behavior, not a plugin bug.

### Response size

Plan-based response size limits apply (5–50 MB). For large pages, the agent uses `css_extractor` or `response_type: markdown`. If you get a 413 error, ask for targeted extraction instead of the full page.

## Development

Validate plugin structure before submit:

```bash
node scripts/validate-template.mjs
```

## Links

- [ZenRows MCP documentation](https://docs.zenrows.com/integrations/mcp/mcp-overview)
- [ZenRows MCP on npm](https://www.npmjs.com/package/@zenrows/mcp)
- [Get your API key](https://app.zenrows.com/register)
- [Cursor Marketplace — publish](https://cursor.com/marketplace/publish)
- [Cursor plugin docs](https://cursor.com/docs/reference/plugins)

## License

MIT — see [LICENSE](LICENSE).
