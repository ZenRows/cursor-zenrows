# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.0] - 2026-08-26

### Added

- `batch` skill covering the `batch_create`, `batch_status`, `batch_wait`, `batch_results` and `batch_cancel` tools, for processing a known list of URLs as one managed job.

### Changed

- `extract-structured-data` now uses the dedicated `extract` tool instead of `scrape` parameters, and documents the `mode` / `mode_auto` distinction and the Extract open-beta `AUTH010` fallback.
- `rules/zenrows.mdc` lists the full hosted tool surface: `scrape`, `extract`, `batch_*` and `browser_*`. It previously named only `scrape` and `browser_*`, so agents were not told Extract and Batch existed.
- Product naming brought to the current primitives: Fetch, Extract, Batch and Browser Sessions. "Universal Scraper API" and "Scraping Browser" removed.
- Brand spelling standardised on "Zenrows".
- MCP config renamed from `.mcp.json` to `mcp.json`, the filename Cursor's plugin template expects.
- `scripts/local-install.sh` now symlinks into `~/.cursor/plugins/local/zenrows`, Cursor's documented local plugin path. It previously copied to `~/.cursor/plugins/zenrows` and wrote to `~/.claude`.
- Documentation links updated to the current docs paths.

### Removed

- `.zenrows.env.example`. The plugin authenticates by OAuth and never uses `ZENROWS_API_KEY`.

## [0.1.0] - 2026-05-28

### Added

- Initial Cursor plugin for Zenrows
- Connects to the hosted Zenrows MCP server over OAuth (no API key, no environment variable, no local server)
- Always-on rule (`rules/zenrows.mdc`) covering tool selection, security, and error handling
- Task skills: `scrape-webpage`, `extract-structured-data`, `crawl`, `map`, `browser-automation`, `capture-api-calls`, `getting-started`
- `/zenrows-doctor` command to check connection and authorization status
- `AGENTS.md` orientation for contributors and coding agents

### Notes

- Authentication is handled by the MCP client via OAuth. Cursor opens a browser for login and refreshes the token automatically. End users do not need Node.js, since there is no local server to launch.
- `scrape` defaults to `mode='auto'` (Adaptive Stealth Mode), which manages JavaScript rendering and anti-bot escalation automatically and bills only for the configuration that succeeds.
- Bulk skills (`crawl`, `map`) write output to a gitignored `./.zenrows/` directory and read it incrementally rather than loading it into context.
