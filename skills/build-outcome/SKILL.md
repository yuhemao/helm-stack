---
name: build-outcome
description: "Implement the current vertical slice toward its frozen acceptance criteria, or execute one triaged Must batch in fix mode. Use shape-before-code when the tier calls for it; decide plumbing via decision-budget; hand the snapshot back to the parent's collect round."
license: MIT
metadata:
  author: helm-stack
  version: "1.2.0"
---

# Build outcome

Implement **only** the current slice. Prefer the `builder` model role when configured.

## Build mode (first build of the slice)

1. Resolve L0a (`living-contract.md`); read it and the **slice card** (tier, frozen ACs, envelope smokes) (pasted in your brief, or `docs/helm-now.md`). No card on a `standard`/`high` slice → ask the parent to write one first. The card records the **Slice base** commit (the parent sets it before the first build; if the project has no git, `git init` + commit first).
2. Stay inside **stack constraints**.
3. `shape-before-code` as the tier says (acceptance-gate §2).
4. Apply **decision-budget**: no plumbing questions to the human; uncertain tech → model gate.
5. Smallest change that makes the frozen ACs reachable. Prefer behavior-level checks when cheap. A quick self-check is fine; it is not acceptance.
6. Git checkpoint when the host allows before risky rewrites.
7. When ready: hand the snapshot back to the parent for the **collect round** (`verify-outcome`, then `eng-critique` per tier). Do not self-declare done. Do not call critics yourself.

## Fix mode (after parent triage)

- The parent has made a **checkpoint** (git commit) before the batch; if not, make one first and report its id.
- Input is **one Must batch** from the parent: each item has a repro or failure scenario + expected behavior. Optional small Shoulds may be folded in only if the parent listed them.
- Fix **all** items in this one pass. Do not pull a critique per item; do not start extra review rounds.
- No drive-by features, no work on `Deferred` items.
- Report the **changed-file list** so the parent can scope the narrow re-verify.

## Tier upgrade

If building reveals a `high` trigger (e.g. a destructive data migration, an authz check — see acceptance-gate §2), stop and tell the parent which trigger. The parent upgrades the tier; used fix rounds are not reset.

## Reporting

Speak product language: what the user can try now. Do not paste large diffs unless asked.
