---
name: plain-status
description: "Explain what changed in plain language: Waiting on you (human gates) vs Handled by models (tech already decided). Includes the acceptance-gate exit state and fixed stop options. Every waiting item decidable from the reply alone."
license: MIT
metadata:
  author: helm-stack
  version: "1.2.0"
---

# Plain status

## Required sections

1. **Now true** — user-visible outcomes that work
2. **Not true yet** — remaining P0 gaps
3. **Evidence** — one short block: verify table summary (+ critique summary), the gate's exit state (`PASS` / `STOP: budget` / `STOP: no-progress` / `partial`), and `Fix rounds n/N`
4. **Waiting on you** — only human gates (scope, UX/visual taste, conflicting behaviors, money/identity/legal/irreversible, final acceptance click, **stop options**). Each with A/B + recommendation when choosing. If none: say **Nothing waiting on you**.
5. **Handled by models** — one-liners for technical decisions / eng-critique outcomes already taken, including the tier and its trigger (optional if nothing notable)
6. **Assumptions I made** — labeled guess/inferred/measured
7. **Deferred** — one line per item moved out of this slice (and which ones went to L0a)
8. **Next slice** — one sentence

## Stop options (when the gate stopped)

Write them in product language — what users would see — never as technical diagnosis:

```text
Waiting on you — this slice stopped (<budget used | no progress>):
<one sentence: what works, what a user would still hit>
A. Accept what works now; move "<failing behavior>" to the next slice  (recommended when …)
B. Allow one more fix round
C. Drop or rewrite this requirement
D. Rethink the approach (the premise may be wrong)
```

Under a full-autonomy grant, do not ask: state that **A** was applied by default and what they can override.
