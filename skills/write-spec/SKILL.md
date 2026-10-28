---
name: write-spec
description: "Create or refresh the thin living product contract at docs/helm-spec.md (L0a): scope, non-goals, flows, observable ACs. Not a full enterprise PRD and not a tech design bible."
license: MIT
metadata:
  author: helm-stack
  version: "1.1.0"
---

# Write spec (thin living product contract)

Maintain **L0a** at `docs/helm-spec.md`. This is a **thin product contract** (what / not / how to accept) — closer to the useful core of a PRD than to an engineering design doc. It is **not** a multi-file PRD folder and **not** a substitute for code/tests (L0b).

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
## Assumptions (labeled guess / inferred / measured)
## Open product questions
```

Optional section (keep short): `## Delivery slices` — ordered vertical slices, not a task novel.

## Rules

- Every P0 capability needs at least one **observable** AC (Given/When/Then).
- Ban empty adjectives as AC language (*intuitive, scalable, clean*).
- Prefer deleting sections over adding ceremony (no market analysis, no KPI theater, no module design chapters).
- Soft size: if the file grows past ~200 lines of authority, cut or move working detail to `docs/helm-now.md` (L1) — do not open a second L0a.
- Technical unknowns do **not** belong in Open product questions — model gate them.
- If an older conflicting process doc exists, merge product truth into this file and deprecate/delete the other as disposable.
- After writing, summarize changes in plain language for the operator.

## Optional L1

If the slice needs short eng assumptions, create/update `docs/helm-now.md`:

```markdown
# Now (working memory — not product SoT)
Synced from: docs/helm-spec.md
Active slice: …
Eng decisions this slice: …
```

Do not duplicate full ACs here. Clear or rewrite on slice end / premise change.
