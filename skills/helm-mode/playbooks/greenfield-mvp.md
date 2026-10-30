# Playbook: Greenfield MVP

For a new app or the first usable version. Gate rules: `references/acceptance-gate.md`.

## Steps

1. **Restate** — Run `restatement`. Do not build yet.
2. **Spec** — Run `write-spec` (resolve/adopt L0a; create `docs/helm-spec.md` only if no PRD/contract exists). Include stack constraints and non-goals.
3. **Cut** — Run `cut-scope` until P0 fits one weekend of agent work or smaller.
4. **Slice** — Run `vertical-slice`. Pick slice 1 only.
5. **Tier + AC review + freeze** — Provisional tier with its trigger (§2; additive tables are `standard`). `product-critique` on slice 1's ACs, re-check the tier once, then freeze ACs + envelope smokes in the slice card in `docs/helm-now.md` (§3–4).
6. **Shape** — `shape-before-code` as the tier says.
7. **Build** — `build-outcome` for slice 1. Decide plumbing under decision-budget.
8. **Collect round** — `verify-outcome`, then `eng-critique` per tier, on the same snapshot. Parent triages with Must admission (§5–6).
9. **Fix rounds** — Checkpoint → one Must batch → `build-outcome` (fix mode) → narrow re-verify. Repeat only while there is progress and budget (§7).
10. **Gate** — `plain-status`: Waiting on you vs Handled by models; stop options if the gate stopped. Continue to the next slice only after PASS or an operator choice (or the full-autonomy default in §7).
