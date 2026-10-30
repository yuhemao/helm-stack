---
name: write-spec
description: "Create or refresh the thin living product contract (L0a). Compatible with existing PRD.md or spec.md — adopt in place via living-contract resolution; never duplicate into a second authority file."
license: MIT
metadata:
  author: helm-stack
  version: "1.2.0"
---

# Write spec (thin living product contract)

Maintain **one** L0a file. Compatible names include `PRD.md`, `spec.md`, `helm-spec.md`, or any path in `docs/helm.contract`.

## Resolve path first

Follow [`../helm-mode/references/living-contract.md`](../helm-mode/references/living-contract.md) **before** creating files.

| Finding | Action |
|---|---|
| `docs/helm.contract` points at a file | Edit **that** file |
| Strong `PRD` / `spec` / `helm-spec` already in repo | Adopt it; write `docs/helm.contract`; harden acceptance in place |
| PRD and spec both strong | One human A/B: which is L0a? Pin pointer; do not merge into a third copy |
| None | Create thin `docs/helm-spec.md` and pin `docs/helm.contract` |

**Forbidden:** copy an existing PRD/spec into a new `docs/helm-spec.md` (or the reverse) so two bodies must stay in sync.

## Template (new files only — or when operator asks to restructure)

Adopted PRDs may keep their own headings; map Goal / Non-goals / Acceptance via the living-contract section table. Do not force an English rename war.

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
## Known gaps (stopped / switched-off behaviors; added by the acceptance gate)
```

Optional short `## Delivery slices`.

## Rules

- Every P0 capability needs at least one **observable** AC (Given/When/Then, 验收 checklist, or equivalent).
- Ban empty adjectives (*intuitive, scalable, clean*).
- Prefer deleting ceremony; soft ~200 lines of authority — overflow to `docs/helm-now.md` (L1).
- Technical unknowns → model gate, not human open questions.
- Always state the **resolved L0a path** in the reply so Codex stops hunting for a missing `helm-spec.md`.

## Optional L1

```markdown
# Now (working memory — not product SoT)
Synced from: <resolved L0a path>
Active slice: …
Eng decisions this slice: …
```
