---
name: recover-wrong-turn
description: "Recover from premise failure or document/context swamp: revert the bad slice, rewrite the living spec, discard disposable plans, recommend a fresh thread. Use when earlier assumptions were wrong or maintenance collapsed."
license: MIT
metadata:
  author: helm-stack
  version: "1.0.0"
---

# Recover wrong turn

**Cheap reversal** beats heroic forward patching.

## Steps

1. **Name the premise failure** in one plain paragraph.
2. **Find a baseline** — last known-good git commit or last state that still matched an older correct AC.
3. **Revert the bad slice** (git revert/reset to baseline as the host safely allows; never destroy unrecoverable production data).
4. **Rewrite `docs/helm-spec.md`** so it matches what you still want. Delete or deprecate extra planning files that encode the wrong premise.
5. **Invalidate context** — tell the operator to start a **fresh thread** with only the living spec + current goal. Do not continue the polluted conversation for implementation.
6. **`plain-status`** — what was discarded, what remains true, next playbook to run.

## Forbidden

- "Update all the docs to be consistent" as a multi-hour sync
- Carrying forward a stale task list that assumes the wrong product
- Asking the operator technical archaeology questions
