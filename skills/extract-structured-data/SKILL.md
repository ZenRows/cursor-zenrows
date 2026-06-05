---
name: extract-structured-data
description: Pull specific data fields from a page rather than its full content: prices, product attributes, emails, links, or table rows. Use when the user names the fields they want or asks for "all" of a thing on one page. Not for reading a page's prose (use scrape-webpage), not for discovering a site's URLs (use map), and not for collecting many pages (use crawl).
---

# Extract structured data

## Instructions

1. Identify, or infer from context, the specific fields the user needs.
2. Named, clearly structured fields (title, price, SKU): use `css_extractor` with a JSON selector map, for example `'{"title":"h1","price":".price"}'`.
3. Semi-structured pages (articles, listings, product pages): use `autoparse=true`.
4. Bulk content of one type (all links, all emails, all images): use `outputs` (comma-separated types, or `*` for all).
5. Use `mode='auto'` on the underlying call so protected or JS-heavy pages still return.
6. Format the extracted JSON for the user's purpose: display, file export, or code.

## Parameter guide

| Need | Parameter | Example |
|------|-----------|---------|
| Named fields via CSS | `css_extractor` | `'{"title":"h1","price":".price-tag"}'` |
| Auto-structured JSON | `autoparse` | `autoparse=true` |
| Bulk content types | `outputs` | `outputs='emails,links'` or `outputs='*'` |
