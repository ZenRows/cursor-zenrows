---
name: getting-started
description: First-run setup and troubleshooting for the Zenrows plugin. Use when the plugin was just installed, scraping is not working, a Zenrows tool is missing or "not available", the connection shows "Needs login" or "disconnected", or the user asks whether Zenrows is set up. Not for normal scraping tasks once the plugin works (use scrape-webpage).
---

# Getting started

Run the checks below. Do the work; do not just print instructions. Zenrows authenticates through OAuth in the client, so there is no API key to set.

## 1. Probe the connection

First confirm the Zenrows MCP tools (`scrape`, `browser_*`) are available in this session.

- Tools missing entirely: the MCP server is not connected. Check that the plugin is installed and enabled, that Cursor was fully restarted, and that Settings, Tools and MCP shows a `zenrows` entry.
- Tools present: call `scrape(url='https://httpbin.io/get', response_type='plaintext', mode='auto')` and branch:
  - 200 with a body: Zenrows is working. Go to step 2.
  - 401, or an `AUTH` error: the OAuth login is missing or expired. Tell the user to complete the Zenrows authorization when Cursor shows "Needs login" next to the server, or, if the connection is stuck, run "Cursor: Clear All MCP Tokens" from the command palette (Cmd+Shift+P) and re-authorize, then retry.

## 2. First successful scrape

Run `scrape(url='https://www.scrapingcourse.com/ecommerce/', mode='auto', response_type='markdown')` and show the user the first 10 lines. This confirms the full path works and demonstrates `mode='auto'` as the default.

## 3. Where to go next

Offer three copy-ready prompts:

- "Fetch the docs at <url> and summarize the key points."
- "Get all the product links from <url>."
- "Map the URLs on <host>."

## Notes

- Error-code reference: search the code (for example `AUTH002` or `REQS002`) at https://docs.zenrows.com.
- Once the plugin is working, hand normal tasks to the capability skills: `scrape-webpage`, `extract-structured-data`, `crawl`, `map`, `browser-automation`, `capture-api-calls`.
