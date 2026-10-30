# Playbook: Fix outcome

For a broken user flow or failing acceptance check.

## Steps

1. **Reproduce** — Restate the failing observable (what they did, what they saw, what should happen). Capture measured evidence; do not ask the operator for technical root cause. If a previous slice stopped with `STOP: no-progress`, start from that evidence.
2. **Anchor** — Diff the failure against resolved L0a ACs. If the AC is wrong, this is **change-direction**, not a bug fix.
3. **Tier + freeze** — Tier the fix by its triggers (usually `simple` or `standard`; `high` if it touches a named trigger). Slice card: frozen AC = the failing AC(s); envelope = ≤3 nearby smokes.
4. **Root cause** — Trace to the first wrong place (model gate). Prefer a failing check that proves the cause before editing widely.
5. **Smallest fix** — `build-outcome` aimed only at restoring the AC. No drive-by features.
6. **Collect round** — `verify-outcome` on frozen AC + envelope ∥ `eng-critique` on the fix per tier (`simple`: optional inline). Parent triages with Must admission.
7. **Fix rounds** — Within the tier budget (`simple` 1, `standard`/`high` 2); stop immediately on no-progress.
8. **Gate** — Report measured evidence via `plain-status`. On a stop, give the A–D stop options; escalate product A/B only if the contract itself is ambiguous.
