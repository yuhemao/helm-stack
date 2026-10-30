# Changelog

## 1.2.0 — Bounded acceptance loop

Problem (1.1.x field use): even simple features spawned several independent agents, and acceptance turned into many small fix → review → verify cycles. One failure pulled builder, eng-critique and verifier back in, multiplying time and tokens. 1.1 added review accelerators but no acceptance brakes.

### Added

- `principle-bounded-loop` — steer phrase `apply bounded-loop`
- `helm-mode/references/acceptance-gate.md` — the single reference for risk tiers, slice card, freeze, Must admission, collect → triage → fix → re-verify, exit states, regression envelope, parent coordinator rules
- **Risk tiers** `simple` / `standard` / `high` with named triggers; tier sets independent-agent caps (0 / ≤2 per slice / ≤2 per round) and fix-round budgets (1 / 2 / 2). `high` must cite its trigger.
- **Slice card** at the top of `docs/helm-now.md`: tier, frozen ACs, ≤3 envelope smokes, fix rounds, Deferred
- **Must admission**: a Must needs a frozen-AC violation with evidence, or a hard-risk class with a concrete failure scenario; otherwise Should → Deferred (non-blocking)
- **Exit states** `PASS` / `STOP: budget` / `STOP: no-progress`, plus fixed product-language stop options A–D in `plain-status`
- `evals/scenarios.md` — four replay scenarios to compare 1.1.2 vs 1.2.0

### Changed

- Default quality loop reordered: product-critique is now a **pre-build AC review** (once, then ACs freeze); verify and eng-critique run on the **same snapshot** in a collect round; all Musts go to **one** fix batch; re-verify is narrow
- `eng-critique` runs once on `standard` (no rerun after fixes); returns findings only
- `verify-outcome` scope = frozen ACs + envelope; full P0 only in `verify-only` / pre-deploy / on request; detects no-progress and oscillation; BLOCKED costs no budget
- `build-outcome` gains fix mode (executes one Must batch, reports changed files)
- `principle-token-for-proof` buys first-round proof, not more rounds
- `setup-helm`: a role picks a model; it is not a mandate to spawn an agent
- `dual-try`: `standard`/`high` only; one verify per attempt; one shared eng-critique
- All playbooks: removed unbounded "as needed" / "one more loop"; `verify-only` no longer fixes code
- `harness.md` invariants, `terminology.md`, `prompting.md`, `helm-help`, README, guide updated

### Unchanged on purpose

- Independent / stronger-model review stays. `high` slices still get full independent verify + eng-critique, and hard-risk findings can bypass the AC freeze.

## 1.1.2

- Adopt existing PRD or spec as L0a without requiring helm-spec
