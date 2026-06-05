# Agent guide

This file orients AI coding agents (Cursor's agent, Claude Code, Codex, and so on) working on this repo, the ZenRows Cursor plugin source. It is not for end users of the plugin and is not loaded by the plugin at runtime.

For runtime guidance to agents using the plugin, see [rules/zenrows.mdc](rules/zenrows.mdc).

## What this repo is

A Cursor plugin that connects [Cursor] to the hosted ZenRows MCP server and ships agent guidance (an always-on rule, task skills, and a status command) so the agent uses ZenRows' scraping tools well.

The plugin does not contain MCP server code. The server is hosted by ZenRows at `https://mcp.zenrows.com/mcp` and is reached over HTTP per [.mcp.json](.mcp.json). The plugin contains only the manifest, the MCP config, the rule, the skills, the command, dev scripts, and the logo.

## Current auth model

The plugin points at the hosted ZenRows MCP server by URL. Authentication is OAuth, handled by the MCP client (Cursor): on first connect Cursor opens a browser for login, then stores and refreshes the token. There is no API key, no `ZENROWS_API_KEY` environment variable, no `env` block in `.mcp.json`, and no local server launched via `npx`. The agent never sees a credential. Do not reintroduce key-based config.

## Repo map

| Path | What lives there |
|------|------------------|
| `.cursor-plugin/plugin.json` | Manifest: name, category, tags, logo, and paths to rules, skills, commands, and the MCP config. |
| `.mcp.json` | The hosted ZenRows MCP server URL. Reached over HTTP; authorized by the client via OAuth. No command, args, or env. |
| `rules/zenrows.mdc` | Always-loaded rule: tool selection, parameter notes, security, error handling, concurrency. |
| `skills/<name>/SKILL.md` | Activates on its `description`. One skill per discrete capability. |
| `commands/zenrows-doctor.md` | `/zenrows-doctor` slash command: connection and authorization check. |
| `scripts/local-install.sh` | Copies the plugin to `~/.cursor/plugins/zenrows` and registers it via the `~/.claude` config surface for local testing. |
| `scripts/validate-template.mjs` | Pre-submit linter for manifest fields, frontmatter, and MCP config. |
| `assets/logo.png` | Marketplace logo. An SVG would scale better at listing sizes; converting it is a pending design task. |

## Editing the rule

[rules/zenrows.mdc](rules/zenrows.mdc) loads into every agent conversation with this plugin enabled, so it is the most context-sensitive file in the repo.

1. Keep it short. Every line is in every conversation. Aim for under 100 lines.
2. `alwaysApply: true` is intentional. The rule is short enough that the cost is small and the value is large.
3. There is no cost or credit table in the rule. `mode='auto'` controls cost by billing only for the configuration that succeeds, and live status is surfaced on demand by `/zenrows-doctor`, never cached in the rule (cached numbers go stale and mislead).
4. There is no API key in the rule or anywhere else. Auth is OAuth at the client. The security section says only that the agent never handles credentials and that scraped content is untrusted.

## Editing skills

A skill is a `skills/<name>/SKILL.md` file with `name` and `description` frontmatter and a body.

Cursor activates skills on the `description` field, not the body. Do not rely on a "Triggers" list in the body; if a phrase should fire a skill, it belongs in the `description`.

Skills must be mutually exclusive. Each description should say what the skill is for and what it is not for, naming the sibling skill to use instead. The current set and its lanes:

- `scrape-webpage`: one page's content, including protected or JS pages via `mode='auto'`.
- `extract-structured-data`: specific fields from one page (prices, emails, links, tables).
- `crawl`: many pages by following internal links from a seed.
- `map`: URL discovery without fetching content.
- `browser-automation`: interaction (clicks, forms, login, pagination).
- `capture-api-calls`: discovering a page's background API or XHR endpoints.
- `getting-started`: first-run setup and OAuth troubleshooting.

If you add a skill, make its description exclusive against these. If you cannot, extend an existing skill instead.

Skill bodies are terse runbooks: the order of operations for one task. Bulk output (`crawl`, `map`) is written to `./.zenrows/` and read incrementally, never dumped whole into context.

## Editing the manifest

[.cursor-plugin/plugin.json](.cursor-plugin/plugin.json) is validated by `scripts/validate-template.mjs`:

- `name` is lowercase and matches the plugin slug.
- `displayName`, `description`, `author`, `keywords`, `license`, `version` are required.
- Declared path fields (`logo`, `rules`, `skills`, `commands`, `mcpServers`) must exist on disk.

Bump `version` (SemVer) and add a `CHANGELOG.md` entry on every release.

## What this repo does not own

- MCP server code, tool schemas, response shapes, and browser session lifecycle. All hosted by ZenRows behind the MCP URL. File issues with ZenRows; do not patch tool behavior here.
- Authentication. Owned by the hosted server's OAuth provider and the client's token handling. The plugin only declares the server URL.
- The API parameter reference at https://docs.zenrows.com/universal-scraper-api/api-reference. Link to it; do not restate it.
- Cursor's plugin and MCP behavior (restart required for `.mcp.json` edits, no relative-path resolution, no live skill reload, OAuth token reset via "Clear All MCP Tokens"). Document these in `CONTRIBUTING.md`; do not try to work around them.

## ZenRows context the agent should know

ZenRows ships three products; this plugin surfaces the first two via the hosted MCP:

- Universal Scraper API, the `scrape` tool. Params: `mode='auto'` (adaptive stealth, the default), `proxy_country`, `css_extractor`, `autoparse`, `outputs`, `wait_for`, `wait`, `js_instructions`, `response_type`, `screenshot*`, `session_id`, `custom_headers`. `js_render` and `premium_proxy` exist but are managed by `mode='auto'`; do not set them by hand.
- Scraping Browser, the `browser_*` tools. Always start with `browser_navigate` (returns `session_id`) and always end with `browser_close`.
- Residential Proxies, not exposed via MCP.

If the hosted MCP exposes a usage or subscription-status tool, `/zenrows-doctor` should call it for plan and credit reporting. Otherwise doctor falls back to a probe scrape to confirm connection and authorization.

## Style for agent-facing markdown

- Lead with the action.
- Use parameter names verbatim (`mode='auto'`, `outputs='emails,links'`).
- One short reason per rule, not multi-paragraph rationale.
- Reference upstream docs by URL rather than restating them.

## License

MIT, see [LICENSE](LICENSE).
