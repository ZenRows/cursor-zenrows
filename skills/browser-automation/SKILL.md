---
name: browser-automation
description: Drive a page through steps before its content is available: clicking, filling forms, logging in, paginating, or multi-step navigation that a single fetch cannot do. Use when interaction is required to reach the content. Not for static page reads (use scrape-webpage), and not for passively listing the network or API calls a page makes (use capture-api-calls).
---

# Browser automation

## Instructions

1. Start a session with `browser_navigate(url)`. Save the returned `session_id`.
2. Take a `browser_screenshot(session_id)` to confirm the page loaded.
3. Run the interactions in sequence: `browser_click`, `browser_fill`, `browser_scroll`, `browser_evaluate`, and so on. Use `browser_get_accessibility_tree` to find selectors when unsure.
4. After interacting, capture the result with `browser_get_html` or `browser_screenshot`.
5. Always call `browser_close(session_id)` when done, to free a concurrency slot.

## Session management

- Pass `session_id` to every subsequent `browser_*` call.
- Do not open multiple sessions unless the task requires it.
- Browser sessions hold concurrency slots on the user's plan. Close them promptly.

## When to prefer browser over scrape

| Scenario | Tool |
|----------|------|
| Read a static docs page | `scrape` |
| Log in, then navigate | `browser_*` |
| Click "Load more" pagination | `browser_*` |
| Fill a search form and read results | `browser_*` |
