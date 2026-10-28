---
name: product-critique
description: "Adversarial product review against the living product contract: missing ACs, edge cases, scope creep, unmet goals. Prefer a different model or blind pass. Pairs with eng-critique; does not replace it."
license: MIT
metadata:
  author: helm-stack
  version: "1.1.0"
---

# Product critique

Review like a skeptical product editor. Prefer the `product-critic` role when configured.

**Not** a substitute for `eng-critique`. Do not dump line-by-line code review on the operator.

## Blindness

If a second agent/model is available, give it: living contract + claimed user-visible changes + verify report. Do **not** give the builder's self-justification essay.

If only one agent exists: fresh critique section that may only quote the contract and observable behaviors.

## Checklist

- Missing acceptance for a P0 capability
- Happy path only; no failure modes
- Scope creep beyond the slice
- Contract and behavior disagree
- Operator would need to read code to know if it works (bad)
- Security/privacy footguns stated in **product** terms (public data, missing auth)

## Output buckets

- **Must fix** — blocks claiming the slice done
- **Should fix** — cheap and user-visible
- **Ignore now** — non-goal or appetite exceeded

Do not auto-expand scope while fixing unless the operator lifts non-goals.
