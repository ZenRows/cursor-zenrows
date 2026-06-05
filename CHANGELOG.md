# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2026-05-28

### Added

- Initial Cursor plugin for ZenRows
- Connects to the hosted ZenRows MCP server over OAuth (no API key, no environment variable, no local server)
- Always-on rule (`rules/zenrows.mdc`) covering tool selection, security, and error handling
- Task skills: `scrape-webpage`, `extract-structured-data`, `crawl`, `map`, `browser-automation`, `capture-api-calls`, `getting-started`
- `/zenrows-doctor` command to check connection and authorization status
- `AGENTS.md` orientation for contributors and coding agents

### Notes

- Authentication is handled by the MCP client via OAuth. Cursor opens a browser for login and refreshes the token automatically. End users do not need Node.js, since there is no local server to launch.
- `scrape` defaults to `mode='auto'` (Adaptive Stealth Mode), which manages JavaScript rendering and anti-bot escalation automatically and bills only for the configuration that succeeds.
- Bulk skills (`crawl`, `map`) write output to a gitignored `./.zenrows/` directory and read it incrementally rather than loading it into context.
