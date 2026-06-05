# ZenRows Cursor Plugin

Web data for Cursor. Scrape, crawl, and map any site, run browser automation, and pull structured data, straight from your AI agent in plain English. Powered by the [ZenRows Universal Scraper API](https://docs.zenrows.com/universal-scraper-api/api-reference) and [Scraping Browser](https://docs.zenrows.com/scraping-browser/introduction).

## Prerequisites

- [Cursor](https://cursor.com)
- A [ZenRows account](https://app.zenrows.com/register) to authorize with

## Installation

### 1. Install the plugin

Install ZenRows from the Cursor Marketplace.

### 2. Authorize

The plugin adds the hosted ZenRows MCP server. After installing, open Settings, Tools and MCP, find the `zenrows` server, click “Connect”, and complete the ZenRows authorization in your browser. Cursor stores and refreshes the token for you.

### 3. Verify

Run `/zenrows-doctor` in a chat to confirm the connection is live and authorized, or just ask the agent “fetch https://httpbin.io/get” and watch it scrape. If the connection looks stuck, open the command palette (Cmd+Shift+P), run “Cursor: Clear All MCP Tokens”, restart Cursor, and re-authorize.

## Usage examples

| Prompt | What the agent does |
|--------|---------------------|
| Fetch the OpenAI streaming docs and tell me how to stream responses. | Scrapes the page and summarizes the streaming section. |
| Scrape competitor.com/pricing and compare it to ours. | Scrapes and parses the pricing into a comparison. |
| Get all the product links from shop.example.com/phones. | Extracts links from the page. |
| Map the URLs on docs.example.com. | Lists the site's URLs from its sitemap. |
| Crawl all the pages under example.com/guide. | Follows internal links and collects each page. |
| Extract every email address from dir.example.com. | Returns a deduplicated email list. |
| Log into this site, open the first result, and give me its content. | Runs a browser session through the steps. |
| What internal API does this page use to load its data? | Inspects the page's network calls and surfaces the endpoint. |

## What's included

| Component | Purpose |
|-----------|---------|
| `rules/zenrows.mdc` | Always-on guidance for tool selection and safe use |
| `skills/` | Task workflows: scrape, extract, crawl, map, browser automation, API discovery, getting started |
| `commands/zenrows-doctor.md` | `/zenrows-doctor` connection and auth check |
| `.mcp.json` | Connects to the hosted ZenRows MCP server over OAuth |

## Links

- [ZenRows MCP documentation](https://docs.zenrows.com/integrations/mcp/mcp-overview)
- [Create a ZenRows account](https://app.zenrows.com/register)

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT, see [LICENSE](LICENSE).
