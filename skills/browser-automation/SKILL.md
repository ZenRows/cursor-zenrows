---
name: browser-automation
description: Full browser automation for multi-step interactive tasks. Use when the user asks to click, fill in a form, log in, navigate then click, interact with a page, or step through a workflow.
---

# Browser automation

## When to use

- Task requires multiple steps, form interaction, or session state
- Single `scrape` call is insufficient
- Triggers: "click", "fill in the form", "log in", "navigate to then click", "interact with", "step through"

## Instructions

1. Start a browser session with `browser_navigate(url)`. Save the returned `session_id`.
2. Take a screenshot with `browser_screenshot(session_id)` to visually confirm the page loaded.
3. Execute required interactions in sequence: `browser_click`, `browser_fill`, `browser_scroll`, `browser_evaluate`, etc. Use `browser_get_accessibility_tree` to find selectors when unsure.
4. After interactions, use `browser_get_html` or `browser_screenshot` to capture the result.
5. **Always call `browser_close(session_id)`** when done to free concurrency slots.

## Session management

- Pass `session_id` to every subsequent `browser_*` call.
- Do not open multiple sessions unless the task explicitly requires it.
- Browser sessions consume concurrency slots on the user's ZenRows plan — close promptly.

## When to prefer browser over scrape

| Scenario | Tool |
|----------|------|
| Read a static docs page | `scrape` |
| Log in, then navigate | `browser_*` |
| Click "Load more" pagination | `browser_*` |
| Fill search form and read results | `browser_*` |
