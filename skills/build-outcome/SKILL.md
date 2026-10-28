---
name: build-outcome
description: "Implement the current vertical slice toward observable acceptance. Decide technical plumbing without asking the operator. Use when helm-mode is ready to code a slice."
license: MIT
metadata:
  author: helm-stack
  version: "1.0.0"
---

# Build outcome

Implement **only** the current slice.

## Rules

1. Read `docs/helm-spec.md` and the active slice ACs first.
2. Stay inside **stack constraints**.
3. Apply **decision-budget**: do not ask plumbing questions.
4. Smallest change that makes the ACs reachable.
5. Create a git checkpoint when the host allows (commit) before risky rewrites.
6. When implementation is ready for checking, stop and hand off to **verify-outcome** (or run it yourself if the playbook says so).

## Reporting

Speak product language: what the user can try now. Do not paste large diffs unless asked.
