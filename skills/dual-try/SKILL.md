---
name: dual-try
description: "Run two short attempts at the same slice. UX forks may ask the operator if both pass; eng forks are judged by models/eng-critique, never by the operator."
license: MIT
metadata:
  author: helm-stack
  version: "1.1.0"
---

# Dual-try

Lightweight bakeoff — not two permanent products. Classify the fork first:

| Fork type | Who picks the winner |
|---|---|
| **ux-fork** | Shared ACs + measured verify; if both pass and differ on **taste**, ask the operator A/B |
| **eng-fork** | Shared ACs + `verify-outcome` + **`eng-critique`**; model picks — **never ask the human** |

## Steps

1. Freeze shared ACs (2–4) and stack constraints. Label fork **ux** or **eng**.
2. Attempt A and Attempt B — time-boxed, thin, demoable (separate worktrees/dirs when the host allows).
3. Verify both with the same rubric (`verify-outcome`).
4. Eng-fork: run `eng-critique` (or equivalent) across both; pick by AC pass → fewer must-fixes → simpler maintainability.
5. Ux-fork: pick by AC pass; only escalate taste ties to the operator.
6. Discard or quarantine the loser. Update the resolved L0a if product truth changed; refresh `docs/helm-now.md` or delete it.
