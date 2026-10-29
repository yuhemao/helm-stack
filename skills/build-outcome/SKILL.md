---
name: build-outcome
description: "Implement the current vertical slice toward observable acceptance. Use shape-before-code for non-trivial work; decide plumbing via decision-budget; hand off to eng-critique and verify-outcome."
license: MIT
metadata:
  author: helm-stack
  version: "1.1.0"
---

# Build outcome

Implement **only** the current slice. Prefer the `builder` model role when configured.

## Rules

1. Resolve L0a (`living-contract.md`); read it and the active slice ACs (and `docs/helm-now.md` if present).
2. Stay inside **stack constraints**.
3. Non-trivial slice → ensure **`shape-before-code`** already ran (or run it now). Trivial → `skip` with reason.
4. Apply **decision-budget**: no plumbing questions to the human; uncertain tech → model gate.
5. Smallest change that makes the ACs reachable. Prefer behavior-level checks when cheap.
6. Git checkpoint when the host allows before risky rewrites.
7. When implementation is ready: hand off to **`eng-critique`**, then **`verify-outcome`** (or run them if the playbook says so). Do not self-declare done.

## Reporting

Speak product language: what the user can try now. Do not paste large diffs unless asked.
