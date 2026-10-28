---
name: plain-status
description: "Explain what changed and what needs the operator in plain language, with every waiting item decidable from the reply alone. Use after slices, at gates, or when the operator is lost."
license: MIT
metadata:
  author: helm-stack
  version: "1.0.0"
---

# Plain status

## Required sections

1. **Now true** — user-visible outcomes that work
2. **Not true yet** — remaining P0 gaps
3. **Evidence** — verify results summary
4. **Waiting on you** — only product gates; each with A/B + recommendation
5. **Assumptions I made** — technical defaults, labeled
6. **Next slice** — one sentence

If nothing waits on the operator, say **Nothing waiting on you** explicitly.
