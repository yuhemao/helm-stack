---
name: principle-one-source-of-truth
description: "Keep a thin product write-path (living contract); allow disposable working memory; treat code/tests as technical truth. Use when docs proliferate or chat disagrees with files."
license: MIT
metadata:
  author: helm-stack
  version: "1.1.0"
---

# Thin authority (one write-path)

The failure mode is **many authoritative process docs** that must all be edited when the premise changes — not "having any written truth."

## Layers

| Layer | What | Where | On premise change |
|---|---|---|---|
| **L0a Product authority** | Goal, users, non-goals, stack constraints, P0, observable ACs, open **product** questions | `docs/helm-spec.md` | **Rewrite this file** (single write-path) |
| **L0b Technical authority** | Real behavior and regressions | Code + runnable checks (tests / verify) | Fix code/tests — do **not** maintain a parallel architecture bible |
| **L1 Working memory** | Active slice, short eng assumptions | Optional `docs/helm-now.md` | **Delete or fully rewrite** — never patch-history it |
| **L2 Disposable** | Scratch plans, bakeoff notes, long design essays | Chat or `docs/_scratch/` marked disposable | **Do not sync** — ignore or delete |

When chat, memory, and files disagree on **product** truth: update **`docs/helm-spec.md`**, then that file wins.

## Rules

- Forbidden: parallel product authorities (`architecture.md` + `tasks-v3.md` + `plan.md` all treated as truth).
- Allowed: one thin L0a + optional one L1 + code/tests as L0b.
- L1 must **not** duplicate full ACs/goals — pointer to L0a + delta for the current slice only.
- Prefer deleting sections over opening a second authority file.

Steer phrase: `apply one-source-of-truth` or `apply thin-authority`
