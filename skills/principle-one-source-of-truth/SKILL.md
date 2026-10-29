---
name: principle-one-source-of-truth
description: "Keep a thin product write-path (living contract or adopted PRD); allow disposable working memory; treat code/tests as technical truth. Use when docs proliferate or chat disagrees with files."
license: MIT
metadata:
  author: helm-stack
  version: "1.1.2"
---

# Thin authority (one write-path)

The failure mode is **many authoritative process docs** — including **PRD + helm-spec duplicates** — that must all be edited when the premise changes.

## Layers

| Layer | What | Where | On premise change |
|---|---|---|---|
| **L0a Product authority** | Goal, users, non-goals, stack, P0, observable ACs, open **product** questions | **Resolved path** (see helm-mode `references/living-contract.md`) — often `docs/PRD.md` or `docs/helm-spec.md` | **Rewrite that one file** |
| **L0b Technical authority** | Real behavior and regressions | Code + runnable checks | Fix code/tests — no parallel architecture bible |
| **L1 Working memory** | Active slice, short eng assumptions | Optional `docs/helm-now.md` | Delete or fully rewrite |
| **L2 Disposable** | Scratch plans, bakeoffs | Chat / `docs/_scratch/` | Do not sync |

When chat, memory, and files disagree on **product** truth: update the **resolved L0a**, then that file wins.

## Rules

- Forbidden: parallel product authorities (`PRD.md` + `helm-spec.md` both treated as truth with copied content).
- Allowed: one L0a (PRD **or** helm-spec **or** pointed path) + optional L1 + code/tests as L0b.
- Prefer `docs/helm.contract` to pin the path for Codex and new sessions.
- Prefer deleting sections over opening a second authority file.

Steer phrase: `apply one-source-of-truth` or `apply thin-authority`
