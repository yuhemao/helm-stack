# Example living product contract (copy to docs/helm-spec.md and edit)
# Thin L0a: what / not / accept — not a full enterprise PRD, not a tech design bible.

## Goal
Paste a long URL, get a short link that redirects.

## Users
Only me (personal tool).

## Problem
I keep losing long links in notes; I want a private shortener.

## Stack constraints
Next.js + Supabase + Vercel. Do not change stack.

## Non-goals
Public multi-tenant SaaS, custom domains, team permissions, analytics dashboard.

## User flows (happy path)
1. Open app → paste URL → create → see short code
2. Visit `/s/{code}` → land on original URL

## Capabilities
- P0: create short link; redirect; list my links; delete
- P1: click counts
- P2: custom alias

## Acceptance criteria

### AC1 Create
- Given I am on the home page
- When I paste `https://example.com` and confirm create
- Then I see a short code and can copy a short URL

### AC2 Redirect
- Given a short code exists for `https://example.com`
- When I open `/s/{code}`
- Then the browser navigates to `https://example.com`

### AC3 Delete
- Given a link appears in my list
- When I delete it
- Then it disappears from the list and its short URL no longer redirects

## Failure modes
- Empty or invalid URL → show an inline error; create nothing
- Unknown short code → show a simple not-found page (no stack trace)

## Assumptions
- [inferred] Single-user; auth can be a simple magic-link or password for one account

## Open product questions
- None for P0
