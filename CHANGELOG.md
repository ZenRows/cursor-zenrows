# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-05-26

### Added

- Initial Cursor Marketplace plugin for ZenRows
- MCP integration via `@zenrows/mcp` (local stdio)
- Always-on rules for cost-aware scraping (`rules/zenrows.mdc`)
- Five task skills: scrape-webpage, scrape-protected-site, extract-structured-data, browser-automation, capture-api-calls
- README with installation, API key setup, usage examples, and limitations
- API key setup via `~/.zenrows.env` with shell environment variable fallback (`ZENROWS_API_KEY`)
