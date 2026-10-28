# Playbook: Fix outcome

For a broken user flow or failing acceptance check.

## Steps

1. **Reproduce** — Restate the failing observable (what they did, what they saw, what should happen). Capture measured evidence; do not ask the operator for technical root cause.
2. **Anchor** — Diff the failure against `docs/helm-spec.md` ACs. If the AC is wrong, this is **change-direction**, not a bug fix.
3. **Root cause** — Trace to the first wrong place (model gate). Prefer a failing check that proves the cause before editing widely.
4. **Smallest fix** — `build-outcome` aimed only at restoring the AC. No drive-by features.
5. **Eng critique** — `eng-critique` on the fix (skip only if trivial one-liner with reason).
6. **Verify** — `verify-outcome` on the failing AC + nearby regression smoke.
7. **Gate** — Report measured evidence via `plain-status`. If still failing, one more fix loop; then escalate with product A/B only if the contract itself is ambiguous.
