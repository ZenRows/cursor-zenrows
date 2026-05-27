---
name: extract-structured-data
description: Extract specific data fields from webpages. Use when the user asks to extract, get all prices, list products, pull emails, find links, or parse a table.
---

# Extract structured data

## When to use

- User wants specific fields, not full page content
- User asks for prices, products, emails, links, or table data
- Triggers: "extract", "get all prices", "list all products", "pull the emails from", "find all links on", "parse the table at"

## Instructions

1. Ask the user (or infer from context) what specific data fields are needed.
2. If fields are clearly structured (price, title, SKU): use `css_extractor` with a JSON selector map, e.g. `'{"title":"h1","price":".price"}'`.
3. If fields are semi-structured (articles, listings, product pages): use `autoparse=true`.
4. If bulk extraction is needed (all links, all emails, all images): use the `outputs` parameter (comma-separated types or `*` for all).
5. Format the extracted JSON for the user's intended purpose (display, file export, or code consumption).

## Parameter guide

| Need | Parameter | Example |
|------|-----------|---------|
| Named fields via CSS | `css_extractor` | `'{"title":"h1","price":".price-tag"}'` |
| Auto-structured JSON | `autoparse` | `autoparse=true` |
| Bulk content types | `outputs` | `outputs='emails,links'` or `outputs='*'` |

## Cost note

Targeted extraction reduces payload size and avoids 413 errors on large pages.
