---
name: product-critique
description: "AC review before build: adversarial product check of the slice's acceptance criteria against the living contract (missing ACs, happy-path-only, unobservable ACs, scope creep). Runs once per slice, then the ACs freeze. Prefer a different model or blind pass. Pairs with eng-critique; does not replace it."
license: MIT
metadata:
  author: helm-stack
  version: "1.2.0"
---

# Product critique (AC review)

Review like a skeptical product editor — **before build**, once per slice. Its job is to make the slice's ACs good enough to **freeze**. See [`../helm-mode/references/acceptance-gate.md`](../helm-mode/references/acceptance-gate.md).

**Not** a substitute for `eng-critique`. Do not dump line-by-line code review on the operator.

## When it runs

Once per slice, before build; how heavy (inline / parent / independent) is set by the tier — acceptance-gate §2. After this review the parent re-checks the tier once, then **freezes** the ACs in the slice card. Product-critique does **not** run again on the slice, except an inline re-review of rewritten AC lines on unfreeze (acceptance-gate §4).

## Inputs

Resolve L0a first (`living-contract.md`) — an adopted PRD/spec is valid. Give the reviewer: the living contract + the proposed slice ACs + the envelope smokes. No builder essays.

## Checklist (on the proposed ACs)

- Missing acceptance for a P0 capability this slice claims
- Happy path only; no failure mode where users would notice
- An AC the operator could not judge without reading code (bad — rewrite as observable)
- Scope creep beyond the slice
- Contract and proposed slice disagree
- Security/privacy footguns stated in **product** terms (public data, missing auth) — these may also change the tier to `high`

## Output buckets

- **Must fix (before freeze)** — rewrite/add the AC now; this is cheap because no code exists yet
- **AC-defect** — two ACs the operator wrote contradict each other: do **not** rewrite them yourself; report it to the parent (human gate or autonomy default, acceptance-gate §4)
- **Should fix** — useful; add if it fits the slice appetite, else `Deferred`
- **Ignore now** — non-goal or appetite exceeded

## After freeze

New product observations (from verify, from the operator watching, from anyone) go to the slice card **`Deferred`**, not to this slice's Musts. Exceptions:

- A **hard-risk** finding (security / authz, data loss, secret leak, irreversible) may enter as a Must after freeze.
- An AC proven unreachable or contradictory → unfreeze per acceptance-gate §4 (human gate or `change-direction`), not a new Must.

Do not auto-expand scope while fixing unless the operator lifts non-goals.
