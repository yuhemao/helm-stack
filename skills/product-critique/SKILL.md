---
name: product-critique
description: "Adversarial product review against the living spec: missing ACs, edge cases, scope creep, and unmet goals. Prefer a different model or blind pass. Use after a slice build and before shipping claims."
license: MIT
metadata:
  author: helm-stack
  version: "1.0.0"
---

# Product critique

Review like a skeptical product editor. **Not** a line-by-line code review for the operator.

## Blindness

If a second agent/model is available, give it: the living spec + the claimed user-visible changes + verify report. Do **not** give it the builder's self-justification essay.

If only one agent exists: start a fresh critique section that may only quote the spec and observable behaviors.

## Checklist

- Missing acceptance for a P0 capability
- Happy path only; no failure modes
- Scope creep beyond the slice
- Spec and behavior disagree
- Operator would need to read code to know if it works (bad)
- Security/privacy footguns stated in product terms (public data, missing auth)

## Output buckets

- **Must fix** — blocks claiming the slice done
- **Should fix** — cheap and user-visible
- **Ignore now** — non-goal or appetite exceeded

Do not auto-expand scope while fixing unless the operator lifts non-goals.
