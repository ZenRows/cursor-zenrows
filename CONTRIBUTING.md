# Contributing

## Prerequisites

- [Cursor](https://cursor.com) for testing the plugin
- [Node.js](https://nodejs.org/) 18 or later (to run the validator)
- A [Zenrows account](https://app.zenrows.com/register) to authorize with via OAuth

End users need none of the above except Cursor and a Zenrows account; there is no local server and no API key. Node and python are only for the dev tooling here.

## Local testing in Cursor

Cursor loads local plugins from `~/.cursor/plugins/local/<name>/`. `scripts/local-install.sh` symlinks this repo into that folder, so edits here are picked up without re-copying.

```bash
bash scripts/local-install.sh
```

Then reload the window: command palette (Cmd+Shift+P), "Developer: Reload Window". If rules, skills, or commands still do not appear, turn on "Include third-party Plugins, Skills, and other configs" under Settings, Features, then fully quit Cursor (Cmd+Q) and reopen. Components and MCP config are read at startup, so reload or restart after each change.

Because auth is OAuth, the first time the server connects you authorize in the browser; no key or environment variable is involved. If the connection hangs, run "Cursor: Clear All MCP Tokens" from the command palette, restart, and re-authorize.

Tested on macOS. Paths and the third-party-content toggle may differ on Linux and Windows and across Cursor versions.

## Test the MCP connection outside Cursor

There is no local server to run; the plugin points at the hosted Zenrows MCP. To exercise the tools directly, use the MCP Inspector and connect it to the remote URL, which walks you through the OAuth login:

```bash
npx @modelcontextprotocol/inspector
```

Then add a server with HTTP transport and URL `https://mcp.zenrows.com/mcp` and authorize. The inspector's tool list is the authoritative record of what the hosted server exposes; check it before writing a skill against a tool. Verify the inspector's current flags; its UI changes occasionally.

## Validate before a PR

```bash
node scripts/validate-template.mjs
```

Checks manifest fields, frontmatter on every rule, skill, and command, and the MCP config. Must pass.

## What's where

| Path | Purpose |
|------|---------|
| `.cursor-plugin/plugin.json` | Marketplace manifest |
| `mcp.json` | MCP config: the hosted Zenrows MCP server URL, authorized via OAuth |
| `rules/zenrows.mdc` | Always-on agent rule |
| `skills/<name>/SKILL.md` | Task-specific workflows |
| `commands/zenrows-doctor.md` | `/zenrows-doctor` slash command |
| `scripts/local-install.sh` | Symlink the plugin into Cursor's local plugin folder for testing |
| `scripts/validate-template.mjs` | Pre-submit structure validator |
| `AGENTS.md` | Orientation for AI agents working on this repo |

## Submitting a version

1. Bump `version` in `.cursor-plugin/plugin.json` (SemVer).
2. Add a `CHANGELOG.md` entry.
3. Run `node scripts/validate-template.mjs`; it must pass.
4. Open a PR and merge to `main`.
5. Submit the repository at https://cursor.com/marketplace/publish. Cursor reviews every plugin manually before listing it, and reviews updates too.
