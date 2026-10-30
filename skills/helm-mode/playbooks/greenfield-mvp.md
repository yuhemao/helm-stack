# Playbook: Greenfield MVP

For a new app or the first usable version.

## Steps

1. **Restate** — Run `restatement`. Do not build yet.
2. **Spec** — Run `write-spec` (resolve/adopt L0a; create `docs/helm-spec.md` only if no PRD/contract exists). Include stack constraints and non-goals.
3. **Cut** — Run `cut-scope` until P0 fits one weekend of agent work or smaller.
4. **Slice** — Run `vertical-slice`. Pick slice 1 only.
5. **Tier + AC review + freeze** — Pick the tier with its trigger (first slice of a greenfield app is usually `standard`; `high` only if a named trigger applies). Run `product-critique` on slice 1's ACs, then freeze ACs + ≤3 envelope smokes in the slice card (`references/acceptance-gate.md`).
6. **Shape** — `shape-before-code` for slice 1 per tier (model gate).
7. **Build** — `build-outcome` for slice 1. Decide plumbing under decision-budget.
8. **Collect round** — `verify-outcome` ∥ `eng-critique` on the same snapshot (eng-critique per tier). Parent triages with Must admission.
9. **Fix rounds** — One Must batch → `build-outcome` (fix mode) → narrow re-verify. Repeat within budget (`standard` 2). Stop on budget or no-progress.
10. **Gate** — `plain-status` for the operator: Waiting on you vs Handled by models; stop options if the gate stopped. Continue to the next slice only after PASS or an operator choice.
