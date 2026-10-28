---
name: write-spec
description: "Create or refresh the single living product spec at docs/helm-spec.md with scope, non-goals, flows, and observable acceptance criteria. Use before building or when the source of truth drifted."
license: MIT
metadata:
  author: helm-stack
  version: "1.0.0"
---

# Write spec

Maintain **one** living spec: `docs/helm-spec.md`.

## Template

```markdown
# <Product name>

## Goal
## Users
## Problem
## Stack constraints
## Non-goals
## User flows (happy path)
## Capabilities (P0 / P1 / P2)
## Acceptance criteria
### AC1 …
- Given …
- When …
- Then …
## Failure modes
## Assumptions (labeled)
## Open product questions
```

## Rules

- Every P0 capability needs at least one **observable** AC (see terminology: Given/When/Then).
- Ban empty adjectives as AC language (*intuitive, scalable, clean*).
- Prefer deleting sections over adding ceremony (no market analysis, no KPI theater).
- If an older conflicting doc exists, merge into this file and mark the other file deprecated in one line — or delete it if the operator agrees / full-autonomy grant allows.
- After writing, summarize changes in plain language for the operator.
