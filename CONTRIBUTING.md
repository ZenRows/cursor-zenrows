# Contributing

## Prerequisites

- [Cursor](https://cursor.com) for testing the plugin
- [Node.js](https://nodejs.org/) 18 or later (to run the validator)
- `python3` (used by the local-install script)
- A [ZenRows account](https://app.zenrows.com/register) to authorize with via OAuth

End users need none of the above except Cursor and a ZenRows account; there is no local server and no API key. Node and python are only for the dev tooling here.

## Local testing in Cursor

Cursor's IDE has no "load from a local folder" option, so `scripts/local-install.sh` does it for you: it copies the plugin into `~/.cursor/plugins/zenrows/` and registers it through the `~/.claude` config surface that Cursor shares with Claude Code. It upserts `~/.claude/plugins/installed_plugins.json` and `~/.claude/settings.json` without clobbering other plugins.

```bash
bash scripts/local-install.sh
```

If your rules, skills, or commands do not appear after a restart, turn on "Include third-party Plugins, Skills, and other configs" under Settings, Features. Then fully quit Cursor (Cmd+Q) and reopen. There is no hot reload, so re-run the script and restart after each change.

Because auth is OAuth, the first time the server connects you authorize in the browser; no key or environment variable is involved. If the connection hangs, run "Cursor: Clear All MCP Tokens" from the command palette, restart, and re-authorize.

This registration path is community-documented and macOS-tested. Paths and the third-party-content toggle may differ on Linux and Windows and across Cursor versions.

## Test the MCP connection outside Cursor

There is no local server to run; the plugin points at the hosted ZenRows MCP. To exercise the tools directly, use the MCP Inspector and connect it to the remote URL, which walks you through the OAuth login:

```bash
npx @modelcontextprotocol/inspector
```

Then add a server with HTTP transport and URL `https://mcp.zenrows.com/mcp`, authorize, and call `scrape`. Verify the inspector's current flags; its UI changes occasionally.

## Validate before a PR

```bash
node scripts/validate-template.mjs
```

Checks manifest fields, frontmatter on every rule, skill, and command, and the MCP config. Must pass.

## What's where

| Path | Purpose |
|------|---------|
| `.cursor-plugin/plugin.json` | Marketplace manifest |
| `.mcp.json` | MCP config: the hosted ZenRows MCP server URL, authorized via OAuth |
| `rules/zenrows.mdc` | Always-on agent rule |
| `skills/<name>/SKILL.md` | Task-specific workflows |
| `commands/zenrows-doctor.md` | `/zenrows-doctor` slash command |
| `scripts/local-install.sh` | Sync and register the plugin for local Cursor testing |
| `scripts/validate-template.mjs` | Pre-submit structure validator |
| `AGENTS.md` | Orientation for AI agents working on this repo |

## Submitting a version

1. Bump `version` in `.cursor-plugin/plugin.json` (SemVer).
2. Add a `CHANGELOG.md` entry.
3. Run `node scripts/validate-template.mjs`; it must pass.
4. Open a PR and merge to `main`. The Cursor Marketplace review team picks up `main` on the next cycle.
