---
name: dual-try
description: "Run two short attempts at the same slice or UX fork, verify both against shared ACs, and keep the better outcome. Use when the approach is uncertain and extra tokens should buy proof."
license: MIT
metadata:
  author: helm-stack
  version: "1.0.0"
---

# Dual-try

This is lightweight **test-time scaling** / bakeoff — not two permanent products.

## Steps

1. Freeze shared ACs (2–4) and stack constraints.
2. Attempt A and Attempt B — time-boxed, thin, demoable.
3. Verify both with the same rubric (`verify-outcome`).
4. Pick by: AC pass count → clearer failure modes → simpler operator story.
5. Discard or quarantine the loser. Update the living spec if the choice changes product truth.

## Asking the operator

Ask only if **both pass ACs** and the remaining difference is pure taste. Otherwise decide and report.
