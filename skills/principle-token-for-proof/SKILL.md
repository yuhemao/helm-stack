---
name: principle-token-for-proof
description: "Spend extra tokens on one high-signal round of oracles (AC review, verify, bounded eng-critique, dual-try when warranted)—not on planning prose, interviewing the operator about tech, or unbounded fix→verify loops. Use when choosing test-time scaling."
license: MIT
metadata:
  author: helm-stack
  version: "1.2.0"
---

# Token for proof

Extra inference budget buys **first-round, high-signal oracles**, not longer documents and not more rounds:

1. **`product-critique`** — AC review before build, so the target is right before code exists
2. **`shape-before-code`** — settle structure when the tier calls for it
3. **`verify-outcome`** — measured proof; the primary oracle
4. **`eng-critique`** — one bounded independent review on the same snapshot as verify
5. **`dual-try`** — bakeoff with shared ACs, `standard`/`high` only

Do **not** spend that budget on:

- clarifying interviews the operator cannot answer, or document pyramids
- fix→verify rounds past the slice budget (`simple` 1, `standard` 2, `high` 2)
- re-running critique after each small fix, or one agent per finding
- full-P0 regression after every change

Over budget means **stop and report** (`plain-status` with options), not spend more. See **bounded-loop**.

Steer phrase: `apply token-for-proof`
