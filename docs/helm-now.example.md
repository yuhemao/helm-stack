# Now (working memory — not product SoT)

Synced from: docs/helm-spec.md

Active slice: P0 create short link + redirect

Eng decisions this slice:
- Store codes in Supabase table `links` with unique code
- Redirect via `/s/[code]` route handler
- No analytics in this slice (non-goal)

Clear or fully rewrite this file when the slice ends or the product premise changes.
