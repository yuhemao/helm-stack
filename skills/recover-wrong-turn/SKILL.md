---
name: recover-wrong-turn
description: "Recover from premise failure or document/context swamp: revert slice, rewrite L0a living contract, discard L1/L2, recommend fresh thread. Use when earlier assumptions were wrong."
license: MIT
metadata:
  author: helm-stack
  version: "1.1.0"
---

# Recover wrong turn

**Cheap reversal** beats heroic forward patching and beats "update all the docs."

## Steps

1. **Name the premise failure** in one plain paragraph.
2. **Find a baseline** — last known-good git commit or last state that still matched a correct AC.
3. **Revert the bad slice** (git revert/reset as the host safely allows; never destroy unrecoverable production data).
4. **Rewrite L0a** — `docs/helm-spec.md` matches what you still want.
5. **Discard working memory** — delete or fully rewrite `docs/helm-now.md`; deprecate/delete disposable L2 plans that encoded the wrong premise. Do **not** spend hours syncing a pyramid.
6. **Invalidate context** — recommend a **fresh thread** with only the living contract + current goal.
7. **`plain-status`** — what was discarded, what remains true, next playbook.

## Forbidden

- Multi-hour "make every doc consistent" projects
- Carrying a stale task list that assumes the wrong product
- Asking the operator technical archaeology questions
