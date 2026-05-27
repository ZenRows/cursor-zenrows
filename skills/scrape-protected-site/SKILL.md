---
name: scrape-protected-site
description: Handle scraping of anti-bot protected sites. Use when the user mentions blocked, 403, CAPTCHA, anti-bot, LinkedIn, Amazon, Cloudflare, or that a site keeps blocking them.
---

# Scrape protected site

## When to use

- User reports 403, CAPTCHA, or anti-bot blocking
- User mentions protected sites (LinkedIn, Amazon, Cloudflare, etc.)
- Triggers: "blocked", "403", "CAPTCHA", "anti-bot", "it keeps blocking me", "LinkedIn", "Amazon", "Cloudflare"

## Instructions

**Option A — Adaptive Stealth Mode (recommended for unknown or changing sites):**
Use `scrape(url, mode='auto', response_type='markdown')`. ZenRows auto-selects the cheapest viable configuration and escalates only if needed, billing only for the successful attempt. Cannot be combined with `js_render` or `premium_proxy`.

**Option B — Manual escalation (use when you need predictable, fixed configuration):**

1. First attempt: `scrape(url, response_type='markdown')`.
2. If blocked (403, 429, empty body, CAPTCHA detected): `scrape(url, premium_proxy=true, response_type='markdown')`.
3. If content is still empty or JS-dependent: `scrape(url, js_render=true, premium_proxy=true, response_type='markdown')`.
4. For geo-restricted content: add `proxy_country` matching the target region (requires `premium_proxy`).
5. Inform the user of the cost multiplier used (10× for `premium_proxy`, 25× for both flags) so they can make informed decisions.
6. If all options fail, suggest the ZenRows Scraping Browser (`browser_*` tools) for full interactive control.

## Escalation path (manual)

| Step | Flags | Cost |
|------|-------|------|
| 1 | none | 1× |
| 2 | `premium_proxy` | 10× |
| 3 | `js_render` + `premium_proxy` | 25× |
