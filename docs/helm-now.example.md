# Now (working memory — not product SoT)

Synced from: docs/helm-spec.md

## Slice card
Slice: P0 create short link + redirect
Tier: standard — trigger: new `links` table
Frozen AC (at build start): AC1 create link, AC2 redirect works
Envelope smokes (≤3): S1 home page loads
Fix rounds: 0/2
Deferred:
- [product] custom code length → next-slice candidate
- [eng/should] index on links.code

Eng decisions this slice:
- Store codes in Supabase table `links` with unique code
- Redirect via `/s/[code]` route handler
- No analytics in this slice (non-goal)

Clear or fully rewrite this file when the slice ends or the product premise changes. Promote product `Deferred` items once into L0a first.
