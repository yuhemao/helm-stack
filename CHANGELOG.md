# Changelog

## 1.2.0 — Bounded acceptance loop

Problem (1.1.x field use): even simple features spawned several independent agents, and acceptance turned into many small fix → review → verify cycles. One failure pulled builder, eng-critique and verifier back in, multiplying time and tokens. 1.1 added review accelerators but no acceptance brakes.

### Added

- `principle-bounded-loop` — steer phrase `apply bounded-loop`
- `helm-mode/references/acceptance-gate.md` — the single reference for risk tiers, slice card, freeze, Must admission, collect → triage → fix → re-verify, exit states, regression envelope, parent coordinator rules
- **Risk tiers** `simple` / `standard` / `high` with named triggers; tier sets independent-agent caps (0 / ≤2 / ≤4 per slice; builder not counted) and fix-round budgets (1 / 2 / 2). `high` must cite its trigger; additive migrations are `standard`; an operator's `simple change` cannot override a trigger.
- **Slice card** at the top of `docs/helm-now.md`: tier, frozen ACs, ≤3 envelope smokes, fix rounds, checkpoint, Deferred, stopped behaviors; pasted into every subagent brief
- **Must admission**: a Must needs a frozen-AC violation with evidence, or a hard-risk class with a concrete failure scenario; otherwise Should → Deferred (non-blocking)
- **Exit states** `PASS` / `STOP: budget` / `STOP: no-progress` / `PENDING-HUMAN` / `partial`, with an exact progress definition, checkpoint + revert on oscillation, and stop options A / A′ / B / C / D with a fixed recommendation per stop type
- **Carry-over rule**: a stopped behavior is not re-sliced or re-run as `fix-outcome` for a fresh budget without the operator
- **Hard-risk protection**: hard-risk findings bypass freeze, upgrade `standard` → `high`, and under full autonomy are switched off (A′) rather than accepted
- `evals/scenarios.md` — seven replay scenarios to compare 1.1.2 vs 1.2.0

### Changed

- Default quality loop reordered: product-critique is now a **pre-build AC review** (once, then ACs freeze); verify then eng-critique run on the **same snapshot** in a collect round; eng-critique runs only in collect rounds (no longer a generic model gate); all Musts go to **one** fix batch; re-verify = failed ACs + all envelope smokes + touched areas
- `eng-critique` runs once on `standard` (no rerun after fixes); returns findings only
- `verify-outcome` scope = frozen ACs + envelope; full P0 only in `verify-only` / pre-deploy / on request; detects no-progress and oscillation; BLOCKED costs no budget
- `build-outcome` gains fix mode (executes one Must batch, reports changed files)
- `principle-token-for-proof` buys first-round proof, not more rounds
- `setup-helm`: a role picks a model; it is not a mandate to spawn an agent
- `dual-try`: `standard`/`high` only; one verify per attempt; one shared eng-critique
- All playbooks: removed unbounded "as needed" / "one more loop"; `verify-only` no longer fixes code
- `harness.md` invariants, `terminology.md`, `prompting.md`, `helm-help`, README, guide updated

### Audit

An independent agent simulated the call chains (S1–S8) on the first 1.2 draft and found 2 P0 / 11 P1 / 12 P2 issues (tier boundary conflict, cross-slice budget reset, no hard-risk exception under autonomy, agent cap vs high requirements, undefined "same FAIL", leftover eng-critique routing, and others). This release includes the fixes.

### Unchanged on purpose

- Independent / stronger-model review stays. `high` slices still get full independent verify + eng-critique, and hard-risk findings can bypass the AC freeze.

## 1.1.2

- Adopt existing PRD or spec as L0a without requiring helm-spec
