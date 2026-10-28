---
name: cut-scope
description: "Hammer scope to a honest MVP: P0/P1/P2, non-goals, and appetite. Use when the idea is too big, the operator is a non-programmer, or helm-mode needs a shippable first cut."
license: MIT
metadata:
  author: helm-stack
  version: "1.1.0"
---

# Cut scope

Apply a **scope hammer**. Fixed appetite; variable scope.

## Steps

1. List every desired capability.
2. Force-rank into **P0 / P1 / P2**.
3. Move anything not required to prove the core job into **non-goals** for this version.
4. Check P0 can be verified with a short click path.
5. Patch `docs/helm-spec.md` — do not create `scope-v2.md`.

## Heuristic

If P0 cannot be explained in 5 bullets and demoed in under 3 minutes of clicking, it is still too big. Cut again.

## Asking the operator

Only ask when two P0 candidates conflict (cannot both fit). Offer A/B + recommendation. Otherwise decide the cut and report it.
