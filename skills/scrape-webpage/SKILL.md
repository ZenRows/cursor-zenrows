---
name: scrape-webpage
description: General-purpose web content retrieval. Use when the user asks to fetch, scrape, get content from, read the page at, summarize the docs at, or what a website says about a topic.
---

# Scrape webpage

## When to use

- User wants to read or summarize a webpage
- User asks to fetch docs, articles, blog posts, or changelogs
- Triggers: "fetch", "scrape", "get content from", "read the page at", "summarize the docs at", "what does X website say about"

## Instructions

1. Identify the target URL from the user's message.
2. Call the `scrape` MCP tool — do not read local plugin or MCP config files first.
3. Start with `scrape(url, response_type='markdown')` — no extra flags.
4. If the response is empty or contains a JS-required error message, retry with `js_render: true`.
5. Summarize or extract the requested information from the returned markdown.
6. If the content is larger than needed, re-scrape using `css_extractor` targeting only the relevant section — drop `response_type='markdown'` when doing so, as the two are alternatives not additive.

## Cost note

Start at 1× cost. Only add `js_render` (5×) when content is missing or the page is a known SPA.
