# Playbook: Fix outcome

For a broken user flow or failing acceptance check. Gate rules: `references/acceptance-gate.md`.

**Carry-over check first:** if the failing behavior is listed as a stopped behavior (slice card or L0a "needs root cause"), only start this playbook on an explicit operator request; under a full-autonomy grant, do not re-attempt it (§7 carry-over). Several failing ACs → **one** run of this playbook covering all of them (one card, one budget).

## Steps

1. **Reproduce** — Restate the failing observable (what they did, what they saw, what should happen). Capture measured evidence; do not ask the operator for technical root cause. If a previous slice stopped, start from its evidence.
2. **Anchor** — Diff the failure against resolved L0a ACs. If the AC is wrong, this is an unfreeze / **change-direction**, not a bug fix.
3. **Root cause** — Trace to the first wrong place (parent with the `shaper` role or a blind comparison — not `eng-critique`). Prefer a failing check that proves the cause before editing widely.
4. **Tier + freeze** — Tier from the root-cause location and its triggers (§2). Inline AC review of the failing AC (is it still right?). Slice card: frozen AC = the failing AC(s); envelope = ≤3 nearby smokes.
5. **Smallest fix** — Checkpoint, then `build-outcome` aimed only at restoring the AC. No drive-by features.
6. **Collect round** — `verify-outcome` on frozen AC + envelope, then `eng-critique` on the fix per tier (if `verify-only` already ran eng-critique on this snapshot, reuse those findings instead). Parent triages with Must admission.
7. **Fix rounds** — Only while there is progress and budget (§7); revert to the checkpoint on oscillation.
8. **Gate** — Report measured evidence via `plain-status`. On a stop, give the stop options with the recommendation §7 fixes for that stop type.
