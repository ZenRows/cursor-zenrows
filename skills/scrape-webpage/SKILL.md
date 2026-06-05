---
name: scrape-webpage
description: Retrieve the content of one specific web page. Use when the user wants to read, fetch, summarize, or get what a single URL says, including pages that block ordinary requests or need JavaScript. Not for discovering the URLs on a site (use map or crawl), not for pulling specific fields like prices or emails (use extract-structured-data), and not for pages that require clicks, logins, or form input (use browser-automation).
---

# Scrape webpage

## Instructions

1. Identify the target URL from the user's message.
2. Call `scrape(url, mode='auto', response_type='markdown')`. Do not read local plugin or MCP config files first.
3. `mode='auto'` handles JavaScript rendering and anti-bot protection automatically, so the same call works for static pages, single-page apps, and protected sites. You do not set `js_render` or `premium_proxy` yourself.
4. Summarize or extract the requested information from the returned markdown.
5. If the content is larger than needed, re-scrape with `css_extractor` targeting only the relevant section. Drop `response_type='markdown'` when you do, since the two are alternatives, not additive.
6. For geo-restricted pages, add `proxy_country` with the target country's ISO 3166 code.
