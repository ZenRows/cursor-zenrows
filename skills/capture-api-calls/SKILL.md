---
name: capture-api-calls
description: Discover background API endpoints a page uses. Use when the user asks to intercept the API, capture XHR, find what JSON a site fetches, or reverse engineer how data is loaded.
---

# Capture API calls

## When to use

- User wants to know what API a site calls behind the scenes
- User asks to reverse-engineer data loading
- Triggers: "intercept the API", "capture the XHR", "what API does this site call", "get the JSON it fetches", "reverse engineer"

## Instructions

1. Open a browser session with `browser_navigate(url)` and save the `session_id`.
2. Wait for the page to finish loading: `browser_wait(session_id, ms=3000)`. Do not use `browser_wait_for_navigation` here — that must be called *before* a navigation-triggering action, not after `browser_navigate`.
3. Use `browser_evaluate` to collect network resource URLs from the page:

   ```javascript
   JSON.stringify(
     performance.getEntriesByType('resource')
       .filter(r => r.initiatorType === 'fetch' || r.initiatorType === 'xmlhttprequest' || r.name.includes('/api/'))
       .map(r => ({ url: r.name, type: r.initiatorType }))
   )
   ```

4. Identify the API endpoint(s) most likely returning the target data (JSON paths, `/api/` URLs, GraphQL endpoints).
5. Present the endpoint URL, method (if inferable), and sample response structure to the user.
6. Optionally call the discovered endpoint directly via `scrape(url=<api_endpoint>)` — omit `response_type` so the raw JSON response is returned as-is.
7. **Always call `browser_close(session_id)`** when done.

## Fallback

If `performance.getEntriesByType` returns nothing (SPA with deferred loads), interact with the page (scroll, click load triggers) and re-run the evaluate script, or inspect inline `<script>` tags via `browser_get_html`.

## Note

The `@zenrows/mcp` scrape tool does not expose a `json_response` network-capture parameter. Use the browser + evaluate workflow above instead.
