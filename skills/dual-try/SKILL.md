---
name: dual-try
description: "Run two short attempts at the same slice. UX forks may ask the operator if both pass; eng forks are judged by models/eng-critique, never by the operator."
license: MIT
metadata:
  author: helm-stack
  version: "1.2.0"
---

# Dual-try

Lightweight bakeoff — not two permanent products. Classify the fork first:

| Fork type | Who picks the winner |
|---|---|
| **ux-fork** | Shared ACs + measured verify; if both pass and differ on **taste**, ask the operator A/B |
| **eng-fork** | Shared ACs + `verify-outcome` + **`eng-critique`**; model picks — **never ask the human** |

## Budget (bounded-loop)

Rules and agent counting: acceptance-gate §9. In short: `standard`/`high` only; one verify per attempt, no fix rounds; one shared eng-critique across both attempts; the keeper's next collect round is verify-only if that shared review covered the keeper's code.

## Steps

1. Freeze shared ACs (2–4) and stack constraints in the slice card. Label fork **ux** or **eng**.
2. Attempt A and Attempt B — time-boxed, thin, demoable (separate worktrees/dirs when the host allows).
3. Verify both with the same rubric (`verify-outcome`), once each.
4. Eng-fork: run one `eng-critique` across both; pick by AC pass → fewer admitted Musts → simpler maintainability.
5. Ux-fork: pick by AC pass; only escalate taste ties to the operator.
6. Discard or quarantine the loser. Update the resolved L0a if product truth changed; refresh `docs/helm-now.md` or delete it.
