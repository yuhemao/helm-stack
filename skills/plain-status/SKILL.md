---
name: plain-status
description: "Explain what changed in plain language: Waiting on you (human gates) vs Handled by models (tech already decided). Every waiting item decidable from the reply alone."
license: MIT
metadata:
  author: helm-stack
  version: "1.1.0"
---

# Plain status

## Required sections

1. **Now true** — user-visible outcomes that work
2. **Not true yet** — remaining P0 gaps
3. **Evidence** — verify (+ critique) summary in one short block
4. **Waiting on you** — only human gates (scope, UX/visual taste, conflicting behaviors, money/identity/legal/irreversible, final acceptance click). Each with A/B + recommendation when choosing. If none: say **Nothing waiting on you**.
5. **Handled by models** — one-liners for technical decisions / eng-critique outcomes already taken (optional if nothing notable)
6. **Assumptions I made** — labeled guess/inferred/measured
7. **Next slice** — one sentence
