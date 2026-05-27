# Contributing

## Prerequisites

- [Node.js](https://nodejs.org/) 18 or later
- A [ZenRows API key](https://app.zenrows.com/register) in `~/.zenrows.env`

## Local dev loop

Install the plugin into Cursor for live dogfooding:

```bash
bash scripts/local-install.sh
```

This copies the repo into `~/.cursor/plugins/local/zenrows` and rewrites `.mcp.json` with absolute paths (required — Cursor plugin MCP does not resolve relative paths). Fully quit and reopen Cursor after each sync.

Iterate on `rules/zenrows.mdc` or any `skills/*/SKILL.md`, re-run the script, and reopen Cursor to pick up changes. No Node.js restart needed for rules and skills — only for `.mcp.json` changes.

## Validate plugin structure

```bash
node scripts/validate-template.mjs
```

Checks manifest fields, frontmatter on all rules and skills, and MCP config. Run before opening a PR.

## Test the MCP server manually

```bash
node scripts/run-mcp.mjs
# ZenRows MCP server running on stdio
# Ctrl+C to exit
```

Useful for verifying the launcher reads `~/.zenrows.env` and starts `@zenrows/mcp` correctly, without needing Cursor open.

## What's where

| Path | Purpose |
|------|---------|
| `.cursor-plugin/plugin.json` | Marketplace manifest |
| `rules/zenrows.mdc` | Always-on agent rule (cost awareness, tool selection) |
| `skills/*/SKILL.md` | Task-specific agent workflows |
| `.mcp.json` | MCP server config for the published plugin |
| `scripts/local-install.sh` | Sync to local Cursor plugin dir for dogfooding |
| `scripts/run-mcp.mjs` | Standalone MCP launcher for manual testing |
| `scripts/validate-template.mjs` | Pre-submit structure validator |

## Making changes

- **Rules / skills** — edit the markdown, run `local-install.sh`, reopen Cursor, test in an agent conversation.
- **MCP config** — changes to `.mcp.json` require re-running `local-install.sh` and a full Cursor restart.
- **Manifest** — run `validate-template.mjs` after any `plugin.json` edit.

## Submitting a new version

1. Bump `version` in `.cursor-plugin/plugin.json`.
2. Add an entry to `CHANGELOG.md`.
3. Run `node scripts/validate-template.mjs` — must pass.
4. Open a PR; merge to `main`.
5. The Cursor Marketplace review team picks up the updated repo on next review cycle.
