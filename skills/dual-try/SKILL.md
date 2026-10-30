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

- Only on `standard` or `high` slices. A `simple` change does not get a bakeoff.
- Each attempt: **one** `verify-outcome`, **no** fix rounds.
- Eng-fork: **one** shared `eng-critique` across both attempts — not one per attempt.
- The keeper then runs a normal collect round with the full fix-round budget.

## Steps

1. Freeze shared ACs (2–4) and stack constraints in the slice card. Label fork **ux** or **eng**.
2. Attempt A and Attempt B — time-boxed, thin, demoable (separate worktrees/dirs when the host allows).
3. Verify both with the same rubric (`verify-outcome`), once each.
4. Eng-fork: run one `eng-critique` across both; pick by AC pass → fewer admitted Musts → simpler maintainability.
5. Ux-fork: pick by AC pass; only escalate taste ties to the operator.
6. Discard or quarantine the loser. Update the resolved L0a if product truth changed; refresh `docs/helm-now.md` or delete it.
